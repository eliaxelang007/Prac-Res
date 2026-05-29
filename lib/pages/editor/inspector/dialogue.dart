import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/editor/inspector/image_group.dart';
import 'package:prac_res/pages/frame/frame.dart';
import 'package:prac_res/pages/open.dart';

final dialogueBoxProvider =
    StreamProvider.family<
      DialogueBox?,
      (EquatableTableInfo<DialogueBoxes, DialogueBox>, int)
    >((ref, identifiers) {
      final (dialogBoxTableWrapper, frameScenePartId) = identifiers;

      return (dialogBoxTableWrapper.wrapped.select()..where(
            (dialogBoxEntry) =>
                dialogBoxEntry.frameScenePartId.equals(frameScenePartId),
          ))
          .watchSingleOrNull();
    });

class NovelDialogueInspector extends StatelessWidget {
  final ProviderListenable<$DialogueBoxesTable> dialogBoxTableProvider;
  final int frameScenePartId;

  const NovelDialogueInspector({
    super.key,
    required this.dialogBoxTableProvider,
    required this.frameScenePartId,
  });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      provider: (ref) => dialogueBoxProvider((
        EquatableTableInfo(ref.watch(dialogBoxTableProvider)),
        frameScenePartId,
      )),
      builder: (context, ref, dialogBox) {
        final hasDialogueBox = dialogBox != null;

        final name = dialogBox?.name;
        final hasNameBox = name != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SwitchListTile(
              title: const Text("Dialogue Box"),
              value: hasDialogueBox,
              onChanged: (enabled) async {
                final dialogBoxTable = ref.read(dialogBoxTableProvider);

                if (enabled) {
                  await dialogBoxTable.insert().insert(
                    DialogueBoxesCompanion.insert(
                      dialogue: "",
                      frameScenePartId: Value(frameScenePartId),
                    ),
                  );

                  return;
                }

                final confirmation = await NovelDeletionDialog.show(context);

                if (!confirmation) return;

                await (dialogBoxTable.delete()..where(
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
                          final dialogBoxTable = ref.read(
                            dialogBoxTableProvider,
                          );

                          final updateQuery = dialogBoxTable.update()
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
                                await (ref.read(dialogBoxTableProvider).update()
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
                        sourceText: dialogBox.dialogue,
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
                              await (ref.read(dialogBoxTableProvider).update()
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

        // return NovelCard(
        //   child: Column(
        //     children: [Switch(value: true, onChanged: (newValue) {})],
        //   ),
        // );
      },
    );
  }
}
