import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NovelEditableText extends StatelessWidget {
  final String sourceText;
  final Widget Function(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode,
  )
  builder;

  const NovelEditableText({
    super.key,
    required this.builder,
    required this.sourceText,
  });

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final controller = useTextEditingController(text: sourceText);
        final focusNode = useFocusNode();

        useEffect(() {
          void syncText() {
            if (!focusNode.hasFocus && sourceText != controller.text) {
              controller.text = sourceText;
            }
          }

          syncText();

          focusNode.addListener(syncText);

          return () {
            focusNode.removeListener(syncText);
          };
        }, [sourceText]);

        return builder(context, controller, focusNode);
      },
    );
  }
}
