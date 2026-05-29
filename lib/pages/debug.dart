import 'package:flutter/material.dart';

class NovelDebugBox extends StatelessWidget {
  final bool debug;
  final Widget child;

  const NovelDebugBox({super.key, required this.child, this.debug = true});

  @override
  Widget build(BuildContext context) {
    return (debug)
        ? ColoredBox(color: Colors.red, child: SizedBox.expand())
        : child;
  }
}
