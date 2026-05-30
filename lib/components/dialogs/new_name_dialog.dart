import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
