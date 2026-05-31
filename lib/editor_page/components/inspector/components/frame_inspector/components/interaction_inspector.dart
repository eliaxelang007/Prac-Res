import 'package:flutter/material.dart';

import 'package:drift/drift.dart' hide Column;

import 'package:prac_res/data/data.dart';
import 'package:prac_res/components/editable_text.dart';
import 'package:prac_res/components/design_values.dart';
import 'package:prac_res/components/dialogs/deletion_dialog.dart';
import 'package:prac_res/components/database/query_builder.dart';
import 'package:prac_res/editor_page/components/scene_viewer/components/frame.dart';
import 'package:prac_res/editor_page/editor_page.dart';

class NovelInteractionInspector extends StatelessWidget {
  final int frameScenePartId;

  const NovelInteractionInspector({super.key, required this.frameScenePartId});

  @override
  Widget build(BuildContext context) {
    return NovelDialogueInspector(frameScenePartId: frameScenePartId);
  }
}

class NovelDialogueInspector extends StatelessWidget {
  const NovelDialogueInspector({super.key, required this.frameScenePartId});

  final int frameScenePartId;

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) =>
          ref.watch(NovelDialogueArea.dialogueProvider(frameScenePartId)),
      builder: (context, ref, dialogueBox) {
        final hasDialogueBox = dialogueBox != null;

        final name = dialogueBox?.name;
        final hasNameBox = name != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SwitchListTile(
              title: const Text("Dialogue Box"),
              value: hasDialogueBox,
              onChanged: (enabled) async {
                final dialogueBoxTable = ref
                    .read(NovelSceneGroupEditorPage.sceneGroupProvider)
                    .dialogueBoxes;

                if (enabled) {
                  await dialogueBoxTable.insert().insert(
                    mode: InsertMode.insertOrIgnore,
                    DialogueBoxesCompanion.insert(
                      dialogue: "",
                      frameScenePartId: Value(frameScenePartId),
                    ),
                  );

                  return;
                }

                final confirmation = await NovelDeletionDialog.show(context);

                if (!confirmation) return;

                await (dialogueBoxTable.delete()..where(
                      (dialogueBoxEntry) => dialogueBoxEntry.frameScenePartId
                          .equals(frameScenePartId),
                    ))
                    .go();
              },
            ),
            if (hasDialogueBox) ...[
              Card(
                child: Padding(
                  padding: EdgeInsets.all(DesignValues.small),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwitchListTile(
                        title: Text("Name Box"),
                        value: hasNameBox,
                        onChanged: (enabled) async {
                          final dialogueBoxTable = ref
                              .read(
                                NovelSceneGroupEditorPage.sceneGroupProvider,
                              )
                              .dialogueBoxes;

                          final updateQuery = dialogueBoxTable.update()
                            ..where(
                              (dialogueBoxEntry) => dialogueBoxEntry
                                  .frameScenePartId
                                  .equals(frameScenePartId),
                            );

                          final String? nameBoxValue;

                          if (!enabled) {
                            final confirmation = await NovelDeletionDialog.show(
                              context,
                            );

                            if (!confirmation) return;

                            nameBoxValue = null;
                          } else {
                            nameBoxValue = "";
                          }

                          await updateQuery.write(
                            DialogueBoxesCompanion(name: Value(nameBoxValue)),
                          );
                        },
                      ),
                      if (hasNameBox) ...[
                        Text(
                          "Speaker Name",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: DesignValues.verySmall),
                        NovelEditableText(
                          sourceText: name,
                          builder: (controller, focusNode) {
                            return TextField(
                              focusNode: focusNode,
                              controller: controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter name...",
                              ),
                              onChanged: (value) async {
                                await (ref
                                        .read(
                                          NovelSceneGroupEditorPage
                                              .sceneGroupProvider,
                                        )
                                        .dialogueBoxes
                                        .update()
                                      ..where(
                                        (dialogueBoxEntry) => dialogueBoxEntry
                                            .frameScenePartId
                                            .equals(frameScenePartId),
                                      ))
                                    .write(
                                      DialogueBoxesCompanion(
                                        name: Value(value),
                                      ),
                                    );
                              },
                            );
                          },
                        ),
                        SizedBox(height: DesignValues.small),
                      ],
                      Text(
                        "Dialogue Text",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: DesignValues.verySmall),
                      NovelEditableText(
                        sourceText: dialogueBox.dialogue,
                        builder: (controller, focusNode) {
                          return TextField(
                            focusNode: focusNode,
                            controller: controller,
                            maxLines: 4,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter dialogue...",
                            ),
                            onChanged: (value) async {
                              await (ref
                                      .read(
                                        NovelSceneGroupEditorPage
                                            .sceneGroupProvider,
                                      )
                                      .dialogueBoxes
                                      .update()
                                    ..where(
                                      (dialogueBoxEntry) => dialogueBoxEntry
                                          .frameScenePartId
                                          .equals(frameScenePartId),
                                    ))
                                  .write(
                                    DialogueBoxesCompanion(
                                      dialogue: Value(value),
                                    ),
                                  );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
