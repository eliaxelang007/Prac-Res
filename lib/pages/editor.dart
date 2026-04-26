import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/frame.dart';

class NovelEditorPage extends StatelessWidget {
  final SceneGroup sceneGroup;

  const NovelEditorPage({required this.sceneGroup, super.key});

  @override
  Widget build(BuildContext context) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(designValues.small),
        child: HookBuilder(
          builder: (context) {
            final selectedScene = useState<SceneId?>(null);
            final selectedScenePart = useState<ScenePartId?>(null);

            final selectedScenePartValue = selectedScene.value;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: NovelResourceSelector(
                    sceneGroup: sceneGroup,
                    selectedScene: selectedScene,
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 9,
                  child: NovelFrameViewer(
                    sceneGroup: sceneGroup,
                    selectedScene: selectedScenePartValue,
                    selectedScenePart: selectedScenePart,
                  ),
                ),
                VerticalDivider(),
                Expanded(flex: 3, child: NovelInspector()),
              ],
            );
          },
        ),
      ),
    );
  }
}

class NovelResourceSelector extends StatelessWidget {
  final SceneGroup sceneGroup;
  final ValueNotifier<SceneId?> selectedScene;

  const NovelResourceSelector({
    required this.sceneGroup,
    required this.selectedScene,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final designValues = theme.extension<DesignValues>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(designValues.small),
            child: RadioGroup<SceneId>(
              onChanged: (selection) {
                selectedScene.value = selection;
              },
              groupValue: selectedScene.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Scenes", style: textTheme.bodyLarge),
                  for (final MapEntry(key: id, value: scene)
                      in sceneGroup.scenes.entries)
                    RadioListTile(
                      value: id,
                      title: Text(scene.metadata, style: textTheme.bodyMedium),
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
        const Divider(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(designValues.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Poses", style: textTheme.bodyLarge),
                Text("Backgrounds", style: textTheme.bodyLarge),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NovelFrameViewer extends StatelessWidget {
  final SceneGroup sceneGroup;
  final SceneId? selectedScene;
  final ValueNotifier<ScenePartId?> selectedScenePart;

  const NovelFrameViewer({
    required this.sceneGroup,
    required this.selectedScene,
    required this.selectedScenePart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    final scene = sceneGroup.scenes.find(selectedScene);

    final sceneParts = scene?.value.entries.toList()
      ?..sort((a, b) => a.value.order.compareTo(b.value.order));

    final scenePart = scene?.find(selectedScenePart.value)?.part;

    return HookBuilder(
      builder: (context) {
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
                          screen: NovelFrame(
                            sceneGroup: sceneGroup,
                            frame: scenePart,
                          ),
                        )
                      : Placeholder(),
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(designValues.small),
                child: ScenePartSelectorGroup(
                  groupValue: selectedScenePart.value,
                  onChanged: (scenePartId) {
                    selectedScenePart.value = scenePartId;
                  },
                  child: Row(
                    spacing: designValues.medium,
                    children: [
                      if (sceneParts != null) ...[
                        for (final orderedPart in sceneParts)
                          ScenePartPreview(
                            sceneGroup: sceneGroup,
                            orderedPart: orderedPart,
                          ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_rounded),
                        ),
                      ],
                    ],
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

class NovelInspector extends StatelessWidget {
  const NovelInspector({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(child: ColoredBox(color: Colors.blue));
  }
}

class ScenePartPreview extends StatelessWidget {
  final SceneGroup sceneGroup;
  final MapEntry<ScenePartId, OrderedScenePart> orderedPart;

  const ScenePartPreview({
    super.key,
    required this.sceneGroup,
    required this.orderedPart,
  });

  @override
  Widget build(BuildContext context) {
    final scope = ScenePartSelectorScope.maybeOf(context)!;
    final designValues = Theme.of(context).extension<DesignValues>()!;

    final scenePartId = orderedPart.key;
    final isSelected = scope.groupValue == scenePartId;

    final scenePart = orderedPart.value.part;

    final preview = Padding(
      padding: EdgeInsets.all(designValues.verySmall),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(designValues.small),
        child: Stack(
          children: [
            (scenePart is Frame)
                ? AspectRatio(
                    aspectRatio: 16 / 9,
                    child: NovelFrame(sceneGroup: sceneGroup, frame: scenePart),
                  )
                : const Icon(Icons.alt_route_rounded),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (!isSelected) {
                      scope.onChanged(scenePartId);
                    }
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

class ScenePartSelectorScope extends InheritedWidget {
  final ScenePartId? groupValue;
  final ValueChanged<ScenePartId?> onChanged;

  const ScenePartSelectorScope({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required super.child,
  });

  static ScenePartSelectorScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScenePartSelectorScope>();
  }

  @override
  bool updateShouldNotify(ScenePartSelectorScope oldWidget) {
    return groupValue != oldWidget.groupValue;
  }
}

class ScenePartSelectorGroup extends StatelessWidget {
  final ScenePartId? groupValue;
  final ValueChanged<ScenePartId?> onChanged;
  final Widget child;

  const ScenePartSelectorGroup({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScenePartSelectorScope(
      groupValue: groupValue,
      onChanged: onChanged,
      child: child,
    );
  }
}
