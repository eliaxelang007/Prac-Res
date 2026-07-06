import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/widgets/fitted_icon.dart';
import 'package:prac_res/features/custom/screens/provider.dart';

class NovelCustomScenePart extends StatelessWidget {
  final CustomScenePart custom;
  final bool show;

  const NovelCustomScenePart({
    super.key,
    required this.custom,
    required this.show,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final customWidget = ref.watch(customScenePartProvider(custom.eventId));

        if (customWidget != null && show) {
          return customWidget;
        }

        return NovelFittedIcon(
          icon: Icon(Icons.build_circle_rounded),
          sizePercentage: 0.5,
        );
      },
    );
  }
}
