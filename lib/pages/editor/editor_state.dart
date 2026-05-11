import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/data/data.dart';

class SceneGroupNotifier extends Notifier<SceneGroup> {
  @override
  SceneGroup build() => SceneGroup.instance;

  void set(SceneGroup newSceneGroup) {
    state = newSceneGroup;
  }
}

final selectedSceneGroupProvider =
    NotifierProvider<SceneGroupNotifier, SceneGroup>(SceneGroupNotifier.new);

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
