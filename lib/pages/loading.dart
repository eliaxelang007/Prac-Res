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
    return Scaffold(body: NovelLoader<T>(loader: loader));
  }
}

class NovelLoader<T> extends StatelessWidget {
  const NovelLoader({
    super.key,
    required this.loader,
    this.sideLength = DesignValues.large * (1 + DesignValues.semiLargePercent),
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

        return NovelLoading(sideLength: sideLength);
      },
    );
  }
}

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
