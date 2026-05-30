import 'package:flutter/material.dart';

import 'package:drift/drift.dart' hide Column;
import 'package:device_frame/device_frame.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prac_res/data/data.dart';
import 'package:prac_res/components/icon_buttons/fitted_icon.dart';
import 'package:prac_res/components/database/query_builder.dart';
import 'package:prac_res/editor_page/components/scene_viewer/components/frame.dart';
import 'package:prac_res/editor_page/editor_page.dart';

class SelectedScenePartIdProvider extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? id) {
    state = id;
  }
}

class NovelSelectedScenePart extends StatelessWidget {
  const NovelSelectedScenePart({super.key});

  static final selectedScenePartIdProvider =
      NotifierProvider<SelectedScenePartIdProvider, int?>(
        SelectedScenePartIdProvider.new,
      );

  static final selectedScenePartProvider = StreamProvider<SceneTimelineItem?>((
    ref,
  ) {
    final sceneGroup = ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider);
    final selectedScenePartId = ref.watch(selectedScenePartIdProvider);

    return (selectedScenePartId != null)
        ? (sceneGroup.sceneTimelineView.select()..where(
                (scenePart) => scenePart.id.equals(selectedScenePartId),
              ))
              .watchSingleOrNull()
              .map(
                (selectedScenePart) => (selectedScenePart != null)
                    ? SceneTimelineItem.fromSceneTimelineViewData(
                        selectedScenePart,
                      )
                    : null,
              )
        : Stream.value(null);
  });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) => ref.watch(selectedScenePartProvider),
      builder: (context, ref, selectedScenePart) => (selectedScenePart != null)
          ? DeviceFrame(
              device: Devices.android.bigPhone,
              screen: Stack(
                children: [
                  Positioned.fill(child: ColoredBox(color: Colors.white)),
                  Positioned.fill(
                    child: NovelScenePartPreview(
                      specifics: selectedScenePart.specifics,
                    ),
                  ),
                ],
              ),
              orientation: Orientation.landscape,
            )
          : SizedBox.shrink(),
    );
  }
}

class NovelScenePartPreview extends StatelessWidget {
  final SceneTimelineItemSpecifics specifics;

  const NovelScenePartPreview({super.key, required this.specifics});

  @override
  Widget build(BuildContext context) {
    return switch (specifics) {
      TimelineFrame(:final frameData) => NovelFrame(frame: frameData),
      TimelineResolver() => NovelFittedIcon(
        icon: Icon(Icons.alt_route_rounded),
        sizePercentage: 0.5,
      ),
      TimelineCustom() => NovelFittedIcon(
        icon: Icon(Icons.build_circle_rounded),
        sizePercentage: 0.5,
      ),
    };
  }
}
