import 'package:flutter/material.dart';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prac_res/data/data.dart';

import 'package:prac_res/components/lists/scrolling.dart';
import 'package:prac_res/editor_page/components/inspector/components/frame_inspector/components/dialogue_inspector.dart';
import 'package:prac_res/editor_page/components/inspector/components/frame_inspector/components/image_selector.dart';
import 'package:prac_res/editor_page/components/scene_viewer/components/frame.dart';
import 'package:prac_res/editor_page/editor_page.dart';

class NovelFrameInspector extends StatelessWidget {
  final Frame frame;

  const NovelFrameInspector({super.key, required this.frame});

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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollbarView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Edit Properties", style: textTheme.bodyLarge),
          Divider(),
          Text("Background", style: textTheme.bodyMedium),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Consumer(
              builder: (context, ref, _) {
                return NovelImageSelectorPreview(
                  imageGroupTable: placesTableProvider,
                  imageDataTable: NovelBackground.backgroundImageTableProvider,
                  imageMetadataTable: backgroundMetadataTableProvider,
                  selectedImageId: frame.backgroundId,
                  onImageSelected: (newBackgroundId) async {
                    await (ref.read(framesTableProvider).update()..where(
                          (frameEntry) =>
                              frameEntry.scenePartId.equals(frame.scenePartId),
                        ))
                        .write(
                          FramesCompanion(backgroundId: Value(newBackgroundId)),
                        );
                  },
                );
              },
            ),
          ),
          Divider(),
          Text("Dialogue", style: textTheme.bodyMedium),
          NovelDialogueInspector(
            dialogueBoxesTableProvider:
                NovelDialogueArea.dialogueBoxesTableProvider,
            frameScenePartId: frame.scenePartId,
          ),
        ],
      ),
    );
  }
}
