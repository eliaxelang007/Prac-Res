import 'package:device_frame/device_frame.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/editor_state.dart';
import 'package:prac_res/pages/frame.dart';
import 'package:prac_res/pages/inspector/inspector.dart';
import 'package:prac_res/pages/open.dart';

class NovelEditorPage extends StatelessWidget {
  const NovelEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    return Scaffold(
      appBar: NovelMenuBar(designValues: designValues),
      body: Padding(
        padding: EdgeInsets.all(designValues.small),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 3, child: NovelSceneSelector()),
            VerticalDivider(),
            Expanded(flex: 9, child: NovelScenePartTimeline()),
            VerticalDivider(),
            Expanded(flex: 3, child: SizedBox() /*NovelInspector() */),
          ],
        ),
      ),
    );
  }
}

class NovelMenuBar extends StatelessWidget implements PreferredSizeWidget {
  const NovelMenuBar({super.key, required this.designValues});

  final DesignValues designValues;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 45,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: designValues.small),
          child: const Divider(height: 1.0),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class NovelSceneSelector extends ConsumerWidget {
  const NovelSceneSelector({super.key});

  static final scenesProvider = StreamProvider((ref) {
    final sceneGroup = ref.watch(selectedSceneGroupProvider);

    if (sceneGroup == null) {
      return Stream.value(null);
    }

    return sceneGroup.scenes.select().watch();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final designValues = theme.extension<DesignValues>()!;

    final selectedScene = ref.watch(selectedSceneProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(designValues.small),
            child: RadioGroup<int>(
              onChanged: (selection) {
                ref.read(selectedSceneProvider.notifier).set(selection);
              },
              groupValue: selectedScene,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Scenes", style: textTheme.bodyLarge),
                  const Divider(),

                  ...thing(context, ref),

                  IconButton(
                    onPressed: () async {
                      final sceneName = await NovelNewNameDialog.show(
                        context,
                        title: "New Scene",
                      );

                      if (sceneName == null) {
                        return;
                      }

                      final sceneGroup = ref.read(selectedSceneGroupProvider)!;

                      // SAFETY: [scenes] isn't null, which means [sceneGroup] isn't null.
                      sceneGroup
                          .into(sceneGroup.scenes)
                          .insert(ScenesCompanion.insert(name: sceneName));
                    },
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> thing(BuildContext context, WidgetRef ref) {
    final scenesWatcher = ref.watch(scenesProvider);

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return scenesWatcher.when(
      data: (scenes) {
        if (scenes == null) {
          return [const Placeholder(child: Text("scenes == null"))];
        }

        return scenes.map((scene) {
          final id = scene.id;

          return RadioListTile(
            value: id,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(scene.name, style: textTheme.bodyMedium),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    final answer = await showDialog<bool?>(
                      context: context,
                      builder: (context) {
                        return NovelDeletionDialog();
                      },
                    );

                    if (answer != true) return;

                    // SAFETY: [scenes] isn't null, which means [sceneGroup] isn't null.
                    final sceneGroup = ref.read(selectedSceneGroupProvider)!;

                    sceneGroup
                        .delete(sceneGroup.scenes)
                        .where((scene) => scene.id.equals(id));
                  },
                ),
              ],
            ),
            toggleable: true,
          );
        }).toList();
      },
      loading: () => [],
      error: (_, _) => [],
    );
  }
}

class NovelScenePartTimeline extends ConsumerWidget {
  const NovelScenePartTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    // final selectedScene = ref.watch(selectedSceneProvider);

    // final scene = ref.watch(
    //   selectedSceneGroupProvider.select((sceneGroup) {
    //     return sceneGroup
    //         ?.select(sceneGroup.scenes)
    //         .where((scene) => scene.id.equals(selectedScene));
    //   }),
    // );

    // final selectedScenePart = ref.watch(selectedScenePartProvider);

    // final scenePart =
    // final sceneParts = scene?.value.entries.toList();

    // sceneParts?.sort((a, b) => a.value.order.compareTo(b.value.order));

    final sceneGroup = ref.watch(selectedSceneGroupProvider);

    if (sceneGroup == null) {
      return const Placeholder(child: Text("sceneGroup == null"));
    }

    final selectedScenePart = ref.watch(selectedScenePartProvider);

    if (selectedScenePart == null) {
      return const Placeholder(child: Text("sceneGroup == null"));
    }

    final scenePart =
        (sceneGroup.sceneTimelineView.select()
              ..where((scenePart) => scenePart.id.equals(selectedScenePart)))
            .getSingleOrNull();

    final selectedScene = ref.watch(selectedSceneProvider);

    if (selectedScene == null) {
      return const Placeholder(child: Text("selectedScene == null"));
    }

    final sceneParts =
        (sceneGroup.sceneTimelineView.select()
              ..where((scenePart) => scenePart.sceneId.equals(selectedScene))
              ..orderBy([
                (u) =>
                    drift.OrderingTerm.asc(sceneGroup.sceneTimelineView.order),
              ]))
            .get();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(designValues.veryLarge),
              child: FutureBuilder(
                future: scenePart,
                builder: (context, asyncSnapshot) {
                  if (!asyncSnapshot.hasData) {
                    return Placeholder(child: Text("scenePart !hasData"));
                  }

                  final maybeFrame = asyncSnapshot.data;

                  if (maybeFrame == null) {
                    return Placeholder(child: Text("maybeFrame == null"));
                  }

                  final timelineItem =
                      SceneTimelineItem.fromSceneTimelineViewData(
                        maybeFrame,
                      ).specifics;

                  if (timelineItem is! TimelineFrame) {
                    return Placeholder(
                      child: Text("timelineItem is! TimelineFrame"),
                    );
                  }

                  return NovelFrame(frame: timelineItem.frameData);
                },
              ),
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(designValues.small),
            child: FutureBuilder(
              future: sceneParts,
              builder: (context, asyncSnapshot) {
                if (!asyncSnapshot.hasData) {
                  return Placeholder(child: Text("sceneParts !hasData"));
                }

                final maybeParts = asyncSnapshot.data
                    ?.map(
                      (part) =>
                          SceneTimelineItem.fromSceneTimelineViewData(part),
                    )
                    .toList();

                if (maybeParts == null) {
                  return Placeholder(child: Text("maybeParts == null"));
                }

                return Row(
                  spacing: designValues.medium,
                  children: [
                    ...[
                      for (final orderedPart in maybeParts)
                        NovelScenePartPreview(orderedPart: orderedPart),
                      IconButton(
                        onPressed: () async {
                          sceneGroup
                              .into(sceneGroup.sceneParts)
                              .insert(
                                ScenePartsCompanion.insert(
                                  sceneId: selectedScene,
                                  order: maybeParts.lastOrNull?.part.order ?? 0,
                                  partType: "frame",
                                ),
                              );
                        },
                        icon: const Icon(Icons.add_rounded),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class NovelScenePartPreview extends ConsumerWidget {
  final SceneTimelineItem orderedPart;

  const NovelScenePartPreview({super.key, required this.orderedPart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    // final sceneGroup = ref.watch(selectedSceneGroupProvider);
    final selectedPartId = ref.watch(selectedScenePartProvider);
    final selectedScene = ref.watch(selectedSceneProvider);

    final scenePartId = orderedPart.part.id;
    final isSelected = selectedPartId == scenePartId;
    final scenePart = orderedPart.specifics;

    final preview = Padding(
      padding: EdgeInsets.all(designValues.verySmall),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(designValues.small),
        child: Stack(
          children: [
            (scenePart is TimelineFrame)
                ? AspectRatio(
                    aspectRatio: 16 / 9,
                    child: NovelFrame(frame: scenePart.frameData),
                  )
                : const Icon(Icons.alt_route_rounded),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    ref
                        .read(selectedScenePartProvider.notifier)
                        .set(isSelected ? null : scenePartId);
                  },
                ),
              ),
            ),

            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    if (selectedScene == null) return;

                    final answer = await showDialog<bool?>(
                      context: context,
                      builder: (context) {
                        return NovelDeletionDialog();
                      },
                    );

                    if (answer != true) return;

                    final sceneGroup = ref.read(selectedSceneGroupProvider)!;

                    sceneGroup.sceneParts.delete().where(
                      (scenePart) => scenePart.id.equals(scenePartId),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return isSelected
        ? DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                designValues.small * (1 + designValues.semiSmallPercent),
              ),
              border: Border.all(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
            child: preview,
          )
        : preview;
  }
}

class NovelDeletionDialog extends StatelessWidget {
  const NovelDeletionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text("This will delete what you've selected."),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("I'm sure."),
        ),
      ],
    );
  }
}
