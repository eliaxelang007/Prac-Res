import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/core/widgets/scrolling.dart';

import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/widgets/database/group_selector.dart';
import 'package:prac_res/features/editor/screens/editor_page.dart';
import 'package:prac_res/features/scene_viewer/widgets/selected_scene_part.dart';

class SelectedSceneIdNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? id) {
    ref
        .read(NovelSelectedScenePart.selectedScenePartIdProvider.notifier)
        .set(null);

    state = id;
  }
}

class NovelSceneSelector extends StatelessWidget {
  const NovelSceneSelector({super.key});

  static final selectedSceneIdProvider =
      NotifierProvider<SelectedSceneIdNotifier, int?>(
        SelectedSceneIdNotifier.new,
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
