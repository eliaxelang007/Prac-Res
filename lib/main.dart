import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/pages/open.dart';
import 'package:drift/drift.dart';

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

  runApp(ProviderScope(child: App()));
}
