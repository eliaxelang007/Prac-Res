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

    final (actors, places) = ref.watch(
      selectedSceneGroupProvider.select((group) {
        if (group == null) return (null, null);

        return (group.actors, group.places);
      }),
    );

    final background = frame.background;

    return Stack(
      children: [
        if (background != null)
          Positioned.fill(
            child: Image.memory(
              background.findIn(places!)!.resource.resource.value.image,
              fit: BoxFit.cover,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: designValues.large,
                        children: [
                          for (final pose in frame.poses)
                            Padding(
                              padding: EdgeInsets.only(top: designValues.large),
                              child: Image.memory(
                                pose.findIn(actors!)!.value.image,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: designValues.large * 5,
                          right: designValues.large * 5,
                          bottom: designValues.medium,
                        ),
                        child: Column(
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
                                child: NovelNameBox(
                                  name: frame.dialogueBox?.name ?? "",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: designValues.large * 3,
                              child: NovelDialogueBox(
                                dialogue: frame.dialogueBox?.dialogue ?? "",
                              ),
                            ),
                          ],
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
