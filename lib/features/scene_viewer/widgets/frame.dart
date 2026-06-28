import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Table;

import 'package:drift/drift.dart' hide Column;
import 'package:handy/handy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/theme/design_values.dart';
import 'package:prac_res/core/widgets/animated_list.dart';
import 'package:prac_res/core/widgets/database/query_builder.dart';
import 'package:prac_res/core/widgets/fitted_icon.dart';
import 'package:prac_res/features/editor/screens/editor_page.dart';

/* frame.dart */

class NovelFrame extends StatelessWidget {
  const NovelFrame({super.key, required this.frame});

  final Frame frame;

  @override
  Widget build(BuildContext context) {
    final backgroundId = frame.backgroundId;
    final scenePartId = frame.scenePartId;

    return Stack(
      children: [
        Positioned.fill(
          child: NovelAnimatedBackground(backgroundId: backgroundId),
        ),

        Positioned.fill(
          child: NovelFrameFit(
            child: NovelFrameSafeArea(
              poses: NovelPoses(scenePartId: scenePartId),
              dialogue: NovelDialogueArea(scenePartId: scenePartId),
              choice: NovelChoice(scenePartId: scenePartId),
            ),
          ),
        ),
      ],
    );
  }
}

class NovelFrameFit extends StatelessWidget {
  const NovelFrameFit({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final commonPhoneResolution = const Size(800, 360); // 20:9 Aspect Ratio

    return FittedBox(
      fit: BoxFit.fitHeight,
      child: SizedBox(
        width: commonPhoneResolution.width,
        height: commonPhoneResolution.height,
        child: child,
      ),
    );
  }
}

class NovelFrameSafeArea extends StatelessWidget {
  final Widget poses;
  final Widget dialogue;
  final Widget choice;

  const NovelFrameSafeArea({
    super.key,
    required this.poses,
    required this.dialogue,
    required this.choice,
  });

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
              child: poses,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                left: DesignValues.large * 5,
                right: DesignValues.large * 5,
                bottom: DesignValues.medium,
              ),
              child: dialogue,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                left: DesignValues.large * 9.7,
                right: DesignValues.large * 9.7,
              ),
              child: Center(child: choice),
            ),
          ),
        ],
      ),
    );
  }
}

/* backgrounds.dart */

class NovelBackground extends StatelessWidget {
  final int? backgroundId;

  const NovelBackground({super.key, required this.backgroundId});

  static final backgroundImageTableProvider = Provider<$BackgroundImagesTable>((
    ref,
  ) {
    final sceneGroup = ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider);
    return sceneGroup.backgroundImages;
  });

  @override
  Widget build(BuildContext context) {
    return NovelImage(
      imageTable: backgroundImageTableProvider,
      maybeImageId: backgroundId,
    );
  }
}

class NovelAnimatedBackground extends StatelessWidget {
  const NovelAnimatedBackground({super.key, required this.backgroundId});

  final int? backgroundId;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: SizedBox.expand(
        key: ValueKey(backgroundId),
        child: NovelBackground(backgroundId: backgroundId),
      ),
    );
  }
}

/* poses.dart */

class NovelPose extends StatelessWidget {
  final int? poseId;

  const NovelPose({super.key, required this.poseId});

  static final poseImageTableProvider = Provider<$PoseImagesTable>((ref) {
    final sceneGroup = ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider);
    return sceneGroup.poseImages;
  });

  @override
  Widget build(BuildContext context) {
    return NovelImage(imageTable: poseImageTableProvider, maybeImageId: poseId);
  }
}

class NovelPoses extends StatelessWidget {
  final Duration popInDuration;
  final Duration popOutDuration;
  final Duration switchPoseDuration;
  final int scenePartId;

  const NovelPoses({
    super.key,
    required this.scenePartId,
    this.popInDuration = const Duration(milliseconds: 400),
    this.popOutDuration = const Duration(milliseconds: 500),
    this.switchPoseDuration = const Duration(milliseconds: 500),
  });

  static final framePoseProvider =
      StreamProvider.family<List<FramePosesViewData>, int>((ref, scenePartId) {
        final sceneGroup = ref.watch(
          NovelSceneGroupEditorPage.sceneGroupProvider,
        );

        return (sceneGroup.framePosesView.select()
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
    final betweenSize = DesignValues.semiLarge;
    final slots = 3;

    return NovelQueryBuilder(
      query: (ref) => ref.watch(framePoseProvider(scenePartId)),
      builder: (context, ref, framePoses) => Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ImplicitlyAnimatedList(
              insertDuration: popInDuration,
              removeDuration: popOutDuration,
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
                for (final framePose in framePoses)
                  AnimatedSwitcher(
                    key: ValueKey(framePose.groupId),
                    duration: switchPoseDuration,
                    child: SizedBox(
                      key: ValueKey(framePose.poseId),
                      width:
                          (constraints.maxWidth - betweenSize * (slots - 1)) /
                          slots,
                      height: constraints.maxHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          NovelPose(poseId: framePose.poseId),
                          Flexible(child: SizedBox(height: 110)),
                        ],
                      ),
                    ),
                  ),
              ].inBetween((_) => SizedBox(width: betweenSize)).toList(),
            );
          },
        ),
      ),
    );
  }
}

/* dialogue.dart */

extension Templater on IMap<String, String> {
  String fillIn(String toFill) {
    final regex = RegExp(r'(?<!\\)\{([^}]+)\}');

    final parsed = toFill.replaceAllMapped(regex, (match) {
      final key = match.group(1);

      if (key != null && containsKey(key)) {
        return get(key).toString();
      }

      return match.group(0)!;
    });

    return parsed.replaceAll(r'\{', '{').replaceAll(r'\}', '}');
  }
}

class TemplaterNotifier extends Notifier<IMap<String, String>> {
  @override
  IMap<String, String> build() {
    return IMap();
  }

  void add(String key, String value) {
    state = state.add(key, value);
  }

  void remove(String key) {
    state = state.remove(key);
  }
}

final templaterProvider =
    NotifierProvider<TemplaterNotifier, IMap<String, String>>(
      TemplaterNotifier.new,
    );

class NovelDialogueArea extends StatelessWidget {
  final int scenePartId;

  const NovelDialogueArea({super.key, required this.scenePartId});

  static final dialogueProvider = StreamProvider.family<DialogueBox?, int>((
    ref,
    frameScenePartId,
  ) {
    return (ref
            .watch(NovelSceneGroupEditorPage.sceneGroupProvider)
            .dialogueBoxes
            .select()
          ..where(
            (dialogueBoxEntry) =>
                dialogueBoxEntry.frameScenePartId.equals(frameScenePartId),
          ))
        .watchSingleOrNull();
  });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) => ref.watch(dialogueProvider(scenePartId)),
      builder: (context, ref, dialogueBox) {
        if (dialogueBox == null) {
          return SizedBox.shrink();
        }

        final templater = ref.watch(templaterProvider);

        final name = dialogueBox.name;
        final dialogue = dialogueBox.dialogue;

        return Stack(
          children: [
            Positioned(
              bottom: DesignValues.large * 2.45,
              left: DesignValues.large,
              child: (name != null)
                  ? SizedBox(
                      width: DesignValues.large * 3.5,
                      height: DesignValues.large * 1.7,
                      child: NovelNameBox(name: Text(templater.fillIn(name))),
                    )
                  : SizedBox.shrink(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: DesignValues.large * 3.2,
                child: NovelDialogueBox(
                  dialogue: AnimatedTextKit(
                    key: ValueKey(dialogue),
                    animatedTexts: [
                      TypewriterAnimatedText(
                        templater.fillIn(dialogue),
                        speed: const Duration(milliseconds: 25),
                        cursor: "",
                      ),
                    ],
                    isRepeatingAnimation: false,
                    totalRepeatCount: 1,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class NovelDialogueBox extends StatelessWidget {
  final Widget dialogue;

  const NovelDialogueBox({required this.dialogue, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.surface.withAlpha((255 * 0.93).toInt()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(
          Radius.circular(DesignValues.small),
        ),
        side: BorderSide(
          color: colorScheme.primary,
          width: DesignValues.verySmall,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: DesignValues.small,
          horizontal: DesignValues.small * 1.4,
        ),
        child: SizedBox.expand(child: dialogue),
      ),
    );
  }
}

class NovelNameBox extends StatelessWidget {
  const NovelNameBox({required this.name, super.key});

  final Widget name;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.surface.withAlpha((255 * 0.93).toInt()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DesignValues.small),
          topRight: Radius.circular(DesignValues.small),
        ),
        side: BorderSide(
          color: colorScheme.primary,
          width: DesignValues.verySmall,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: DesignValues.small,
          horizontal: DesignValues.small * 1.4,
        ),
        child: SizedBox.expand(child: name),
      ),
    );
  }
}

/* choices.dart */

class NovelChoice extends StatelessWidget {
  final int scenePartId;

  const NovelChoice({super.key, required this.scenePartId});

  static final frameChoiceProvider =
      StreamProvider.family<FrameChoicesViewData?, int>((
        ref,
        frameScenePartId,
      ) {
        return (ref
                .watch(NovelSceneGroupEditorPage.sceneGroupProvider)
                .frameChoicesView
                .select()
              ..where(
                (frameChoiceEntry) =>
                    frameChoiceEntry.frameScenePartId.equals(frameScenePartId),
              ))
            .watchSingleOrNull();
      });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) => ref.watch(frameChoiceProvider(scenePartId)),
      builder: (context, ref, frameChoice) {
        final choiceId = frameChoice?.choiceId;

        if (choiceId == null) return SizedBox.shrink();

        return NovelChoiceOptions(choiceId: choiceId);
      },
    );
  }
}

class NovelChoiceOptions extends StatelessWidget {
  final int choiceId;

  const NovelChoiceOptions({super.key, required this.choiceId});

  static final choiceOptionsProvider =
      StreamProvider.family<List<ChoiceOption>, int>((ref, int choiceId) {
        return (ref
                .watch(NovelSceneGroupEditorPage.sceneGroupProvider)
                .choiceOptions
                .select()
              ..orderBy([(u) => OrderingTerm(expression: u.id)])
              ..where(
                (choiceOptionEntry) =>
                    choiceOptionEntry.choiceId.equals(choiceId),
              ))
            .watch();
      });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) => ref.watch(choiceOptionsProvider(choiceId)),
      builder: (context, ref, choiceOptions) {
        return Card(
          color: Theme.of(
            context,
          ).colorScheme.surface.withAlpha((255 * 0.9).toInt()),
          child: RadioGroup<int?>(
            groupValue: choiceOptions
                .where((choiceOption) => choiceOption.isSelected)
                .firstOrNull
                ?.id,
            onChanged: (selectedChoiceOption) async {
              final sceneGroup = ref.read(
                NovelSceneGroupEditorPage.sceneGroupProvider,
              );

              await sceneGroup.transaction(() async {
                await (sceneGroup.choiceOptions.update()..where(
                      (choiceOptionEntry) =>
                          choiceOptionEntry.choiceId.equals(choiceId),
                    ))
                    .write(ChoiceOptionsCompanion(isSelected: Value(false)));

                if (selectedChoiceOption == null) return;

                await (sceneGroup.choiceOptions.update()..where(
                      (choiceOptionEntry) =>
                          choiceOptionEntry.id.equals(selectedChoiceOption),
                    ))
                    .write(ChoiceOptionsCompanion(isSelected: Value(true)));
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final choiceOption in choiceOptions)
                  RadioListTile<int?>(
                    toggleable: true,
                    value: choiceOption.id,
                    title: Text(choiceOption.name),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/* image.dart */

class NovelImage extends StatelessWidget {
  final ProviderListenable<TableInfo<ImageDataTable, ImageData>> imageTable;
  final int? maybeImageId;
  final BoxFit? fit;

  static final imageProvider =
      StreamProvider.family<
        ImageData,
        (EquatableTableInfo<ImageDataTable, ImageData>, int)
      >((ref, ids) {
        final (imageDataTableWrapper, imageId) = ids;

        return (imageDataTableWrapper.wrapped.select()
              ..where((poseImage) => poseImage.metadataId.equals(imageId)))
            .watchSingle();
      });

  const NovelImage({
    super.key,
    required this.imageTable,
    required this.maybeImageId,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    final imageId = maybeImageId;

    return (imageId != null)
        ? NovelQueryBuilder(
            query: (ref) => ref.watch(
              imageProvider((
                EquatableTableInfo(ref.watch(imageTable)),
                imageId,
              )),
            ),
            builder: (context, ref, data) => Image.memory(
              key: ValueKey(data.metadataId),
              data.imageData,
              fit: fit,
            ),
          )
        : NovelFittedIcon(
            icon: Icon(Icons.image_not_supported_rounded),
            sizePercentage: 0.5,
          );
  }
}
