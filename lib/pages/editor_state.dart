import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/data/data.dart';

class SelectedSceneGroup extends Notifier<SceneGroup?> {
  @override
  SceneGroup? build() {
    ref.keepAlive();
    return null;
  }

  void set(SceneGroup? sceneGroup) {
    state = sceneGroup;
    ref.read(selectedSceneProvider.notifier).set(null);
  }
}

final selectedSceneGroupProvider =
    NotifierProvider<SelectedSceneGroup, SceneGroup?>(SelectedSceneGroup.new);

class SelectedScene extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? id) {
    state = id;
    ref.read(selectedScenePartProvider.notifier).set(null);
  }
}

final selectedSceneProvider = NotifierProvider<SelectedScene, int?>(
  SelectedScene.new,
);

class SelectedScenePart extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? id) {
    state = id;
  }
}

final selectedScenePartProvider = NotifierProvider<SelectedScenePart, int?>(
  SelectedScenePart.new,
);
