import 'package:flutter/material.dart';
import 'package:prac_res/game_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: Frame(),
    );
  }
}

void main() {
  runApp(const App());
}
