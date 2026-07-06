import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/widgets/database/query_builder.dart';
import 'package:prac_res/core/widgets/scrolling.dart';
import 'package:prac_res/features/custom/screens/cooking.dart';
import 'package:prac_res/features/editor/widgets/novel_inspector.dart';
import 'package:prac_res/features/editor/widgets/scene_part_resolver_inspector.dart';
import 'package:prac_res/features/scene_viewer/widgets/frame.dart';

class NovelSummary extends StatelessWidget {
  const NovelSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return NovelFrameSafeArea(
      child: Stack(
        children: [
          Positioned.fill(child: ColoredBox(color: Colors.white)),
          Positioned.fill(
            child: Center(
              child: NovelQueryBuilder(
                query: (ref) => ref.watch(NovelChoiceOptionIds.choicesProvider),
                builder: (context, ref, choices) {
                  return NovelQueryBuilder(
                    query: (ref) =>
                        ref.watch(NovelChoiceOptionIds.choiceOptionsProvider),
                    builder: (context, ref, choiceOptions) {
                      final Map<int, ChoiceOption> choiceToSelected = {};

                      for (final choiceOption in choiceOptions) {
                        if (choiceOption.isSelected) {
                          choiceToSelected[choiceOption.choiceId] =
                              choiceOption;
                        }
                      }

                      return SingleChildScrollbarView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollbarView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text("Action/Question")),
                              DataColumn(label: Text("Result")),
                            ],
                            rows: [
                              for (final choice in choices)
                                DataRow(
                                  cells: [
                                    DataCell(Text(choice.name)),
                                    DataCell(
                                      Text(
                                        choiceToSelected[choice.id]?.name ??
                                            "Unselected",
                                      ),
                                    ),
                                  ],
                                ),
                              DataRow(
                                cells: [
                                  DataCell(Text("*Sauce overcooked?")),
                                  DataCell(
                                    Text(
                                      ref.watch(isOvercookedState)
                                          ? "Yes"
                                          : "No",
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    Text("*Cockroach interruption delay"),
                                  ),
                                  DataCell(
                                    Text(
                                      (() {
                                        final secondsElapsed = ref.watch(
                                          secondsElapsedState,
                                        );

                                        final minutes = (secondsElapsed ~/ 60)
                                            .toString()
                                            .padLeft(2, '0');
                                        final seconds = (secondsElapsed % 60)
                                            .toString()
                                            .padLeft(2, '0');

                                        return "$minutes:$seconds";
                                      })(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
