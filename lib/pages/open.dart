import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:junction/junction.dart';

import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/editor.dart';
import 'package:prac_res/pages/editor_state.dart';
import 'package:prac_res/pages/loading.dart';

class NovelOpenPage extends StatelessWidget {
  const NovelOpenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final designValues = theme.extension<DesignValues>()!;

    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: designValues.large,
              children: [
                SizedBox(
                  width: designValues.veryLarge * 2,
                  child: openEditor(
                    context,
                    ref,
                    Icon(Icons.add_rounded),
                    () async {
                      final name = await NovelNewNameDialog.show(
                        context,
                        title: "New Scene Group",
                      );

                      if (name == null) {
                        return null;
                      }

                      return await SceneGroup.empty(name);
                    },
                  ),
                ),
                SizedBox(
                  width: designValues.veryLarge * 2,
                  child: openEditor(
                    context,
                    ref,
                    Icon(Icons.file_open_rounded),
                    () async {
                      final selected = await WebReadHandle.showOpenFileDialog(
                        accept: [
                          XTypeGroup(extensions: ["novel"]),
                        ],
                      );

                      if (selected.isEmpty) {
                        return null;
                      }

                      return await compute((selected) async {
                        final file = await selected.first.read();
                        return SceneGroup.fromBytes(file.key, file.value.bytes);
                      }, selected);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  NovelIconButton openEditor(
    BuildContext context,
    WidgetRef ref,
    Icon icon,
    Future<SceneGroup?> Function() createSceneGroup,
  ) {
    return NovelIconButton(
      onPressed: () async {
        final selectedSceneGroup = await createSceneGroup();

        if (selectedSceneGroup == null) return;

        ref.read(selectedSceneGroupProvider.notifier).set(selectedSceneGroup);

        NovelLoadingPage.load(context, (context) async {
          // SAFETY: It should be safe to use context here because
          // [NovelLoadingPage] will not unmount until this async function completes.
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => NovelEditorPage()),
          );
        });
      },
      icon: icon,
    );
  }
}

class NovelIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final double? iconSizePercentage;
  final ButtonStyle? style;

  const NovelIconButton({
    required this.onPressed,
    required this.icon,
    this.iconSizePercentage,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final designValues = theme.extension<DesignValues>()!;

    return AspectRatio(
      aspectRatio: 1,
      child: OutlinedButton(
        onPressed: onPressed,
        style:
            style ??
            OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(designValues.medium),
              ),
              padding: EdgeInsets.all(designValues.semiSmall),
            ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return IconTheme(
              data: Theme.of(context).iconTheme.copyWith(
                size:
                    min(constraints.maxWidth, constraints.maxHeight) *
                    (iconSizePercentage ?? designValues.semiLargePercent),
              ),
              child: icon,
            );
          },
        ),
      ),
    );
  }
}

class NovelNewNameDialog extends HookWidget {
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
    final controller = useTextEditingController(text: initialText);

    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: "Enter name..."),
        onSubmitted: (value) => Navigator.of(context).pop(value),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(controller.text),
          child: const Text("Confirm"),
        ),
      ],
    );
  }
}
