import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:prac_res/components/states/loading.dart';
import 'package:prac_res/components/design_values.dart';

class NovelLoadingPage<T> extends StatelessWidget {
  final Future<T> Function(BuildContext context) loader;
  final double sideLength;

  const NovelLoadingPage({
    required this.loader,
    super.key,
    this.sideLength = DesignValues.large * (1 + DesignValues.semiLargePercent),
  });

  static Future<void> load<T>(
    BuildContext context,
    Future<T> Function(BuildContext context) loader,
  ) async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => NovelLoadingPage(loader: loader)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HookBuilder(
        builder: (context) {
          useEffect(() {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              loader(context);
            });

            return null;
          }, []);

          return NovelLoading(sideLength: sideLength);
        },
      ),
    );
  }
}
