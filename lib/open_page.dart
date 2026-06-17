import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junction/junction.dart';
import 'package:prac_res/components/icon_buttons/fitted_icon.dart';

import 'package:prac_res/data/data.dart';
import 'package:prac_res/components/design_values.dart';
import 'package:prac_res/components/dialogs/new_name_dialog.dart';
import 'package:prac_res/components/icon_buttons/outlined_button.dart';
import 'package:prac_res/data/web.dart';
import 'package:prac_res/editor_page/editor_page.dart';
import 'package:prac_res/loading_page.dart';

class NovelOpenPage extends StatelessWidget {
  const NovelOpenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: DesignValues.large,
          children: [
            SceneGroupOpener(
              icon: Icon(Icons.add_rounded),
              buildSceneGroup: () async {
                final name = await NovelNewNameDialog.show(
                  context,
                  title: "New Scene",
                );

                if (name == null) {
                  return Future.syncValue(Future.syncValue(null));
                }

                return SceneGroupManager.replace(
                  (replacer) => replacer.empty(name),
                );
              },
            ),
            SceneGroupOpener(
              icon: Icon(Icons.arrow_right_rounded),
              buildSceneGroup: () async {
                final loaded = Future.value(
                  Future.value(SceneGroupManager.instance.sceneGroup),
                );
                return loaded;
              },
            ),
            SceneGroupOpener(
              icon: Icon(Icons.file_open_rounded),
              buildSceneGroup: () async {
                final selected = await WebReadHandle.showOpenFileDialog(
                  accept: [
                    XTypeGroup(extensions: ["novel", "db"]),
                  ],
                );

                if (selected.isEmpty) {
                  return Future.syncValue(Future.syncValue(null));
                }

                final computeSceneGroup = compute((selected) async {
                  final file = await selected.first.read();

                  return await SceneGroupManager.replace((replacer) {
                    return replacer.fromBytes(file.key, file.value.bytes);
                  });
                }, selected);

                return computeSceneGroup;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SceneGroupOpener extends StatelessWidget {
  final Widget icon;
  final Future<Future<SceneGroup?>> Function() buildSceneGroup;

  const SceneGroupOpener({
    super.key,
    required this.buildSceneGroup,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DesignValues.veryLarge * 2,
      child: Consumer(
        builder: (context, ref, _) {
          return AspectRatio(
            aspectRatio: 1,
            child: NovelOutlinedButton(
              onPressed: () async {
                final sceneGroupFuture = await buildSceneGroup();

                await NovelLoadingPage.load(context, (context) async {
                  final sceneGroup = await sceneGroupFuture;

                  final navigator = Navigator.of(context);

                  if (sceneGroup == null) {
                    navigator.pop();
                    return;
                  }

                  ref
                      .read(
                        NovelSceneGroupEditorPage.sceneGroupProvider.notifier,
                      )
                      .set(sceneGroup);

                  // SAFETY: This should be safe because [context] shouldn't unmount until this navigator function pushes through!
                  await navigator.pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => NovelSceneGroupEditorPage(),
                    ),
                  );
                });
              },
              child: NovelFittedIcon(
                icon: icon,
                sizePercentage: DesignValues.semiLargePercent,
              ),
            ),
          );
        },
      ),
    );
  }
}
