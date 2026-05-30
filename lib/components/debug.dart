import 'package:flutter/material.dart';

class NovelDebugBox extends StatelessWidget {
  final bool debug;
  final Widget child;

  const NovelDebugBox({super.key, this.debug = false, required this.child});

  @override
  Widget build(BuildContext context) {
    return (debug)
        ? ColoredBox(color: Colors.red, child: SizedBox.expand())
        : child;
  }
}
