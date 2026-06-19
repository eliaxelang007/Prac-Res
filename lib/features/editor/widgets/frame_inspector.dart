import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/theme/design_values.dart';
import 'package:prac_res/core/widgets/database/group_selector.dart';
import 'package:prac_res/core/widgets/database/query_builder.dart';
import 'package:prac_res/core/widgets/deletion_dialog.dart';
import 'package:prac_res/core/widgets/editable_text.dart';
import 'package:prac_res/core/widgets/new_name_dialog.dart';
import 'package:prac_res/core/widgets/scrolling.dart';
import 'package:prac_res/features/editor/screens/editor_page.dart';
import 'package:prac_res/features/editor/widgets/background_inspector.dart';
import 'package:prac_res/features/editor/widgets/dialogue_inspector.dart';
import 'package:prac_res/features/editor/widgets/poses_inspector.dart';
import 'package:prac_res/features/scene_viewer/widgets/frame.dart';

class NovelFrameInspector extends StatelessWidget {
  // This has to be passed in, it can't just be provided because the [selectedScenePartProvider]s are nullable.
  final Frame frame;

  const NovelFrameInspector({super.key, required this.frame});

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    Text sectionTitle(String text) => Text(text, style: bodyMedium);

    return SingleChildScrollbarView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle("Dialogue"),
          NovelDialogueInspector(frameScenePartId: frame.scenePartId),
          Divider(),
          sectionTitle("Choice"),
          NovelChoiceInspector(frame: frame),
          Divider(),
          sectionTitle("Poses"),
          NovelPosesInspector(frameScenePartId: frame.scenePartId),
          Divider(),
          sectionTitle("Background"),
          NovelBackgroundInspector(
            backgroundId: frame.backgroundId,
            selectedFrameScenePartId: frame.scenePartId,
          ),
        ],
      ),
    );
  }
}

class NovelChoiceInspector extends StatelessWidget {
  final Frame frame;

  const NovelChoiceInspector({super.key, required this.frame});

  static final choicesProvider = StreamProvider((ref) {
    return (ref
            .watch(NovelSceneGroupEditorPage.sceneGroupProvider)
            .choices
            .select()
          ..orderBy([(u) => OrderingTerm(expression: u.id)]))
        .watch();
  });

  @override
  Widget build(BuildContext context) {
    final frameScenePartId = frame.scenePartId;

    return NovelQueryBuilder(
      query: (ref) =>
          ref.watch(NovelChoice.frameChoiceProvider(frameScenePartId)),
      builder: (context, ref, frameChoice) {
        final hasFrameChoice = frameChoice != null;

        final selectedChoiceId = frameChoice?.choiceId;
        final hasSelectedChoice = selectedChoiceId != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SwitchListTile(
              title: const Text("Choice"),
              value: hasFrameChoice,
              onChanged: (enabled) async {
                final frameChoiceTable = ref
                    .read(NovelSceneGroupEditorPage.sceneGroupProvider)
                    .frameChoices;

                if (enabled) {
                  await frameChoiceTable.insert().insert(
                    mode: InsertMode.insertOrIgnore,
                    FrameChoicesCompanion.insert(
                      frameScenePartId: Value(frameScenePartId),
                    ),
                  );

                  return;
                }

                final confirmation = await NovelDeletionDialog.show(context);

                if (!confirmation) return;

                await (frameChoiceTable.delete()..where(
                      (frameChoiceEntry) => frameChoiceEntry.frameScenePartId
                          .equals(frameScenePartId),
                    ))
                    .go();
              },
            ),
            if (hasFrameChoice) ...[
              Card(
                child: Padding(
                  padding: EdgeInsets.all(DesignValues.small),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: NovelEditableText(
                          sourceText: frameChoice.name ?? "",
                          builder: (context, controller, focusNode) {
                            return NovelQueryBuilder(
                              query: (ref) => ref.watch(choicesProvider),
                              builder: (context, ref, choices) {
                                final selectedChoiceId = frameChoice.choiceId;

                                return DropdownMenu(
                                  initialSelection: selectedChoiceId,
                                  controller: controller,
                                  focusNode: focusNode,
                                  onSelected: (newSelectedChoiceId) async {
                                    if (newSelectedChoiceId ==
                                        selectedChoiceId) {
                                      return;
                                    }

                                    await (ref
                                            .read(
                                              NovelSceneGroupEditorPage
                                                  .sceneGroupProvider,
                                            )
                                            .frameChoices
                                            .update()
                                          ..where(
                                            (frameChoiceEntry) =>
                                                frameChoiceEntry
                                                    .frameScenePartId
                                                    .equals(frameScenePartId),
                                          ))
                                        .write(
                                          FrameChoicesCompanion(
                                            choiceId: Value(
                                              newSelectedChoiceId,
                                            ),
                                          ),
                                        );
                                  },
                                  dropdownMenuEntries: [
                                    for (final choice in choices)
                                      DropdownMenuEntry(
                                        value: choice.id,
                                        label: choice.name,
                                      ),
                                    DropdownMenuEntry(value: null, label: ""),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        trailing: (hasSelectedChoice)
                            ? IconButton(
                                onPressed: () async {
                                  final deleteChoice =
                                      await NovelDeletionDialog.show(context);

                                  if (!deleteChoice) return;

                                  await (ref
                                          .read(
                                            NovelSceneGroupEditorPage
                                                .sceneGroupProvider,
                                          )
                                          .frameChoices
                                          .delete()
                                        ..where(
                                          (frameChoiceEntry) => frameChoiceEntry
                                              .choiceId
                                              .equals(selectedChoiceId),
                                        ))
                                      .go();
                                },
                                icon: Icon(Icons.delete_rounded),
                              )
                            : IconButton(
                                onPressed: () async {
                                  final newName = await NovelNewNameDialog.show(
                                    context,
                                    title: "New Choice",
                                  );

                                  if (newName == null) return;

                                  final newChoiceId = await ref
                                      .read(
                                        NovelSceneGroupEditorPage
                                            .sceneGroupProvider,
                                      )
                                      .choices
                                      .insert()
                                      .insert(
                                        ChoicesCompanion.insert(name: newName),
                                      );

                                  await (ref
                                          .read(
                                            NovelSceneGroupEditorPage
                                                .sceneGroupProvider,
                                          )
                                          .frameChoices
                                          .update()
                                        ..where(
                                          (frameChoiceEntry) => frameChoiceEntry
                                              .frameScenePartId
                                              .equals(frameScenePartId),
                                        ))
                                      .write(
                                        FrameChoicesCompanion(
                                          choiceId: Value(newChoiceId),
                                        ),
                                      );
                                },
                                icon: Icon(Icons.add_rounded),
                              ),
                      ),

                      if (hasSelectedChoice)
                        NovelQueryBuilder(
                          query: (ref) => ref.watch(
                            NovelChoiceOptions.choiceOptionsProvider(
                              selectedChoiceId,
                            ),
                          ),
                          builder: (context, ref, choiceOptions) {
                            return NovelEditableRadioList(
                              onChanged: (selectedChoiceOption) async {
                                final sceneGroup = ref.read(
                                  NovelSceneGroupEditorPage.sceneGroupProvider,
                                );

                                await sceneGroup.transaction(() async {
                                  await (sceneGroup.choiceOptions.update()
                                        ..where(
                                          (choiceOptionEntry) =>
                                              choiceOptionEntry.choiceId.equals(
                                                selectedChoiceId,
                                              ),
                                        ))
                                      .write(
                                        ChoiceOptionsCompanion(
                                          isSelected: Value(false),
                                        ),
                                      );

                                  if (selectedChoiceOption == null) return;

                                  await (sceneGroup.choiceOptions.update()
                                        ..where(
                                          (choiceOptionEntry) =>
                                              choiceOptionEntry.id.equals(
                                                selectedChoiceOption,
                                              ),
                                        ))
                                      .write(
                                        ChoiceOptionsCompanion(
                                          isSelected: Value(true),
                                        ),
                                      );
                                });
                              },
                              onTileRename: (id, newName) async {
                                await (ref
                                        .read(
                                          NovelSceneGroupEditorPage
                                              .sceneGroupProvider,
                                        )
                                        .choiceOptions
                                        .update()
                                      ..where(
                                        (choiceOptionEntry) =>
                                            choiceOptionEntry.id.equals(id),
                                      ))
                                    .write(
                                      ChoiceOptionsCompanion(
                                        name: Value(newName),
                                      ),
                                    );
                              },
                              onDelete: (id) async {
                                await (ref
                                        .read(
                                          NovelSceneGroupEditorPage
                                              .sceneGroupProvider,
                                        )
                                        .choiceOptions
                                        .delete()
                                      ..where(
                                        (choiceOptionEntry) =>
                                            choiceOptionEntry.id.equals(id),
                                      ))
                                    .go();
                              },
                              onAdd: (newName) async {
                                await ref
                                    .read(
                                      NovelSceneGroupEditorPage
                                          .sceneGroupProvider,
                                    )
                                    .choiceOptions
                                    .insert()
                                    .insert(
                                      ChoiceOptionsCompanion.insert(
                                        name: newName,
                                        choiceId: selectedChoiceId,
                                      ),
                                    );
                              },
                              selectedRow: choiceOptions
                                  .where(
                                    (choiceOption) => choiceOption.isSelected,
                                  )
                                  .firstOrNull
                                  ?.id,
                              groups: choiceOptions,
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
