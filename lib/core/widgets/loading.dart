import 'package:flutter/material.dart';
import 'package:prac_res/core/theme/design_values.dart';

class NovelLoading extends StatelessWidget {
  final double sideLength;

  const NovelLoading({
    super.key,
    this.sideLength = DesignValues.large * (1 + DesignValues.semiLargePercent),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: sideLength,
        height: sideLength,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
