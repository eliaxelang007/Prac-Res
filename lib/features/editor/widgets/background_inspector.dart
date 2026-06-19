import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/features/editor/screens/editor_page.dart';
import 'package:prac_res/features/editor/widgets/image_selector.dart';
import 'package:prac_res/features/scene_viewer/widgets/frame.dart';

class NovelBackgroundInspector extends StatelessWidget {
  static final placesTableProvider = Provider<$PlacesTable>((ref) {
    final sceneGroup = ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider);

    return sceneGroup.places;
  });

  static final backgroundMetadataTableProvider =
      Provider<$BackgroundMetadatasTable>((ref) {
        final sceneGroup = ref.watch(
          NovelSceneGroupEditorPage.sceneGroupProvider,
        );
        return sceneGroup.backgroundMetadatas;
      });

  static final framesTableProvider = Provider<$FramesTable>((ref) {
    final sceneGroup = ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider);
    return sceneGroup.frames;
  });

  const NovelBackgroundInspector({
    super.key,
    required this.backgroundId,
    required this.selectedFrameScenePartId,
  });

  final int? backgroundId;
  final int selectedFrameScenePartId;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return NovelImageSelectorPreview(
          title: Text("Select A Background"),
          imageGroupTable: placesTableProvider,
          imageDataTable: NovelBackground.backgroundImageTableProvider,
          imageMetadataTable: backgroundMetadataTableProvider,
          selectedImageId: backgroundId,
          onImageSelected: (newBackgroundId) async {
            await (ref.read(framesTableProvider).update()..where(
                  (frameEntry) =>
                      frameEntry.scenePartId.equals(selectedFrameScenePartId),
                ))
                .write(FramesCompanion(backgroundId: Value(newBackgroundId)));
          },
        );
      },
    );
  }
}
