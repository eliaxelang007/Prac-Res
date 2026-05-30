import 'package:flutter/material.dart';

class NovelFittedIcon extends StatelessWidget {
  final Widget icon;
  final BoxFit fit;
  final double sizePercentage;

  const NovelFittedIcon({
    super.key,
    required this.icon,
    required this.sizePercentage,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    const double kArbitrarySize = 500;

    return FittedBox(
      fit: fit,
      child: SizedBox(
        width: kArbitrarySize,
        height: kArbitrarySize,
        child: Center(
          child: IconTheme(
            data: Theme.of(
              context,
            ).iconTheme.copyWith(size: kArbitrarySize * sizePercentage),
            child: icon,
          ),
        ),
      ),
    );
  }
}
