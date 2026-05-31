import 'package:flutter/material.dart';

import 'package:prac_res/data/data.dart';

import 'package:prac_res/components/lists/scrolling.dart';
import 'package:prac_res/editor_page/components/inspector/components/frame_inspector/components/background_inspector.dart';
import 'package:prac_res/editor_page/components/inspector/components/frame_inspector/components/interaction_inspector.dart';
import 'package:prac_res/editor_page/components/inspector/components/frame_inspector/components/poses_inspector.dart';

class NovelFrameInspector extends StatelessWidget {
  // This has to be passed in, it can't just be provided because the [selectedScenePartProvider]s are nullable.
  final Frame frame;

  const NovelFrameInspector({super.key, required this.frame});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollbarView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Interaction", style: textTheme.bodyMedium),
          NovelInteractionInspector(frameScenePartId: frame.scenePartId),
          Divider(),
          Text("Poses", style: textTheme.bodyMedium),
          NovelPosesInspector(selectedScenePartId: frame.scenePartId),
          Divider(),
          Text("Background", style: textTheme.bodyMedium),
          NovelBackgroundInspector(
            selectedBackgroundId: frame.backgroundId,
            selectedFrameScenePartId: frame.scenePartId,
          ),
        ],
      ),
    );
  }
}
