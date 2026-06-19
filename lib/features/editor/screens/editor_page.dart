import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junction/junction.dart';
import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/database/web.dart';
import 'package:prac_res/core/theme/design_values.dart';
import 'package:prac_res/core/widgets/outlined_button.dart';
import 'package:prac_res/features/editor/widgets/novel_inspector.dart';
import 'package:prac_res/features/editor/widgets/scene_selector.dart';
import 'package:prac_res/features/scene_viewer/screens/scene_viewer.dart';

class SceneGroupNotifier extends Notifier<SceneGroup> {
  @override
  SceneGroup build() => SceneGroupManager.instance.sceneGroup;

  void set(SceneGroup newSceneGroup) {
    state = newSceneGroup;
    ref.read(NovelSceneSelector.selectedSceneIdProvider.notifier).set(null);
  }
}

class NovelSceneGroupEditorPage extends StatelessWidget {
  const NovelSceneGroupEditorPage({super.key});

  static final sceneGroupProvider =
      NotifierProvider<SceneGroupNotifier, SceneGroup>(SceneGroupNotifier.new);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        toolbarHeight: 45,
        title: Consumer(
          builder: (context, ref, child) {
            return NovelOutlinedButton(
              onPressed: () async {
                final name = await SceneGroupManager.databaseDisplayName();

                await WebWriteHandle().write(
                  CrossInMemoryFile(
                    name: CrossFilesystemName(
                      (name.endsWith(".novel")) ? name : "$name.novel",
                    ),
                    data: CrossFileData(
                      bytes: await SceneGroupManager.toBytes(),
                    ),
                  ),
                );
              },
              child: Text("Save"),
            );
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: DesignValues.small),
            child: Divider(height: 1.0),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(DesignValues.small),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(DesignValues.verySmall),
                child: SizedBox.expand(child: NovelSceneSelector()),
              ),
            ),
            VerticalDivider(),
            Expanded(
              flex: 9,
              child: Padding(
                padding: EdgeInsets.all(DesignValues.verySmall),
                child: NovelSceneViewer(),
              ),
            ),
            VerticalDivider(),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(DesignValues.verySmall),
                child: NovelInspector(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
