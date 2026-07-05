import 'package:flutter/material.dart';
import 'package:prac_res/features/scene_viewer/widgets/frame.dart';

class NovelCookingMinigame extends StatelessWidget {
  const NovelCookingMinigame({super.key});

  @override
  Widget build(BuildContext context) {
    return NovelFrameFit(child: NovelFrameSafeArea(child: Placeholder()));
  }
}
