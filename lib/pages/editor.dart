import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/editor_state.dart';
import 'package:prac_res/pages/frame.dart';
import 'package:prac_res/pages/inspector.dart';

class NovelEditorPage extends ConsumerWidget {
  const NovelEditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: designValues.small),
            child: const Divider(height: 1.0),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(designValues.small),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 3, child: NovelResourceSelector()),
            VerticalDivider(),
            Expanded(flex: 9, child: NovelFrameViewer()),
            VerticalDivider(),
            Expanded(flex: 3, child: NovelInspector()),
          ],
        ),
      ),
    );
  }
}

class NovelResourceSelector extends ConsumerWidget {
  const NovelResourceSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final designValues = theme.extension<DesignValues>()!;

    final scenes = ref.watch(
      selectedSceneGroupProvider.select((group) => group?.scenes),
    );
    final selectedScene = ref.watch(selectedSceneProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(designValues.small),
            child: RadioGroup<Id<Scene>>(
              onChanged: (selection) {
                ref.read(selectedSceneProvider.notifier).select(selection);
              },
              groupValue: selectedScene,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Scenes", style: textTheme.bodyLarge),
                  const Divider(),
                  if (scenes != null)
                    for (final MapEntry(key: id, value: scene)
                        in scenes.entries)
                      RadioListTile(
                        value: id,
                        title: Text(
                          scene.metadata,
                          style: textTheme.bodyMedium,
                        ),
                        toggleable: true,
                      ),
                  IconButton(
                    onPressed: () {},
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
}

class NovelFrameViewer extends ConsumerWidget {
  const NovelFrameViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    final selectedScene = ref.watch(selectedSceneProvider);

    final scene = ref.watch(
      selectedSceneGroupProvider.select((group) {
        return group?.scenes.find(selectedScene);
      }),
    );

    final selectedScenePart = ref.watch(selectedScenePartProvider);

    final scenePart = scene?.find(selectedScenePart?.childId)?.part;
    final sceneParts = scene?.value.entries;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(designValues.veryLarge),
              child: (scenePart != null && scenePart is Frame)
                  ? DeviceFrame(
                      device: Devices.android.bigPhone,
                      orientation: Orientation.landscape,
                      screen: NovelFrame(frame: scenePart),
                    )
                  : const SizedBox(),
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(designValues.small),
            child: Row(
              spacing: designValues.medium,
              children: [
                if (sceneParts != null) ...[
                  for (final orderedPart in sceneParts)
                    NovelScenePartPreview(orderedPart: orderedPart),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NovelScenePartPreview extends ConsumerWidget {
  final MapEntry<Id<OrderedScenePart>, OrderedScenePart> orderedPart;

  const NovelScenePartPreview({super.key, required this.orderedPart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designValues = Theme.of(context).extension<DesignValues>()!;
    final sceneGroup = ref.watch(selectedSceneGroupProvider);
    final selectedPartId = ref.watch(selectedScenePartProvider);

    final scenePartId = orderedPart.key;
    final isSelected = selectedPartId == scenePartId;
    final scenePart = orderedPart.value.part;

    final preview = Padding(
      padding: EdgeInsets.all(designValues.verySmall),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(designValues.small),
        child: Stack(
          children: [
            (sceneGroup != null && scenePart is Frame)
                ? AspectRatio(
                    aspectRatio: 16 / 9,
                    child: NovelFrame(frame: scenePart),
                  )
                : const Icon(Icons.alt_route_rounded),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Toggle selection directly through the provider
                    ref
                        .read(selectedScenePartProvider.notifier)
                        .select(isSelected ? null : scenePartId);
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
