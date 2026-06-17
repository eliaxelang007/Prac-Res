import 'package:flutter/material.dart';
import 'package:prac_res/components/dialogs/yes_no_dialogue.dart';

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
    final title = Text('Are you sure?');
    final content = Text("This will delete what you've selected.");

    final no = Text("Cancel");
    final yes = Text("I'm sure.");

    return NovelYesNoDialogue(title: title, content: content, no: no, yes: yes);
  }
}
