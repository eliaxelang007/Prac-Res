import 'package:flutter/material.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/open.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sociolingo Editor',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ).copyWith(extensions: const <ThemeExtension<dynamic>>[DesignValues()]),
      home: NovelOpenPage(),
    );
  }
}

void main() {
  runApp(const App());
}
