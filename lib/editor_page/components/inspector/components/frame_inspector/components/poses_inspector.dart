import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/components/database/query_builder.dart';
import 'package:prac_res/components/database/reorderable_list.dart';
import 'package:prac_res/components/dialogs/deletion_dialog.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/editor_page/components/inspector/components/frame_inspector/components/image_selector.dart';
import 'package:prac_res/editor_page/components/scene_viewer/components/frame.dart';
import 'package:prac_res/editor_page/editor_page.dart';

class NovelPosesInspector extends StatelessWidget {
  final int frameScenePartId;

  const NovelPosesInspector({super.key, required this.frameScenePartId});

  static final actorsTable = Provider<$ActorsTable>((ref) {
    return ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider).actors;
  });

  static final poseMetadataTableProvider = Provider<$PoseMetadatasTable>((ref) {
    final sceneGroup = ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider);
    return sceneGroup.poseMetadatas;
  });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) => ref.watch(NovelPoses.framePoseProvider(frameScenePartId)),
      builder: (context, ref, framePoses) {
        return NovelReorderableListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          onReorder: (oldIndex, orderValue) async {
            final sceneGroup = ref.read(
              NovelSceneGroupEditorPage.sceneGroupProvider,
            );

            await (sceneGroup.framePoses.update()..where(
                  (framePoseEntry) =>
                      framePoseEntry.id.equals(framePoses[oldIndex].id),
                ))
                .write(FramePosesCompanion(order: Value(orderValue)));
          },
          onAdd: (newOrder) async {
            final sceneGroup = ref.read(
              NovelSceneGroupEditorPage.sceneGroupProvider,
            );

            await sceneGroup.framePoses.insert().insert(
              FramePosesCompanion.insert(
                frameScenePartId: frameScenePartId,
                order: newOrder,
              ),
            );
          },
          wrapAddButton: (addButton) => (framePoses.length < 3)
              ? AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Center(child: addButton),
                )
              : SizedBox.shrink(),
          values: framePoses,
          getOrder: (framePose) => framePose?.order,
          itemBuilder: (context, framePose) => Stack(
            key: ValueKey(framePose.id),
            children: [
              NovelImageSelectorPreview(
                title: Text("Select A Pose"),
                imageGroupTable: actorsTable,
                imageDataTable: NovelPose.poseImageTableProvider,
                imageMetadataTable: poseMetadataTableProvider,
                selectedImageId: framePose.poseId,
                onImageSelected: (newPoseId) async {
                  await (ref
                          .read(NovelSceneGroupEditorPage.sceneGroupProvider)
                          .framePoses
                          .update()
                        ..where(
                          (framePoseEntry) =>
                              framePoseEntry.id.equals(framePose.id),
                        ))
                      .write(FramePosesCompanion(poseId: Value(newPoseId)));
                },
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () async {
                    final confirmation = await NovelDeletionDialog.show(
                      context,
                    );

                    if (!confirmation) return;

                    await (ref
                            .read(NovelSceneGroupEditorPage.sceneGroupProvider)
                            .framePoses
                            .delete()
                          ..where(
                            (framePoseEntry) =>
                                framePoseEntry.id.equals(framePose.id),
                          ))
                        .go();
                  },
                  icon: Icon(Icons.delete_rounded),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
