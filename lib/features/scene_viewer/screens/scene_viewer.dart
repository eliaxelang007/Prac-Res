import 'package:flutter/material.dart';
import 'package:prac_res/core/theme/design_values.dart';
import 'package:prac_res/features/scene_viewer/widgets/scene_timeline.dart';
import 'package:prac_res/features/scene_viewer/widgets/selected_scene_part.dart';

class NovelSceneViewer extends StatelessWidget {
  const NovelSceneViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(DesignValues.veryLarge),
              child: NovelSelectedScenePart(),
            ),
          ),
        ),
        const Divider(),
        Expanded(child: NovelSceneTimeline()),
      ],
    );
  }
}
