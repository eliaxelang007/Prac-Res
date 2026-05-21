import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prac_res/utilities/lists.dart';

class ImplicitlyAnimatedList extends StatelessWidget {
  final List<Widget> children;
  final Widget Function(
    BuildContext,
    int index,
    Widget widget,
    Animation<double> animation,
  )
  animateChild;

  final Duration insertDuration;
  final Duration removeDuration;

  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final Clip clipBehavior;

  const ImplicitlyAnimatedList({
    super.key,
    required this.children,
    required this.animateChild,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.clipBehavior = Clip.hardEdge,
    this.insertDuration = const Duration(milliseconds: 300),
    this.removeDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final animatedListKey = useMemoized(
          () => GlobalKey<AnimatedListState>(),
        );
        final previousChildren = useMemoized(() => [...children]);

        useEffect(() {
          final (differences, _) = differencesAndLCS(
            previousChildren,
            children,
            isEqual: (Widget a, Widget b) => a.key == b.key,
          );

          for (final difference in differences) {
            switch (difference) {
              case Insert(:final value, :final at):
                previousChildren.insert(at, value);
                animatedListKey.currentState?.insertItem(
                  at,
                  duration: insertDuration,
                );

              case Remove(:final at):
                final removed = previousChildren.removeAt(at);
                animatedListKey.currentState?.removeItem(
                  at,
                  (context, animation) =>
                      animateChild(context, at, removed, animation),
                  duration: removeDuration,
                );
            }
          }

          return null;
        }, [children]);

        return AnimatedList(
          key: animatedListKey,
          itemBuilder: (context, index, animation) =>
              animateChild(context, index, previousChildren[index], animation),
          initialItemCount: previousChildren.length,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          clipBehavior: clipBehavior,
        );
      },
    );
  }
}
