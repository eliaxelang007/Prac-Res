import 'package:flutter/material.dart';
import 'package:prac_res/core/theme/design_values.dart';

class NovelOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final ButtonStyle? style;

  const NovelOutlinedButton({
    required this.onPressed,
    required this.child,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style:
          style ??
          OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DesignValues.medium),
            ),
            padding: EdgeInsets.all(DesignValues.semiSmall),
          ),
      child: child,
    );
  }
}
