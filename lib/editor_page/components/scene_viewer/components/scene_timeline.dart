import 'package:flutter/material.dart';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/components/database/reorderable_list.dart';

import 'package:prac_res/data/data.dart';

import 'package:prac_res/components/card.dart';
import 'package:prac_res/components/database/query_builder.dart';
import 'package:prac_res/components/dialogs/deletion_dialog.dart';

import 'package:prac_res/editor_page/components/scene_selector.dart';
import 'package:prac_res/editor_page/editor_page.dart';
import 'package:prac_res/editor_page/components/scene_viewer/components/selected_scene_part.dart';

class NovelSceneTimeline extends StatelessWidget {
  const NovelSceneTimeline({super.key});

  static final sceneProvider =
      StreamProvider.family<List<SceneTimelineItem>, int>((ref, sceneId) {
        final sceneGroup = ref.watch(
          NovelSceneGroupEditorPage.sceneGroupProvider,
        );

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
      final selectedSceneId = ref.watch(
        NovelSceneSelector.selectedSceneIdProvider,
      );

      return (selectedSceneId != null)
          ? ref.watch(sceneProvider(selectedSceneId).future)
          : null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) => ref.watch(selectedSceneProvider),
      builder: (context, ref, sceneParts) {
        if (sceneParts == null) return SizedBox.shrink();

        return HookBuilder(
          builder: (context) {
            final controller = useScrollController();

            return Scrollbar(
              controller: controller,
              child: NovelReorderableListView(
                scrollController: controller,
                scrollDirection: Axis.horizontal,
                onReorder: (oldIndex, newOrder) async {
                  final sceneGroup = ref.read(
                    NovelSceneGroupEditorPage.sceneGroupProvider,
                  );

                  await (sceneGroup.sceneParts.update()..where(
                        (scenePart) =>
                            scenePart.id.equals(sceneParts[oldIndex].part.id),
                      ))
                      .write(ScenePartsCompanion(order: Value(newOrder)));
                },
                onAdd: (newOrder) async {
                  final selectedSceneId = ref.read(
                    NovelSceneSelector.selectedSceneIdProvider,
                  );

                  if (selectedSceneId == null) return;

                  final sceneGroup = ref.read(
                    NovelSceneGroupEditorPage.sceneGroupProvider,
                  );

                  await sceneGroup.transaction(() async {
                    final newScenePartId = await sceneGroup.sceneParts
                        .insert()
                        .insert(
                          ScenePartsCompanion.insert(
                            sceneId: selectedSceneId,
                            order: newOrder,
                            partType: "frame",
                          ),
                        );

                    await sceneGroup.frames.insert().insert(
                      FramesCompanion.insert(
                        scenePartId: Value(newScenePartId),
                      ),
                    );
                  });
                },
                values: sceneParts,
                getOrder: (scenePart) => scenePart?.part.order,
                wrapAddButton: (addButton) => AspectRatio(
                  aspectRatio: 1,
                  child: Center(child: addButton),
                ),
                itemBuilder: (context, scenePart) => NovelSceneTimelineItem(
                  key: ValueKey(scenePart.part.id),
                  scenePart: scenePart,
                ),
              ),
            );
          },
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
        final selectedScenePartId = ref.watch(
          NovelSelectedScenePart.selectedScenePartIdProvider,
        );

        final scenePartId = scenePart.part.id;
        final isSelected = scenePartId == selectedScenePartId;

        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              Positioned.fill(
                child: NovelCard(
                  isSelected: isSelected,
                  onTap: () {
                    ref
                        .read(
                          NovelSelectedScenePart
                              .selectedScenePartIdProvider
                              .notifier,
                        )
                        .set(isSelected ? null : scenePartId);
                  },
                  child: SizedBox.expand(
                    child: NovelScenePartPreview(
                      specifics: scenePart.specifics,
                    ),
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

                      if (answer != true) return;

                      final sceneGroup = ref.read(
                        NovelSceneGroupEditorPage.sceneGroupProvider,
                      );

                      await (sceneGroup.sceneParts.delete()..where(
                            (scenePart) => scenePart.id.equals(scenePartId),
                          ))
                          .go();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
