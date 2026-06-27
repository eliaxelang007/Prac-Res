import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/features/custom/screens/cooking.dart';

final customScenePartProvider = Provider.family<Widget?, String>((
  ref,
  eventId,
) {
  final customWidgets = {"cooking_minigame": NovelCookingMinigame()};

  return customWidgets[eventId];
});
