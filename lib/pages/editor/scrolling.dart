import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SingleChildScrollbarView extends StatelessWidget {
  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final Widget? child;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final HitTestBehavior hitTestBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  final bool? thumbVisibility;
  final bool? trackVisibility;
  final double? thickness;
  final Radius? radius;
  final bool? interactive;
  final ScrollNotificationPredicate? notificationPredicate;
  final ScrollbarOrientation? scrollbarOrientation;

  const SingleChildScrollbarView({
    super.key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.child,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.restorationId,
    this.keyboardDismissBehavior,

    this.thumbVisibility,
    this.trackVisibility,
    this.thickness,
    this.radius,
    this.interactive,
    this.notificationPredicate,
    this.scrollbarOrientation,
  });

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        // SAFETY: I believe these two lines should stay as two separate lines.
        // The ?? operator short circuits if you condense them, and that makes calling the hook conditional, right?
        // And calling hooks conditionally is BAD.
        final defaultController = useScrollController();
        final scrollController = controller ?? defaultController;

        return Scrollbar(
          controller: scrollController,
          thumbVisibility: thumbVisibility,
          trackVisibility: trackVisibility,
          thickness: thickness,
          radius: radius,
          interactive: interactive,
          notificationPredicate: notificationPredicate,
          scrollbarOrientation: scrollbarOrientation,

          child: SingleChildScrollView(
            scrollDirection: scrollDirection,
            reverse: reverse,
            padding: padding,
            primary: primary,
            physics: physics,
            controller: scrollController,
            dragStartBehavior: dragStartBehavior,
            clipBehavior: clipBehavior,
            hitTestBehavior: hitTestBehavior,
            restorationId: restorationId,
            keyboardDismissBehavior: keyboardDismissBehavior,
            child: child,
          ),
        );
      },
    );
  }
}
