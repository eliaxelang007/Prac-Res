import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/theme/design_values.dart';
import 'package:prac_res/core/widgets/editable_text.dart';
import 'package:prac_res/core/widgets/scrolling.dart';
import 'package:prac_res/features/editor/screens/editor_page.dart';

class NovelCustomScenePartInspector extends StatelessWidget {
  final CustomScenePart custom;

  const NovelCustomScenePartInspector({super.key, required this.custom});

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    Text sectionTitle(String text) => Text(text, style: bodyMedium);

    return SingleChildScrollbarView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle("Event ID"),
          NovelEventIdInspector(custom: custom),
        ],
      ),
    );
  }
}

class NovelEventIdInspector extends StatelessWidget {
  const NovelEventIdInspector({super.key, required this.custom});

  final CustomScenePart custom;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(DesignValues.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return NovelEditableText(
                  builder: (context, controller, focusNode) {
                    return TextField(
                      focusNode: focusNode,
                      controller: controller,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Event ID",
                      ),
                      onChanged: (newEventId) async {
                        await (ref
                                .read(
                                  NovelSceneGroupEditorPage.sceneGroupProvider,
                                )
                                .customSceneParts
                                .update()
                              ..where(
                                (customScenePartEntry) => customScenePartEntry
                                    .scenePartId
                                    .equals(custom.scenePartId),
                              ))
                            .write(
                              CustomScenePartsCompanion(
                                eventId: Value(newEventId),
                              ),
                            );
                      },
                    );
                  },
                  sourceText: custom.eventId,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
