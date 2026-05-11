import 'package:flutter/material.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/editor/inspector/inspector.dart';
import 'package:prac_res/pages/editor/scene_part_timeline.dart';
import 'package:prac_res/pages/editor/scene_selector.dart';

class NovelEditorPage extends StatelessWidget {
  const NovelEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NovelMenuBar(),
      body: Padding(
        padding: EdgeInsets.all(DesignValues.small),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 3, child: NovelSceneSelector()),
            VerticalDivider(),
            Expanded(flex: 9, child: NovelScenePartTimeline()),
            VerticalDivider(),
            Expanded(flex: 3, child: NovelInspector()),
          ],
        ),
      ),
    );
  }
}

class NovelMenuBar extends StatelessWidget implements PreferredSizeWidget {
  const NovelMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 45,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DesignValues.small),
          child: const Divider(height: 1.0),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
