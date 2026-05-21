import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:handy/handy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/frame/animated_list.dart';
import 'package:prac_res/pages/loading.dart';
import 'package:prac_res/pages/open.dart';

class NovelFrame extends ConsumerWidget {
  const NovelFrame({super.key, required this.frame});

  final Frame frame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commonPhoneResolution = const Size(800, 360); // 20:9 Aspect Ratio

    final backgroundId = frame.backgroundId;

    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(
            color: Colors.white,
            child: Center(
              child: Icon(Icons.image_not_supported_rounded, size: 50),
            ),
          ),
        ),

        if (backgroundId != null)
          Positioned.fill(child: NovelBackground(backgroundId: backgroundId)),

        Positioned.fill(
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: SizedBox(
              width: commonPhoneResolution.width,
              height: commonPhoneResolution.height,
              child: NovelFrameSafeArea(scenePartId: frame.scenePartId),
            ),
          ),
        ),
      ],
    );
  }
}

class NovelBackground extends StatelessWidget {
  final Duration fadeDuration;
  final int backgroundId;

  const NovelBackground({
    super.key,
    required this.backgroundId,
    this.fadeDuration = const Duration(milliseconds: 500),
  });

  static final backgroundImageProvider = StreamProvider.family<Background, int>(
    (ref, backgroundId) {
      final db = ref.watch(sceneGroupProvider);

      return (db.backgrounds.select()
            ..where((background) => background.id.equals(backgroundId)))
          .watchSingle();
    },
  );

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      provider: backgroundImageProvider(backgroundId),
      builder: (context, ref, data) => AnimatedSwitcher(
        duration: fadeDuration,
        child: Image.memory(key: ValueKey(data.id), data.imageData),
      ),
    );
  }
}

class NovelFrameSafeArea extends StatelessWidget {
  final int scenePartId;

  const NovelFrameSafeArea({super.key, required this.scenePartId});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                left: DesignValues.large * 5,
                right: DesignValues.large * 5,
                top: DesignValues.large,
              ),
              child: NovelPoses(scenePartId: scenePartId),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                left: DesignValues.large * 5,
                right: DesignValues.large * 5,
                bottom: DesignValues.medium,
              ),
              child: NovelDialogueArea(scenePartId: scenePartId),
            ),
          ),
        ],
      ),
    );
  }
}

class NovelDialogueArea extends StatelessWidget {
  final int scenePartId;

  const NovelDialogueArea({super.key, required this.scenePartId});

  static final dialogueProvider = StreamProvider.family<DialogueBoxe?, int>((
    ref,
    scenePartId,
  ) {
    final db = ref.watch(sceneGroupProvider);

    return (db.dialogueBoxes.select()
          ..where((b) => b.frameScenePartId.equals(scenePartId)))
        .watchSingleOrNull();
  });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      provider: dialogueProvider(scenePartId),
      builder: (context, ref, dialog) {
        if (dialog != null) {
          final name = dialog.name;
          final dialogue = dialog.dialogue;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: DesignValues.large * 1.2,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: DesignValues.large,
                    right: DesignValues.large * 10,
                  ),
                  child: (name != null) ? NovelNameBox(name: Text(name)) : null,
                ),
              ),
              SizedBox(
                height: DesignValues.large * 3,
                child: NovelDialogueBox(
                  dialogue: AnimatedTextKit(
                    key: ValueKey(dialogue),
                    animatedTexts: [
                      TypewriterAnimatedText(
                        dialogue,
                        speed: const Duration(milliseconds: 50),
                        cursor: "",
                      ),
                    ],
                    totalRepeatCount: 1,
                  ),
                ),
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class NovelPoses extends StatelessWidget {
  final Duration popDuration;
  final Duration slideDuration;
  final int scenePartId;

  const NovelPoses({
    super.key,
    required this.scenePartId,
    this.slideDuration = const Duration(milliseconds: 500),
    this.popDuration = const Duration(milliseconds: 400),
  });

  static final poseProvider =
      StreamProvider.family<List<FramePosesViewData>, int>((ref, scenePartId) {
        final db = ref.watch(sceneGroupProvider);

        return (db.framePosesView.select()
              ..where(
                (framePose) => framePose.frameScenePartId.equals(scenePartId),
              )
              ..orderBy([
                (framePose) => OrderingTerm(expression: framePose.order),
              ]))
            .watch();
      });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      provider: poseProvider(scenePartId),
      builder: (context, ref, framePoses) => Center(
        child: ImplicitlyAnimatedList(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          animateChild: (context, _, widget, animation) {
            final driver = animation.drive(
              CurveTween(curve: Curves.easeOutCubic),
            );

            return SizeTransition(
              axis: Axis.horizontal,
              sizeFactor: driver,
              child: ScaleTransition(
                scale: driver,
                child: FadeTransition(opacity: driver, child: widget),
              ),
            );
          },
          children: <Widget>[
            for (final pose in framePoses)
              Image.memory(pose.imageData, key: ValueKey(pose.actorId)),
          ].inBetween((_) => SizedBox(width: DesignValues.large)).toList(),
        ),
      ),
    );
  }
}

class NovelNameBox extends StatelessWidget {
  const NovelNameBox({required this.name, super.key});

  final Widget name;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(DesignValues.small),
        topRight: Radius.circular(DesignValues.small),
      ),
      child: ColoredBox(
        color: Colors.blueGrey,
        child: Padding(
          padding: EdgeInsets.all(DesignValues.small),
          child: name,
        ),
      ),
    );
  }
}

class NovelDialogueBox extends StatelessWidget {
  final Widget dialogue;

  const NovelDialogueBox({required this.dialogue, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(DesignValues.small),
      child: ColoredBox(
        color: Colors.blueGrey,
        child: Padding(
          padding: EdgeInsets.all(DesignValues.semiSmall),
          child: dialogue,
        ),
      ),
    );
  }
}

class NovelError extends StatelessWidget {
  final Object exception;
  final StackTrace stack;

  const NovelError({required this.exception, required this.stack, super.key});

  @override
  Widget build(BuildContext context) {
    debugPrintStack(stackTrace: stack);

    return Center(child: ErrorWidget(exception));
  }
}

class NovelQueryBuilder<QueryResult> extends StatelessWidget {
  final ProviderListenable<AsyncValue<QueryResult>> provider;
  final Widget Function(BuildContext, WidgetRef, QueryResult) builder;
  final bool skipLoadingOnReload;

  const NovelQueryBuilder({
    super.key,
    required this.provider,
    required this.builder,
    this.skipLoadingOnReload = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final result = ref.watch(provider);

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
