import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prac_res/components/states/error.dart';
import 'package:prac_res/components/states/loading.dart';

class NovelQueryBuilder<QueryResult> extends StatelessWidget {
  final AsyncValue<QueryResult> Function(WidgetRef) query;
  final Widget Function(BuildContext, WidgetRef, QueryResult) builder;
  final bool skipLoadingOnReload;

  const NovelQueryBuilder({
    super.key,
    required this.query,
    required this.builder,
    this.skipLoadingOnReload = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final result = query(ref);

        return result.when(
          skipLoadingOnReload: skipLoadingOnReload,
          data: (data) => builder(context, ref, data),
          loading: () => NovelLoading(),
          error: (error, stack) => NovelError(exception: error, stack: stack),
        );
      },
    );
  }
}
