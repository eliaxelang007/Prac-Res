import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/stdlib/core.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/core/theme/design_values.dart';
import 'package:prac_res/core/widgets/editable_text.dart';
import 'package:prac_res/core/widgets/outlined_button.dart';
import 'package:prac_res/core/widgets/scrolling.dart';
import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/features/editor/screens/editor_page.dart';
import 'package:prac_res/features/editor/widgets/scene_selector.dart';
import 'package:prac_res/features/scene_viewer/widgets/selected_scene_part.dart';

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
          sectionTitle("Resolver Script"),
          NovelResolverScriptInspector(
            resolverScenePartId: resolver.scenePartId,
            dartResolverScript: resolver.dartResolverScript,
          ),
          Divider(),
          sectionTitle("Choice Options Ids"),
          NovelChoiceOptionIds(),
        ],
      ),
    );
  }
}

class NovelChoiceOptionIds extends StatelessWidget {
  const NovelChoiceOptionIds({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(DesignValues.small),
        child: Column(
          children: [
            // for (final choiceOption in )
          ],
        ),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(DesignValues.small),
        child: Consumer(
          builder: (context, ref, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NovelEditableText(
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
                                .read(
                                  NovelSceneGroupEditorPage.sceneGroupProvider,
                                )
                                .scenePartResolvers
                                .update()
                              ..where(
                                (scenePartResolverEntry) =>
                                    scenePartResolverEntry.scenePartId.equals(
                                      resolverScenePartId,
                                    ),
                              ))
                            .write(
                              ScenePartResolversCompanion(
                                dartResolverScript: Value(
                                  newDartResolverScript,
                                ),
                              ),
                            );
                      },
                    );
                  },
                  sourceText: dartResolverScript,
                ),
                Divider(),
                NovelOutlinedButton(
                  onPressed: () async {
                    final sceneGroup = ref.read(
                      NovelSceneGroupEditorPage.sceneGroupProvider,
                    );

                    final selectedOptions =
                        await (sceneGroup.choiceOptions.select()
                              ..orderBy([(u) => OrderingTerm(expression: u.id)])
                              ..where((t) => t.isSelected.equals(true)))
                            .get();

                    final resolvedScenePartId =
                        eval(
                              "int resolve(Map<int, int> choiceIdToSelectedId) {$dartResolverScript}",
                              function: "resolve",
                              args: [
                                $Map.wrap({
                                  for (var option in selectedOptions)
                                    option.choiceId: option.id,
                                }),
                              ],
                            )
                            as int;

                    final scenePart =
                        await (sceneGroup.sceneParts.select()..where(
                              (scenePartEntry) =>
                                  scenePartEntry.id.equals(resolvedScenePartId),
                            ))
                            .getSingleOrNull();

                    if (scenePart == null) {
                      debugPrint("No scene part found!");
                      return;
                    }

                    ref
                        .read(
                          NovelSceneSelector.selectedSceneIdProvider.notifier,
                        )
                        .set(scenePart.sceneId);
                    ref
                        .read(
                          NovelSelectedScenePart
                              .selectedScenePartIdProvider
                              .notifier,
                        )
                        .set(scenePart.id);
                  },
                  child: Text("Resolve"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
