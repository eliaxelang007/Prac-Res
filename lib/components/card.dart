import 'package:flutter/material.dart';
import 'package:prac_res/components/design_values.dart';

class NovelCard extends StatelessWidget {
  final bool isSelected;
  final Widget child;
  final void Function()? onTap;

  const NovelCard({
    super.key,
    required this.child,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).colorScheme.onPrimaryContainer;

    final cardBuilder = (isSelected) ? Card.outlined : Card.new;
    final shape = (isSelected)
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignValues.small),
            side: BorderSide(width: 3.0, color: selectedColor),
          )
        : null;

    return cardBuilder(
      shape: shape,
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: onTap),
            ),
          ),
        ],
      ),
    );
  }
}
