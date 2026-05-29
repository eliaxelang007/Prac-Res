import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junction/junction.dart';
import 'package:prac_res/data/data.dart';

import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/editor/editor.dart';
import 'package:prac_res/pages/editor/scene_viewer.dart';
import 'package:prac_res/pages/loading.dart';

class SceneGroupNotifier extends Notifier<SceneGroup> {
  @override
  SceneGroup build() => SceneGroup.instance;

  void set(SceneGroup newSceneGroup) {
    state = newSceneGroup;
  }
}

final sceneGroupProvider = NotifierProvider<SceneGroupNotifier, SceneGroup>(
  SceneGroupNotifier.new,
);

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
            sceneOpener(
              context,
              icon: Icon(Icons.add_rounded),
              buildSceneGroup: () async {
                final name = await NovelNewNameDialog.show(
                  context,
                  title: "New Scene",
                );

                if (name == null) {
                  return Future.syncValue(Future.syncValue(null));
                }

                return SceneGroup.instance.replace(
                  (replacer) => replacer.empty(name),
                );
              },
            ),
            sceneOpener(
              context,
              icon: Icon(Icons.file_open_rounded),
              buildSceneGroup: () async {
                final selected = await WebReadHandle.showOpenFileDialog(
                  accept: [
                    XTypeGroup(extensions: ["novel"]),
                  ],
                );

                if (selected.isEmpty) {
                  return Future.syncValue(Future.syncValue(null));
                }

                final computeSceneGroup = compute((selected) async {
                  final file = await selected.first.read();

                  return await SceneGroup.instance.replace((replacer) {
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

  Widget sceneOpener(
    BuildContext context, {
    required Icon icon,
    required Future<Future<SceneGroup?>> Function() buildSceneGroup,
  }) {
    return SizedBox(
      width: DesignValues.veryLarge * 2,
      child: Consumer(
        builder: (context, ref, _) {
          return NovelIconButton(
            onPressed: () async {
              final sceneGroupFuture = await buildSceneGroup();

              await NovelLoadingPage.load(context, (context) async {
                final sceneGroup = await sceneGroupFuture;

                final naviagtor = Navigator.of(context);

                if (sceneGroup == null) {
                  naviagtor.pop();
                  return;
                }

                ref.read(sceneGroupProvider.notifier).set(sceneGroup);

                // SAFETY: This should be safe because [context] shouldn't unmount until this navigator function pushes through!
                await naviagtor.pushReplacement(
                  MaterialPageRoute(builder: (context) => NovelEditorPage()),
                );
              });
            },
            icon: icon,
          );
        },
      ),
    );
  }
}

class NovelIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final double iconSizePercentage;
  final ButtonStyle? style;

  const NovelIconButton({
    required this.onPressed,
    required this.icon,
    this.iconSizePercentage = DesignValues.semiLargePercent,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: OutlinedButton(
        onPressed: onPressed,
        style:
            style ??
            OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DesignValues.medium),
              ),
              padding: EdgeInsets.all(DesignValues.semiSmall),
            ),
        child: NovelFittedIcon(icon: icon, sizePercentage: iconSizePercentage),
      ),
    );
  }
}

class NovelNewNameDialog extends StatelessWidget {
  final String title;
  final String? initialText;

  const NovelNewNameDialog({super.key, required this.title, this.initialText});

  static Future<String?> show(
    BuildContext context, {
    required String title,
    String? initialText,
  }) {
    return showDialog(
      context: context,
      builder: (context) =>
          NovelNewNameDialog(title: title, initialText: initialText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final controller = useTextEditingController(text: initialText);

        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(hintText: "Pick a name!"),
            onSubmitted: (value) => Navigator.of(context).pop(value),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}

class NovelDeletionDialog extends StatelessWidget {
  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool?>(
      context: context,
      builder: (context) {
        return NovelDeletionDialog();
      },
    );

    return (result != null) ? result : false;
  }

  const NovelDeletionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure?'),
      content: Text("This will delete what you've selected."),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text("I'm sure."),
        ),
      ],
    );
  }
}
