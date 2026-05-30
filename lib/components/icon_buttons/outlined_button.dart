import 'package:flutter/material.dart';
import 'package:prac_res/components/icon_buttons/fitted_icon.dart';
import 'package:prac_res/components/design_values.dart';

class NovelOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final double iconSizePercentage;
  final ButtonStyle? style;

  const NovelOutlinedButton({
    required this.onPressed,
    required this.icon,
    this.iconSizePercentage = DesignValues.semiLargePercent,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: OutlinedButton(
        onPressed: onPressed,
        style:
            style ??
            OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DesignValues.medium),
              ),
              padding: EdgeInsets.all(DesignValues.semiSmall),
            ),
        child: NovelFittedIcon(icon: icon, sizePercentage: iconSizePercentage),
      ),
    );
  }
}
