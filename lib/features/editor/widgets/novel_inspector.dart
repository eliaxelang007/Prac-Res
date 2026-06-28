import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/core/theme/design_values.dart';
import 'package:prac_res/core/widgets/database/query_builder.dart';
import 'package:prac_res/core/widgets/editable_text.dart';

import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/widgets/outlined_button.dart';
import 'package:prac_res/features/editor/screens/editor_page.dart';
import 'package:prac_res/features/editor/widgets/custom_scene_part_inspector.dart';
import 'package:prac_res/features/editor/widgets/frame_inspector.dart';
import 'package:prac_res/features/editor/widgets/scene_part_resolver_inspector.dart';
import 'package:prac_res/features/play/screens/play_mode.dart';
import 'package:prac_res/features/scene_viewer/widgets/selected_scene_part.dart';

class NovelInspector extends StatelessWidget {
  const NovelInspector({super.key});

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) =>
          ref.watch(NovelSelectedScenePart.selectedScenePartProvider),
      builder: (context, ref, selectedScenePart) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedScenePart != null) ...[
              Row(
                spacing: DesignValues.small,
                children: [
                  NovelCopyableText(
                    displayText: Text("Id: ${selectedScenePart.part.id}"),
                    copyText: selectedScenePart.part.id.toString(),
                  ),
                  NovelOutlinedButton(
                    onPressed: () async {
                      await ref.read(playingScenePartProvider.notifier).next();
                    },
                    child: Text("Next"),
                  ),
                ],
              ),
              Divider(),
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
        );
      },
    );
  }
}

class NovelCopyableText extends StatelessWidget {
  final Widget displayText;
  final String copyText;

  const NovelCopyableText({
    super.key,
    required this.displayText,
    required this.copyText,
  });

  @override
  Widget build(BuildContext context) {
    return NovelOutlinedButton(
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: copyText));

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Copied to clipboard!')));
      },
      child: displayText,
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
