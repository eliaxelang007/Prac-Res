import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/pages/open.dart';
import 'package:drift/drift.dart';

import 'package:stack_trace/stack_trace.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sociolingo Editor',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: NovelOpenPage(),
    );
  }
}

void main() {
  // SAFETY: If we're not properly calling close on the database before we open a new one, this is unsafe.
  // As of May 13, 2026, we are, so this is safe. Periodically update this so that we know it's still safe.
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  // SAFETY: For some reason, when Drift returns stack traces, they're from package:stack_trace. That's why this demangle function has to be here.
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is Trace) return stack.vmTrace;
    if (stack is Chain) return stack.toTrace().vmTrace;

    return stack;
  };

  runApp(const ProviderScope(child: App()));
}
