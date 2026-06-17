import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/components/database/query_builder.dart';
import 'package:prac_res/components/design_values.dart';
import 'package:prac_res/components/editable_text.dart';
import 'package:prac_res/components/lists/scrolling.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/editor_page/editor_page.dart';

class NovelScenePartResolverInspector extends StatelessWidget {
  final ScenePartResolver resolver;

  const NovelScenePartResolverInspector({super.key, required this.resolver});

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    Text sectionTitle(String text) => Text(text, style: bodyMedium);

    return SingleChildScrollbarView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle("Choice References"),
          NovelChoiceReferenceInspector(
            resolverScenePartId: resolver.scenePartId,
          ),
          sectionTitle("Scene Part References"),
          NovelScenePartReferenceInspector(),
          sectionTitle("Resolver Script"),
          NovelResolverScriptInspector(
            resolverScenePartId: resolver.scenePartId,
            dartResolverScript: resolver.dartResolverScript,
          ),
        ],
      ),
    );
  }
}

class NovelResolverScriptInspector extends StatelessWidget {
  final String dartResolverScript;
  final int resolverScenePartId;

  const NovelResolverScriptInspector({
    super.key,
    required this.resolverScenePartId,
    required this.dartResolverScript,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return NovelEditableText(
          builder: (context, controller, focusNode) {
            return TextField(
              focusNode: focusNode,
              controller: controller,
              maxLines: 7,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Resolver Script",
              ),
              onChanged: (newDartResolverScript) async {
                await (ref
                        .read(NovelSceneGroupEditorPage.sceneGroupProvider)
                        .scenePartResolvers
                        .update()
                      ..where(
                        (scenePartResolverEntry) => scenePartResolverEntry
                            .scenePartId
                            .equals(resolverScenePartId),
                      ))
                    .write(
                      ScenePartResolversCompanion(
                        dartResolverScript: Value(newDartResolverScript),
                      ),
                    );
              },
            );
          },
          sourceText: dartResolverScript,
        );
      },
    );
  }
}

class NovelScenePartReferenceInspector extends StatelessWidget {
  const NovelScenePartReferenceInspector({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

class NovelChoiceReferenceInspector extends StatelessWidget {
  final int resolverScenePartId;

  const NovelChoiceReferenceInspector({
    super.key,
    required this.resolverScenePartId,
  });

  static final resolverChoiceReferencesProvider = StreamProvider.family((
    ref,
    int resolverScenePartId,
  ) {
    final sceneGroup = ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider);

    return (sceneGroup.resolverChoiceReference.select()..where(
          (resolverChoiceReferenceEntry) => resolverChoiceReferenceEntry
              .resolverScenePartId
              .equals(resolverScenePartId),
        ))
        .watch();
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(DesignValues.small),
        child: NovelQueryBuilder(
          query: (ref) =>
              ref.watch(resolverChoiceReferencesProvider(resolverScenePartId)),
          builder: (context, ref, resolverChoiceReferences) {
            return Column(
              children: [
                ListTile(
                  title: DropdownMenu(
                    onSelected: (newSelectedChoiceId) async {},
                    dropdownMenuEntries: [
                      for (final choice in choices)
                        DropdownMenuEntry(value: choice.id, label: choice.name),
                      DropdownMenuEntry(value: null, label: ""),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

    // return Card(
    //   child: Padding(
    //     padding: EdgeInsets.all(DesignValues.small),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         ListTile(
    //           title: NovelEditableText(
    //             sourceText: frameChoice.name ?? "",
    //             builder: (context, controller, focusNode) {
    //               return NovelQueryBuilder(
    //                 query: (ref) => ref.watch(choicesProvider),
    //                 builder: (context, ref, choices) {
    //                   final selectedChoiceId = frameChoice.choiceId;

    //                   return DropdownMenu(
    //                     initialSelection: selectedChoiceId,
    //                     controller: controller,
    //                     focusNode: focusNode,
    //                     onSelected: (newSelectedChoiceId) async {
    //                       if (newSelectedChoiceId == selectedChoiceId) {
    //                         return;
    //                       }

    //                       await (ref
    //                               .read(
    //                                 NovelSceneGroupEditorPage
    //                                     .sceneGroupProvider,
    //                               )
    //                               .frameChoices
    //                               .update()
    //                             ..where(
    //                               (frameChoiceEntry) => frameChoiceEntry
    //                                   .frameScenePartId
    //                                   .equals(frameScenePartId),
    //                             ))
    //                           .write(
    //                             FrameChoicesCompanion(
    //                               choiceId: Value(newSelectedChoiceId),
    //                             ),
    //                           );
    //                     },
    //                     dropdownMenuEntries: [
    //                       for (final choice in choices)
    //                         DropdownMenuEntry(
    //                           value: choice.id,
    //                           label: choice.name,
    //                         ),
    //                       DropdownMenuEntry(value: null, label: ""),
    //                     ],
    //                   );
    //                 },
    //               );
    //             },
    //           ),
    //           trailing: IconButton(
    //             onPressed: () async {
    //               final newName = await NovelNewNameDialog.show(
    //                 context,
    //                 title: "New Choice",
    //               );

    //               if (newName == null) return;

    //               final newChoiceId = await ref
    //                   .read(NovelSceneGroupEditorPage.sceneGroupProvider)
    //                   .choices
    //                   .insert()
    //                   .insert(ChoicesCompanion.insert(name: newName));

    //               await (ref
    //                       .read(NovelSceneGroupEditorPage.sceneGroupProvider)
    //                       .frameChoices
    //                       .update()
    //                     ..where(
    //                       (frameChoiceEntry) => frameChoiceEntry
    //                           .frameScenePartId
    //                           .equals(frameScenePartId),
    //                     ))
    //                   .write(
    //                     FrameChoicesCompanion(choiceId: Value(newChoiceId)),
    //                   );
    //             },
    //             icon: Icon(Icons.add_rounded),
    //           ),
    //         ),

    //         if (hasSelectedChoice)
    //           NovelQueryBuilder(
    //             query: (ref) => ref.watch(
    //               NovelChoiceOptions.choiceOptionsProvider(selectedChoiceId),
    //             ),
    //             builder: (context, ref, choiceOptions) {
    //               return NovelEditableRadioList(
    //                 onChanged: (selectedChoiceOption) async {
    //                   final sceneGroup = ref.read(
    //                     NovelSceneGroupEditorPage.sceneGroupProvider,
    //                   );

    //                   await sceneGroup.transaction(() async {
    //                     await (sceneGroup.choiceOptions.update()..where(
    //                           (choiceOptionEntry) => choiceOptionEntry.choiceId
    //                               .equals(selectedChoiceId),
    //                         ))
    //                         .write(
    //                           ChoiceOptionsCompanion(isSelected: Value(false)),
    //                         );

    //                     if (selectedChoiceOption == null) return;

    //                     await (sceneGroup.choiceOptions.update()..where(
    //                           (choiceOptionEntry) => choiceOptionEntry.id
    //                               .equals(selectedChoiceOption),
    //                         ))
    //                         .write(
    //                           ChoiceOptionsCompanion(isSelected: Value(true)),
    //                         );
    //                   });
    //                 },
    //                 onTileRename: (id, newName) async {
    //                   await (ref
    //                           .read(
    //                             NovelSceneGroupEditorPage.sceneGroupProvider,
    //                           )
    //                           .choiceOptions
    //                           .update()
    //                         ..where(
    //                           (choiceOptionEntry) =>
    //                               choiceOptionEntry.id.equals(id),
    //                         ))
    //                       .write(ChoiceOptionsCompanion(name: Value(newName)));
    //                 },
    //                 onDelete: (id) async {
    //                   await (ref
    //                           .read(
    //                             NovelSceneGroupEditorPage.sceneGroupProvider,
    //                           )
    //                           .choiceOptions
    //                           .delete()
    //                         ..where(
    //                           (choiceOptionEntry) =>
    //                               choiceOptionEntry.id.equals(id),
    //                         ))
    //                       .go();
    //                 },
    //                 onAdd: (newName) async {
    //                   await ref
    //                       .read(NovelSceneGroupEditorPage.sceneGroupProvider)
    //                       .choiceOptions
    //                       .insert()
    //                       .insert(
    //                         ChoiceOptionsCompanion.insert(
    //                           name: newName,
    //                           choiceId: selectedChoiceId,
    //                         ),
    //                       );
    //                 },
    //                 selectedRow: choiceOptions
    //                     .where((choiceOption) => choiceOption.isSelected)
    //                     .firstOrNull
    //                     ?.id,
    //                 groups: choiceOptions,
    //               );
    //             },
    //           ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
