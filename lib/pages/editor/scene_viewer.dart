import 'package:device_frame/device_frame.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/editor/scene_selector.dart';
import 'package:prac_res/pages/frame/frame.dart';
import 'package:prac_res/pages/open.dart';

class SelectedScenePartIdProvider extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? id) {
    state = id;
  }
}

final selectedScenePartIdProvider =
    NotifierProvider<SelectedScenePartIdProvider, int?>(
      SelectedScenePartIdProvider.new,
    );

class NovelSceneViewer extends StatelessWidget {
  const NovelSceneViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(DesignValues.veryLarge),
              child: NovelSelectedScenePart(),
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(DesignValues.small),
            child: NovelScenePartTimeline(),
          ),
        ),
      ],
    );
  }
}

class NovelSelectedScenePart extends StatelessWidget {
  const NovelSelectedScenePart({super.key});

  static final selectedScenePartProvider = StreamProvider<SceneTimelineItem?>((
    ref,
  ) {
    final sceneGroup = ref.watch(sceneGroupProvider);
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
      provider: selectedScenePartProvider,
      builder: (context, ref, scenePart) => (scenePart != null)
          ?
            // DeviceFrame(
            //   device: Devices.android.bigPhone,
            //   screen: NovelScenePartPreview(specifics: scenePart.specifics),
            //   orientation: Orientation.landscape,
            // )
            AspectRatio(
              aspectRatio: 16 / 9,
              child: NovelScenePartPreview(specifics: scenePart.specifics),
            )
          : SizedBox.shrink(),
    );
  }
}

class NovelScenePartTimeline extends StatelessWidget {
  const NovelScenePartTimeline({super.key});

  static final sceneProvider =
      StreamProvider.family<List<SceneTimelineItem>, int>((ref, sceneId) {
        final sceneGroup = ref.watch(sceneGroupProvider);

        return (sceneGroup.sceneTimelineView.select()
              ..where((scenePart) => scenePart.sceneId.equals(sceneId))
              ..orderBy([(scenePart) => OrderingTerm.asc(scenePart.order)]))
            .watch()
            .map(
              (sceneTimeline) => sceneTimeline
                  .map(
                    (scenePart) =>
                        SceneTimelineItem.fromSceneTimelineViewData(scenePart),
                  )
                  .toList(),
            );
      });

  static final selectedSceneProvider = FutureProvider<List<SceneTimelineItem>?>(
    (ref) async {
      final selectedSceneId = ref.watch(selectedSceneIdProvider);

      return (selectedSceneId != null)
          ? ref.watch(sceneProvider(selectedSceneId).future)
          : null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      provider: selectedSceneProvider,
      builder: (context, ref, sceneParts) {
        if (sceneParts == null) return SizedBox.shrink();

        return Row(
          spacing: DesignValues.medium,
          children: [
            ...[
              for (final scenePart in sceneParts)
                NovelSceneTimelineItem(scenePart: scenePart),
              IconButton(
                onPressed: () async {
                  final selectedSceneId = ref.read(selectedSceneIdProvider);

                  if (selectedSceneId == null) return;

                  final sceneGroup = ref.read(sceneGroupProvider);

                  sceneGroup
                      .into(sceneGroup.sceneParts)
                      .insert(
                        ScenePartsCompanion.insert(
                          sceneId: selectedSceneId,
                          order: (sceneParts.lastOrNull?.part.order ?? -1) + 1,
                          partType: "frame",
                        ),
                      );
                },
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ],
        );
      },
    );
  }
}

class NovelSceneTimelineItem extends StatelessWidget {
  final SceneTimelineItem scenePart;

  const NovelSceneTimelineItem({super.key, required this.scenePart});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedScenePartId = ref.watch(selectedScenePartIdProvider);

        final scenePartId = scenePart.part.id;
        final isSelected = scenePartId == selectedScenePartId;

        final specifics = scenePart.specifics;

        final preview = Padding(
          padding: EdgeInsets.all(DesignValues.verySmall),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(DesignValues.small),
            child: Stack(
              children: [
                Positioned.fill(
                  child: NovelScenePartPreview(specifics: specifics),
                ),

                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        ref
                            .read(selectedScenePartIdProvider.notifier)
                            .set(isSelected ? null : scenePartId);
                      },
                    ),
                  ),
                ),

                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        final answer = await NovelDeletionDialog.show(context);

                        debugPrint("a3");

                        if (answer != true) return;

                        debugPrint("a4");

                        final sceneGroup = ref.read(sceneGroupProvider);

                        debugPrint("a5");

                        await (sceneGroup.sceneParts.delete()..where(
                              (scenePart) => scenePart.id.equals(scenePartId),
                            ))
                            .go();

                        debugPrint("a6");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

        return AspectRatio(
          aspectRatio: 16 / 9,
          child: isSelected
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      DesignValues.small * (1 + DesignValues.semiSmallPercent),
                    ),
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: preview,
                )
              : preview,
        );
      },
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
      TimelineResolver() => Center(child: Icon(Icons.alt_route_rounded)),
      TimelineCustom() => Center(child: Icon(Icons.build_circle_rounded)),
    };
  }
}
