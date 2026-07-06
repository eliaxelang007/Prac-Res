import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/features/custom/screens/cooking.dart';
import 'package:prac_res/features/custom/screens/summary.dart';

final customScenePartProvider = Provider.family<Widget?, String>((
  ref,
  eventId,
) {
  final customWidgets = {
    "cooking_minigame1": NovelCookingMinigame1(),
    "cooking_minigame2": NovelCookingMinigame2(),
    "cooking_minigame3": NovelCookingMinigame3(),
    "pre_cooking_minigame4": NovelPreCookingMinigame4(),
    "cooking_minigame4": NovelCookingMinigame4(),
    "cooking_minigame5": NovelCookingMinigame5(),
    "summary": NovelSummary(),
  };

  return customWidgets[eventId];
});
