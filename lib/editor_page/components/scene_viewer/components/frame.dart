import 'package:flutter/material.dart' hide Table;

import 'package:drift/drift.dart' hide Column;
import 'package:handy/handy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:prac_res/data/data.dart';
import 'package:prac_res/components/database/query_builder.dart';
import 'package:prac_res/components/icon_buttons/fitted_icon.dart';
import 'package:prac_res/components/lists/animated_list.dart';
import 'package:prac_res/components/design_values.dart';
import 'package:prac_res/editor_page/editor_page.dart';

/* frame.dart */

class NovelFrame extends StatelessWidget {
  const NovelFrame({super.key, required this.frame});

  final Frame frame;

  @override
  Widget build(BuildContext context) {
    final commonPhoneResolution = const Size(800, 360); // 20:9 Aspect Ratio

    final backgroundId = frame.backgroundId;
    final scenePartId = frame.scenePartId;

    return Stack(
      children: [
        Positioned.fill(child: ColoredBox(color: Colors.white)),

        Positioned.fill(child: AnimatedBackground(backgroundId: backgroundId)),

        Positioned.fill(
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: SizedBox(
              width: commonPhoneResolution.width,
              height: commonPhoneResolution.height,
              child: NovelFrameSafeArea(
                poses: NovelPoses(scenePartId: scenePartId),
                dialogue: NovelDialogueArea(scenePartId: scenePartId),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NovelFrameSafeArea extends StatelessWidget {
  final Widget poses;
  final Widget dialogue;

  const NovelFrameSafeArea({
    super.key,
    required this.poses,
    required this.dialogue,
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

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key, required this.backgroundId});

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
    this.switchPoseDuration = const Duration(milliseconds: 300),
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
                      width: constraints.maxWidth / 3,
                      height: constraints.maxHeight,
                      child: NovelPose(poseId: framePose.poseId),
                    ),
                  ),
              ].inBetween((_) => SizedBox(width: DesignValues.large)).toList(),
            );
          },
        ),
      ),
    );
  }
}

/* dialogue.dart */

class NovelDialogueArea extends StatelessWidget {
  final int scenePartId;

  const NovelDialogueArea({super.key, required this.scenePartId});

  static final dialogueBoxesTableProvider = Provider<$DialogueBoxesTable>((
    ref,
  ) {
    final sceneGroup = ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider);
    return sceneGroup.dialogueBoxes;
  });

  static final dialogueProvider = StreamProvider.family<DialogueBox?, int>((
    ref,
    frameScenePartId,
  ) {
    return (ref.watch(dialogueBoxesTableProvider).select()..where(
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
        if (dialogueBox != null) {
          final name = dialogueBox.name;
          final dialogue = dialogueBox.dialogue;

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
                    isRepeatingAnimation: false,
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
