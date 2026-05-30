import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NovelEditableText extends StatelessWidget {
  final String sourceText;
  final Widget Function(TextEditingController controller, FocusNode focusNode)
  builder;

  const NovelEditableText({
    super.key,
    required this.builder,
    this.sourceText = "",
  });

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final controller = useTextEditingController(text: sourceText);
        final focusNode = useFocusNode();

        // Safety precaution. Just in case!
        useValueChanged<String, Null>(sourceText, (_, __) {
          if (sourceText != controller.text && !focusNode.hasFocus) {
            controller.text = sourceText;
          }

          return null;
        });

        return builder(controller, focusNode);
      },
    );
  }
}
