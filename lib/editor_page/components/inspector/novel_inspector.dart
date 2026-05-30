import 'package:flutter/material.dart';

import 'package:prac_res/data/data.dart';
import 'package:prac_res/components/database/query_builder.dart';

import 'package:prac_res/editor_page/components/scene_viewer/components/selected_scene_part.dart';
import 'package:prac_res/editor_page/components/inspector/components/frame_inspector/frame_inspector.dart';
import 'package:prac_res/editor_page/components/inspector/components/scene_part_resolver_inspector.dart';
import 'package:prac_res/editor_page/components/inspector/components/custom_scene_part_inspector.dart';

class NovelInspector extends StatelessWidget {
  const NovelInspector({super.key});

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) =>
          ref.watch(NovelSelectedScenePart.selectedScenePartProvider),
      builder: (context, ref, selectedScenePart) => (selectedScenePart != null)
          ? switch (selectedScenePart.specifics) {
              TimelineFrame(:final frameData) => NovelFrameInspector(
                frame: frameData,
              ),
              TimelineResolver(:final resolverData) =>
                NovelScenePartResolverInspector(resolver: resolverData),
              TimelineCustom(:final customData) =>
                NovelCustomScenePartInspector(custom: customData),
            }
          : SizedBox.shrink(),
    );
  }
}
