import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/components/lists/scrolling.dart';

import 'package:prac_res/data/data.dart';
import 'package:prac_res/components/database/group_selector.dart';
import 'package:prac_res/editor_page/editor_page.dart';
import 'package:prac_res/editor_page/components/scene_viewer/components/selected_scene_part.dart';

class SelectedSceneIdProvider extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? id) {
    state = id;
    ref
        .read(NovelSelectedScenePart.selectedScenePartIdProvider.notifier)
        .set(null);
  }
}

class NovelSceneSelector extends StatelessWidget {
  const NovelSceneSelector({super.key});

  static final selectedSceneIdProvider =
      NotifierProvider<SelectedSceneIdProvider, int?>(
        SelectedSceneIdProvider.new,
      );

  static final scenesTableProvider = Provider<$ScenesTable>((ref) {
    final sceneGroup = ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider);

    return sceneGroup.scenes;
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return SingleChildScrollbarView(
          scrollDirection: Axis.vertical,
          child: NovelGroupSelector(
            title: Text("Scenes"),
            onChanged: (selection) {
              ref.read(selectedSceneIdProvider.notifier).set(selection);
            },
            groupTableProvider: scenesTableProvider,
            selectedGroup: ref.watch(selectedSceneIdProvider),
          ),
        );
      },
    );
  }
}
