import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/components/editable_text.dart';

import 'package:prac_res/data/data.dart';
import 'package:prac_res/components/database/query_builder.dart';

import 'package:prac_res/editor_page/components/scene_viewer/components/selected_scene_part.dart';
import 'package:prac_res/editor_page/components/inspector/components/frame_inspector/frame_inspector.dart';
import 'package:prac_res/editor_page/components/inspector/components/scene_part_resolver_inspector.dart';
import 'package:prac_res/editor_page/components/inspector/components/custom_scene_part_inspector.dart';
import 'package:prac_res/editor_page/editor_page.dart';

class NovelInspector extends StatelessWidget {
  const NovelInspector({super.key});

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) =>
          ref.watch(NovelSelectedScenePart.selectedScenePartProvider),
      builder: (context, ref, selectedScenePart) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedScenePart != null) ...[
            NovelScenePartDropdown(
              partType: ScenePartType.values.byName(
                selectedScenePart.part.partType,
              ),
              selectedScenePartId: selectedScenePart.part.id,
            ),
            Divider(),
            Expanded(
              child: switch (selectedScenePart.specifics) {
                TimelineFrame(:final frameData) => NovelFrameInspector(
                  frame: frameData,
                ),
                TimelineResolver(:final resolverData) =>
                  NovelScenePartResolverInspector(resolver: resolverData),
                TimelineCustom(:final customData) =>
                  NovelCustomScenePartInspector(custom: customData),
              },
            ),
          ],
        ],
      ),
    );
  }
}

class NovelScenePartDropdown extends StatelessWidget {
  final ScenePartType partType;
  final int selectedScenePartId;

  const NovelScenePartDropdown({
    super.key,
    required this.partType,
    required this.selectedScenePartId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return NovelEditableText(
          sourceText: partType.toString(),
          builder: (context, controller, focusNode) =>
              DropdownMenu<ScenePartType>(
                controller: controller,
                focusNode: focusNode,
                initialSelection: partType,
                dropdownMenuEntries: [
                  for (final partType in ScenePartType.values)
                    DropdownMenuEntry(
                      value: partType,
                      label: partType.toString(),
                    ),
                ],
                onSelected: (newPartType) async {
                  if (newPartType == null || newPartType == partType) return;

                  final sceneGroup = ref.read(
                    NovelSceneGroupEditorPage.sceneGroupProvider,
                  );

                  switch (newPartType) {
                    case ScenePartType.frame:
                      {
                        await sceneGroup.frames.insert().insert(
                          mode: InsertMode.insertOrIgnore,
                          FramesCompanion.insert(
                            scenePartId: Value(selectedScenePartId),
                          ),
                        );
                        break;
                      }
                    case ScenePartType.resolver:
                      {
                        await sceneGroup.scenePartResolvers.insert().insert(
                          mode: InsertMode.insertOrIgnore,
                          ScenePartResolversCompanion.insert(
                            scenePartId: Value(selectedScenePartId),
                            dartResolverScript: "",
                          ),
                        );
                        break;
                      }
                    case ScenePartType.custom:
                      {
                        await sceneGroup.customSceneParts.insert().insert(
                          mode: InsertMode.insertOrIgnore,
                          CustomScenePartsCompanion.insert(
                            scenePartId: Value(selectedScenePartId),
                            eventId: "",
                          ),
                        );
                        break;
                      }
                  }

                  await (sceneGroup.sceneParts.update()..where(
                        (scenePartEntry) =>
                            scenePartEntry.id.equals(selectedScenePartId),
                      ))
                      .write(
                        ScenePartsCompanion(partType: Value(newPartType.name)),
                      );
                },
              ),
        );
      },
    );
  }
}
