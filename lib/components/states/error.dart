import 'package:flutter/material.dart';

class NovelError extends StatelessWidget {
  final Object exception;
  final StackTrace stack;

  const NovelError({required this.exception, required this.stack, super.key});

  @override
  Widget build(BuildContext context) {
    debugPrintStack(stackTrace: stack);

    return Center(child: ErrorWidget(exception));
  }
}
