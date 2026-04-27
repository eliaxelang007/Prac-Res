import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prac_res/pages/design_values.dart';

class NovelLoadingPage<T> extends StatelessWidget {
  final Future<T> Function(BuildContext context) loader;

  const NovelLoadingPage({required this.loader, super.key});

  static void load<T>(
    BuildContext context,
    Future<T> Function(BuildContext context) loader,
  ) async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => NovelLoadingPage(loader: loader)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final designValues = theme.extension<DesignValues>()!;
    final sideLength = designValues.large * (1 + designValues.semiLargePercent);

    return Scaffold(
      body: NovelLoading<T>(loader: loader, sideLength: sideLength),
    );
  }
}

class NovelLoading<T> extends StatelessWidget {
  const NovelLoading({
    super.key,
    required this.loader,
    required this.sideLength,
  });

  final Future<T> Function(BuildContext context) loader;
  final double sideLength;

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        useEffect(() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            loader(context);
          });

          return null;
        }, []);

        return Center(
          child: SizedBox(
            width: sideLength,
            height: sideLength,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
