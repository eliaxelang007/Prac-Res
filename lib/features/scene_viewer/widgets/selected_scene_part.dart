import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import 'package:device_frame/device_frame.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/widgets/database/query_builder.dart';
import 'package:prac_res/core/widgets/fitted_icon.dart';
import 'package:prac_res/features/editor/screens/editor_page.dart';
import 'package:prac_res/features/scene_viewer/widgets/custom.dart';
import 'package:prac_res/features/scene_viewer/widgets/frame.dart';

class SelectedScenePartIdNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? newScenePartId) {
    state = newScenePartId;
  }
}

class NovelSelectedScenePart extends StatelessWidget {
  const NovelSelectedScenePart({super.key});

  static final selectedScenePartIdProvider =
      NotifierProvider<SelectedScenePartIdNotifier, int?>(
        SelectedScenePartIdNotifier.new,
      );

  static final scenePartProvider =
      StreamProvider.family<SceneTimelineItem?, int>((ref, scenePartId) {
        final sceneGroup = ref.watch(
          NovelSceneGroupEditorPage.sceneGroupProvider,
        );

        return (sceneGroup.sceneTimelineView.select()
              ..where((scenePart) => scenePart.id.equals(scenePartId)))
            .watchSingleOrNull()
            .map(
              (selectedScenePart) => (selectedScenePart != null)
                  ? SceneTimelineItem.fromSceneTimelineViewData(
                      selectedScenePart,
                    )
                  : null,
            );
      });

  static final selectedScenePartProvider = FutureProvider<SceneTimelineItem?>((
    ref,
  ) async {
    final selectedScenePart = ref.watch(selectedScenePartIdProvider);

    return (selectedScenePart != null)
        ? (await ref.watch(scenePartProvider(selectedScenePart).future))
        : null;
  });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) => ref.watch(selectedScenePartProvider),
      builder: (context, ref, selectedScenePart) {
        return (selectedScenePart != null)
            ? DeviceFrame(
                device: Devices.android.bigPhone,
                screen: SizedBox.expand(
                  child: NovelScenePartPreview(
                    specifics: selectedScenePart.specifics,
                  ),
                ),
                orientation: Orientation.landscape,
              )
            : SizedBox.shrink();
      },
    );
  }
}

class NovelScenePartPreview extends StatelessWidget {
  final SceneTimelineItemSpecifics specifics;

  const NovelScenePartPreview({super.key, required this.specifics});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(color: Colors.black, child: SizedBox()),
        ),
        Positioned.fill(
          child: IconTheme(
            data: Theme.of(context).iconTheme.copyWith(color: Colors.white),
            child: switch (specifics) {
              TimelineFrame(:final frameData) => NovelFrame(frame: frameData),
              TimelineResolver() => NovelFittedIcon(
                icon: Icon(Icons.alt_route_rounded),
                sizePercentage: 0.5,
              ),
              TimelineCustom(:final customData) => NovelCustomScenePart(
                custom: customData,
              ),
            },
          ),
        ),
      ],
    );
  }
}
