import 'package:flutter/material.dart';

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
