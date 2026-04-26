import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:junction/junction.dart';
import 'package:archive/archive.dart';

import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/editor.dart';
import 'package:prac_res/pages/loading.dart';

class NovelOpenPage extends StatelessWidget {
  const NovelOpenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final designValues = theme.extension<DesignValues>()!;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: designValues.large,
              children: [
                SizedBox(
                  width: designValues.veryLarge * 2,
                  child: newScene(context),
                ),
                SizedBox(
                  width: designValues.veryLarge * 2,
                  child: openScene(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  NovelIconButton openScene(BuildContext context) {
    return NovelIconButton(
      onPressed: () async {
        final selected = await WebReadHandle.showOpenFileDialog(
          accept: [
            XTypeGroup(extensions: ["zip"]),
          ],
        );

        if (selected.isEmpty) {
          return;
        }

        // SAFETY: It should be safe to use context here because
        // The file dialog should stay open as long as this widget does.
        NovelLoadingPage.load(context, (context) async {
          final sceneGroup = await compute((selected) async {
            return SceneGroup.fromArchiveData(
              ZipDecoder().decodeBytes(
                (await selected.first.read()).value.bytes,
              ),
            );
          }, selected);

          // SAFETY: It should be safe to use context here because
          // [NovelLoadingPage] will not unmount until this async function completes.
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => NovelEditorPage(sceneGroup: sceneGroup),
            ),
          );
        });
      },
      icon: Icon(Icons.file_open_rounded),
    );
  }

  NovelIconButton newScene(BuildContext context) {
    return NovelIconButton(
      onPressed: () {
        NovelLoadingPage.load(context, (context) async {
          // SAFETY: It should be safe to use context here because
          // [NovelLoadingPage] will not unmount until this async function completes.
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  NovelEditorPage(sceneGroup: SceneGroup.empty),
            ),
          );
        });
      },
      icon: Icon(Icons.add_rounded),
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
