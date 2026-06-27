import 'package:flutter/material.dart';

import 'package:device_frame/device_frame.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/widgets/fitted_icon.dart';
import 'package:prac_res/features/editor/widgets/scene_selector.dart';
import 'package:prac_res/features/scene_viewer/widgets/custom.dart';
import 'package:prac_res/features/scene_viewer/widgets/frame.dart';

class SelectedScenePartProvider extends Notifier<SceneTimelineItem?> {
  @override
  SceneTimelineItem? build() => null;

  void set(SceneTimelineItem? newScenePart) {
    if (newScenePart != null) {
      ref
          .read(NovelSceneSelector.selectedSceneIdProvider.notifier)
          .set(newScenePart.part.sceneId);
    }

    state = newScenePart;
  }
}

class NovelSelectedScenePart extends StatelessWidget {
  const NovelSelectedScenePart({super.key});

  static final selectedScenePartProvider =
      NotifierProvider<SelectedScenePartProvider, SceneTimelineItem?>(
        SelectedScenePartProvider.new,
      );

  // static final scenePartProvider =
  //     StreamProvider.family<SceneTimelineItem?, int>((ref, scenePartId) {
  //       final sceneGroup = ref.watch(
  //         NovelSceneGroupEditorPage.sceneGroupProvider,
  //       );

  //       return (sceneGroup.sceneTimelineView.select()
  //             ..where((scenePart) => scenePart.id.equals(scenePartId)))
  //           .watchSingleOrNull()
  //           .map(
  //             (selectedScenePart) => (selectedScenePart != null)
  //                 ? SceneTimelineItem.fromSceneTimelineViewData(
  //                     selectedScenePart,
  //                   )
  //                 : null,
  //           );
  //     });

  // static final selectedScenePartProvider = FutureProvider<SceneTimelineItem?>((
  //   ref,
  // ) async {
  //   final selectedScenePart = ref.watch(selectedScenePartIdProvider);

  //   return (selectedScenePart != null)
  //       ? (await ref.watch(scenePartProvider(selectedScenePart).future))
  //       : null;
  // });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final selectedScenePart = ref.watch(selectedScenePartProvider);

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
