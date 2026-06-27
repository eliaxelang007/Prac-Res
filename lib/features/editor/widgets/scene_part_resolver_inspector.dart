import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/stdlib/core.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/core/theme/design_values.dart';
import 'package:prac_res/core/widgets/database/query_builder.dart';
import 'package:prac_res/core/widgets/editable_text.dart';
import 'package:prac_res/core/widgets/outlined_button.dart';
import 'package:prac_res/core/widgets/scrolling.dart';
import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/features/editor/screens/editor_page.dart';
import 'package:prac_res/features/editor/widgets/novel_inspector.dart';
import 'package:prac_res/features/play/screens/play_mode.dart';
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
          NovelResolverScriptInspector(scenePartResolver: resolver),
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

  static final choicesProvider = StreamProvider((ref) {
    final sceneGroup = ref.read(NovelSceneGroupEditorPage.sceneGroupProvider);

    return sceneGroup.choices.select().watch();
  });

  static final choiceOptionsProvider = StreamProvider((ref) {
    final sceneGroup = ref.read(NovelSceneGroupEditorPage.sceneGroupProvider);

    return sceneGroup.choiceOptions.select().watch();
  });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) => ref.watch(choicesProvider),
      builder: (context, ref, choices) {
        return NovelQueryBuilder(
          query: (ref) => ref.watch(choiceOptionsProvider),
          builder: (context, ref, choiceOptions) {
            final Map<int, List<ChoiceOption>> groupedChoiceOptions = {};

            for (final choiceOption in choiceOptions) {
              final group = groupedChoiceOptions.putIfAbsent(
                choiceOption.choiceId,
                () => [],
              );
              group.add(choiceOption);
            }

            return Column(
              children: [
                for (final choice in choices)
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(choice.name),
                          trailing: NovelCopyableText(
                            displayText: Text("Id: ${choice.id}"),
                            copyText: choice.id.toString(),
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              for (final choiceOption
                                  in groupedChoiceOptions[choice.id]!)
                                ListTile(
                                  title: Text(choiceOption.name),
                                  trailing: NovelCopyableText(
                                    displayText: Text("Id: ${choiceOption.id}"),
                                    copyText: choiceOption.id.toString(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class NovelResolverScriptInspector extends StatelessWidget {
  final ScenePartResolver scenePartResolver;

  const NovelResolverScriptInspector({
    super.key,
    required this.scenePartResolver,
  });

  @override
  Widget build(BuildContext context) {
    final String dartResolverScript = scenePartResolver.dartResolverScript;
    final int resolverScenePartId = scenePartResolver.scenePartId;

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
                    final nextScenePart = await scenePartResolver.resolve(
                      sceneGroup,
                    );

                    ref
                        .read(
                          NovelSelectedScenePart
                              .selectedScenePartProvider
                              .notifier,
                        )
                        .set(nextScenePart);
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
