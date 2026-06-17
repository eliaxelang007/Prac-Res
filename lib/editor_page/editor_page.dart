import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junction/junction.dart';
import 'package:prac_res/components/icon_buttons/outlined_button.dart';

import 'package:prac_res/data/data.dart';
import 'package:prac_res/components/design_values.dart';
import 'package:prac_res/data/web.dart';
import 'package:prac_res/editor_page/components/scene_selector.dart';
import 'package:prac_res/editor_page/components/inspector/novel_inspector.dart';
import 'package:prac_res/editor_page/components/scene_viewer/scene_viewer.dart';

class SceneGroupNotifier extends Notifier<SceneGroup> {
  @override
  SceneGroup build() => SceneGroupManager.instance.sceneGroup;

  void set(SceneGroup newSceneGroup) {
    state = newSceneGroup;
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
                await WebWriteHandle().write(
                  CrossInMemoryFile(
                    name: CrossFilesystemName(
                      "${await SceneGroupManager.databaseDisplayName()}.novel",
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
