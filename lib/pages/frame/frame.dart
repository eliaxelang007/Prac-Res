import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/editor/editor_state.dart';
import 'package:prac_res/pages/loading.dart';

class NovelFrame extends ConsumerWidget {
  const NovelFrame({super.key, required this.frame});

  final Frame frame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commonPhoneResolution = const Size(800, 360);

    final backgroundId = frame.backgroundId;

    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(color: Colors.white, child: SizedBox.expand()),
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
  final int backgroundId;

  const NovelBackground({super.key, required this.backgroundId});

  static final backgroundImageProvider = StreamProvider.family<Background, int>(
    (ref, backgroundId) {
      final db = ref.watch(selectedSceneGroupProvider);

      return (db.backgrounds.select()
            ..where((background) => background.id.equals(backgroundId)))
          .watchSingle();
    },
  );

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      provider: backgroundImageProvider(backgroundId),
      builder: (data) => Image.memory(data.imageData),
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
          Positioned.fill(child: NovelPoses(scenePartId: scenePartId)),
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
    final db = ref.watch(selectedSceneGroupProvider);

    return (db.dialogueBoxes.select()
          ..where((b) => b.frameScenePartId.equals(scenePartId)))
        .watchSingleOrNull();
  });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      provider: dialogueProvider(scenePartId),
      builder: (dialog) {
        if (dialog != null) {
          final name = dialog.name;

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
                child: NovelDialogueBox(dialogue: Text(dialog.dialogue)),
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
  final int scenePartId;

  const NovelPoses({super.key, required this.scenePartId});

  static final poseProvider =
      StreamProvider.family<List<FramePosesViewData>, int>((ref, scenePartId) {
        final db = ref.watch(selectedSceneGroupProvider);

        return (db.framePosesView.select()..where(
              (framePose) => framePose.frameScenePartId.equals(scenePartId),
            ))
            .watch();
      });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      provider: poseProvider(scenePartId),
      builder: (framePoses) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: DesignValues.large,
        children: [
          for (final pose in framePoses)
            Padding(
              padding: EdgeInsets.only(top: DesignValues.large),
              child: Image.memory(pose.imageData),
            ),
        ],
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
  final String errorMessage;

  const NovelError(this.errorMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessage, style: TextStyle(color: Colors.red)),
    );
  }
}

class NovelQueryBuilder<QueryResult> extends StatelessWidget {
  final ProviderListenable<AsyncValue<QueryResult>> provider;
  final Widget Function(QueryResult) builder;

  const NovelQueryBuilder({
    super.key,
    required this.provider,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final result = ref.watch(provider);

        return result.when(
          data: builder,
          loading: () => NovelLoading(),
          error: (error, stack) => NovelError(error.toString()),
        );
      },
    );
  }
}
