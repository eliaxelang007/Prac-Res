// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/editor_state.dart';

class NovelFrame extends ConsumerWidget {
  const NovelFrame({super.key, required this.frame});

  final Frame frame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    final commonPhoneResolution = const Size(800, 360);

    final sceneGroup = ref.watch(selectedSceneGroupProvider);

    if (sceneGroup == null)
      return const Placeholder(child: Text("sceneGroup == null"));

    final background = (() async {
      final backgroundId = frame.backgroundId;

      if (backgroundId == null) return null;

      return await (sceneGroup.backgroundImages.select()..where(
            (background) => background.backgroundId.equals(backgroundId),
          ))
          .getSingleOrNull();
    })();

    final poses = (() async {
      final framePoses = sceneGroup.framePoses;
      final poseImages = sceneGroup.poseImages;

      final query =
          framePoses.select().join([
              drift.innerJoin(
                poseImages,
                poseImages.poseId.equalsExp(framePoses.poseId),
              ),
            ])
            ..where(framePoses.frameId.equals(frame.scenePartId))
            ..orderBy([drift.OrderingTerm.asc(framePoses.order)]);

      final results = await query.get();

      return results.map((row) => row.readTable(poseImages)).toList();
    })();

    final dialogBox =
        (sceneGroup.dialogueBoxes.select()..where(
              (dialogueBox) => dialogueBox.frameId.equals(frame.scenePartId),
            ))
            .getSingleOrNull();

    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(color: Colors.white, child: SizedBox.expand()),
        ),

        Positioned.fill(
          child: FutureBuilder(
            future: background,
            builder: (context, asyncSnapshot) {
              if (!asyncSnapshot.hasData) {
                return Placeholder(child: Text("background !hasData"));
              }

              final backgroundImage = asyncSnapshot.data;

              if (backgroundImage == null) {
                return Placeholder(child: Text("backgroundImage == null"));
              }

              return Image.memory(backgroundImage.imageData, fit: BoxFit.cover);
            },
          ),
        ),

        Positioned.fill(
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: SizedBox(
              width: commonPhoneResolution.width,
              height: commonPhoneResolution.height,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: FutureBuilder(
                        future: poses,
                        builder: (context, asyncSnapshot) {
                          if (!asyncSnapshot.hasData) {
                            return Placeholder(child: Text("poses !hasData"));
                          }

                          final poseImages = asyncSnapshot.data;

                          if (poseImages == null) {
                            return Placeholder(
                              child: Text("poseImages == null"),
                            );
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: designValues.large,
                            children: [
                              for (final poseImage in poseImages)
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: designValues.large,
                                  ),
                                  child: Image.memory(poseImage.imageData),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: designValues.large * 5,
                          right: designValues.large * 5,
                          bottom: designValues.medium,
                        ),
                        child: FutureBuilder(
                          future: dialogBox,
                          builder: (context, asyncSnapshot) {
                            if (!asyncSnapshot.hasData) {
                              return Placeholder(
                                child: Text("dialogBox !hasData"),
                              );
                            }

                            final dialog = asyncSnapshot.data;

                            if (dialog == null) {
                              return Placeholder(child: Text("dialog == null"));
                            }

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: designValues.large * 1.2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: designValues.large,
                                      right: designValues.large * 10,
                                    ),
                                    child: Builder(
                                      builder: (context) {
                                        final name = dialog.name;

                                        if (name == null)
                                          return Placeholder(
                                            child: Text("name == null"),
                                          );

                                        return NovelNameBox(name: name);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: designValues.large * 3,
                                  child: NovelDialogueBox(
                                    dialogue: dialog.dialogue,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NovelNameBox extends StatelessWidget {
  const NovelNameBox({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(designValues.small),
        topRight: Radius.circular(designValues.small),
      ),
      child: ColoredBox(
        color: Colors.blueGrey,
        child: Padding(
          padding: EdgeInsets.all(designValues.small),
          child: Text(name),
        ),
      ),
    );
  }
}

class NovelDialogueBox extends StatelessWidget {
  final String dialogue;

  const NovelDialogueBox({required this.dialogue, super.key});

  @override
  Widget build(BuildContext context) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(designValues.small),
      child: ColoredBox(
        color: Colors.blueGrey,
        child: Padding(
          padding: EdgeInsets.all(designValues.semiSmall),
          child: Text(dialogue),
        ),
      ),
    );
  }
}
