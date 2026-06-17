import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/editor_page/components/inspector/components/frame_inspector/components/image_selector.dart';
import 'package:prac_res/editor_page/components/scene_viewer/components/frame.dart';
import 'package:prac_res/editor_page/editor_page.dart';

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
