import 'package:flutter/material.dart';

class NovelYesNoDialogue extends StatelessWidget {
  static Future<bool> show(
    BuildContext context,
    Widget title,
    Widget content,
    Widget no,
    Widget yes,
  ) async {
    final result = await showDialog<bool?>(
      context: context,
      builder: (context) {
        return NovelYesNoDialogue(
          title: title,
          content: content,
          no: no,
          yes: yes,
        );
      },
    );

    return (result != null) ? result : false;
  }

  const NovelYesNoDialogue({
    super.key,
    required this.title,
    required this.content,
    required this.no,
    required this.yes,
  });

  final Widget title;
  final Widget content;
  final Widget no;
  final Widget yes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        TextButton(onPressed: () => Navigator.pop(context, false), child: no),
        TextButton(onPressed: () => Navigator.pop(context, true), child: yes),
      ],
    );
  }
}
