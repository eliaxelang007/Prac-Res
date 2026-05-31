import 'package:flutter/material.dart';

class NovelReorderableListView<T> extends StatelessWidget {
  final ScrollController? scrollController;
  final Axis scrollDirection;

  final List<T> values;

  final double? Function(T?) getOrder;

  final Widget Function(BuildContext, T) itemBuilder;

  final void Function(int oldIndex, double orderValue) onReorder;
  final void Function(double newestOrder) onAdd;

  final Widget Function(Widget) wrapAddButton;

  final bool shrinkWrap;

  const NovelReorderableListView({
    super.key,
    required this.scrollDirection,
    required this.onReorder,
    required this.onAdd,
    required this.values,
    required this.getOrder,
    required this.itemBuilder,
    required this.wrapAddButton,
    this.shrinkWrap = false,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final valueCount = values.length;

    return ReorderableListView.builder(
      shrinkWrap: shrinkWrap,
      scrollController: scrollController,
      onReorderItem: (oldIndex, newIndex) {
        final double orderValue;

        if ((newIndex + 1) == valueCount) {
          orderValue = (getOrder(values.lastOrNull) ?? -1) + 1;
        } else if (newIndex == 0) {
          orderValue = (getOrder(values.firstOrNull) ?? 1) + -1;
        } else {
          final leftIndex = newIndex - ((oldIndex > newIndex) ? 1 : 0);
          final rightIndex = leftIndex + 1;

          final beforeOrder = getOrder(values[leftIndex])!;
          final afterOrder = getOrder(values[rightIndex])!;

          orderValue = (beforeOrder + afterOrder) / 2;
        }

        onReorder(oldIndex, orderValue);
      },
      scrollDirection: scrollDirection,
      footer: wrapAddButton(
        IconButton(
          onPressed: () {
            onAdd((getOrder(values.lastOrNull) ?? -1) + 1);
          },
          icon: const Icon(Icons.add_rounded),
        ),
      ),
      itemCount: values.length,
      itemBuilder: (context, index) => itemBuilder(context, values[index]),
    );
  }
}
