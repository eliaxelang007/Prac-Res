import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/editor/scene_viewer.dart';
import 'package:prac_res/pages/frame/frame.dart';
import 'package:prac_res/pages/open.dart';

class SelectedSceneIdProvider extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? id) {
    state = id;
    ref.read(selectedScenePartIdProvider.notifier).set(null);
  }
}

final selectedSceneIdProvider = NotifierProvider<SelectedSceneIdProvider, int?>(
  SelectedSceneIdProvider.new,
);

class NovelSceneSelector extends StatelessWidget {
  const NovelSceneSelector({super.key});

  static final scenesProvider = StreamProvider((ref) {
    final sceneGroup = ref.watch(sceneGroupProvider);

    return sceneGroup.scenes.select().watch();
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final textTheme = Theme.of(context).textTheme;
        final selectedScene = ref.watch(selectedSceneIdProvider);

        return RadioGroup<int>(
          onChanged: (selection) {
            ref.read(selectedSceneIdProvider.notifier).set(selection);
          },
          groupValue: selectedScene,
          child: NovelQueryBuilder(
            provider: scenesProvider,
            builder: (context, ref, scenes) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Scenes", style: textTheme.bodyLarge),
                const Divider(),

                ...scenes.map(
                  (scene) => RadioListTile(
                    value: scene.id,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            scene.name,
                            style: textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              final answer = await NovelDeletionDialog.show(
                                context,
                              );

                              if (answer != true) return;

                              final sceneGroup = ref.read(sceneGroupProvider);

                              await (sceneGroup.delete(sceneGroup.scenes)
                                    ..where(
                                      (sceneEntry) =>
                                          sceneEntry.id.equals(scene.id),
                                    ))
                                  .go();
                            },
                          ),
                        ),
                      ],
                    ),
                    toggleable: true,
                  ),
                ),

                IconButton(
                  onPressed: () async {
                    final sceneName = await NovelNewNameDialog.show(
                      context,
                      title: "New Scene",
                    );

                    if (sceneName == null) {
                      return;
                    }

                    final sceneGroup = ref.read(sceneGroupProvider);

                    sceneGroup
                        .into(sceneGroup.scenes)
                        .insert(ScenesCompanion.insert(name: sceneName));
                  },
                  icon: Icon(Icons.add_rounded),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
