import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:junction/junction.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/editor_state.dart';

class NovelInspector extends ConsumerWidget {
  const NovelInspector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final designValues = theme.extension<DesignValues>()!;

    final sceneGroup = ref.watch(selectedSceneGroupProvider);
    final selectedSceneId = ref.watch(selectedSceneProvider);
    final selectedScenePartId = ref.watch(selectedScenePartProvider);

    final scenePartFullId =
        selectedSceneId != null && selectedScenePartId != null
        ? FullId<OrderedScenePart>(
            parentId: selectedSceneId,
            childId: selectedScenePartId,
          )
        : null;

    final scenePart = scenePartFullId != null
        ? sceneGroup?.scenePartPath(scenePartFullId).get(sceneGroup)?.part
        : null;

    return Padding(
      padding: EdgeInsets.all(designValues.small),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Edit Properties", style: textTheme.bodyLarge),
            const Divider(),
            if (scenePart is Frame && scenePartFullId != null) ...[
              Text("Background", style: textTheme.bodyMedium),
              SizedBox(height: designValues.small),
              NovelBackgroundInspector(
                currentBackgroundId: scenePart.background,
                onChanged: (newBackgroundId) {
                  ref
                      .read(selectedSceneGroupProvider.notifier)
                      .changeFrameBackground(scenePartFullId, newBackgroundId);
                },
              ),
              SizedBox(height: designValues.medium),
              Text("Dialogue", style: textTheme.bodyMedium),
              SizedBox(height: designValues.small),
              // +++ NEW DIALOGUE INSPECTOR +++
              NovelDialogueInspector(
                currentDialogue: scenePart.dialogueBox,
                onChanged: (newDialogueBox) {
                  ref
                      .read(selectedSceneGroupProvider.notifier)
                      .changeFrameDialogueBox(scenePartFullId, newDialogueBox);
                },
              ),
            ] else ...[
              Text("Select a Frame to inspect.", style: textTheme.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}

class NovelDialogueInspector extends HookWidget {
  final DialogueBox? currentDialogue;
  final ValueChanged<DialogueBox?> onChanged;

  const NovelDialogueInspector({
    super.key,
    required this.currentDialogue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    final hasDialogueBox = currentDialogue != null;
    final hasNameBox = currentDialogue?.name != null;

    // We use controllers here so Riverpod rebuilds don't jump the cursor while typing.
    final nameController = useTextEditingController(
      text: currentDialogue?.name ?? "",
    );
    final dialogueController = useTextEditingController(
      text: currentDialogue?.dialogue ?? "",
    );

    // Sync controllers if the user selects an entirely different frame
    useEffect(() {
      if (currentDialogue?.name != null &&
          nameController.text != currentDialogue?.name) {
        nameController.text = currentDialogue!.name!;
      }
      if (currentDialogue?.dialogue != null &&
          dialogueController.text != currentDialogue?.dialogue) {
        dialogueController.text = currentDialogue!.dialogue;
      }
      return null;
    }, [currentDialogue]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          title: const Text("Enable Dialogue Box"),
          contentPadding: EdgeInsets.zero,
          value: hasDialogueBox,
          onChanged: (enabled) {
            if (enabled) {
              // Initializes with no name box, and empty dialogue
              onChanged(const DialogueBox(name: null, dialogue: ""));
            } else {
              // Entire dialogue box is disabled (null)
              onChanged(null);
            }
          },
        ),
        if (hasDialogueBox) ...[
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(designValues.small),
            ),
            child: Padding(
              padding: EdgeInsets.all(designValues.small),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    title: const Text("Show Speaker Name"),
                    contentPadding: EdgeInsets.zero,
                    value: hasNameBox,
                    onChanged: (enabled) {
                      if (enabled) {
                        // Restore whatever was in the text controller, or default to ""
                        onChanged(
                          currentDialogue?.copyWith(name: nameController.text),
                        );
                      } else {
                        // Remove the name box entirely (null)
                        onChanged(currentDialogue?.copyWith(name: null));
                      }
                    },
                  ),
                  if (hasNameBox) ...[
                    Text(
                      "Speaker Name",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: designValues.verySmall),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: "Enter name...",
                      ),
                      onChanged: (value) {
                        onChanged(currentDialogue?.copyWith(name: value));
                      },
                    ),
                    SizedBox(height: designValues.small),
                  ],
                  Text(
                    "Dialogue Text",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: designValues.verySmall),
                  TextField(
                    controller: dialogueController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      hintText: "Enter dialogue...",
                    ),
                    onChanged: (value) {
                      onChanged(currentDialogue?.copyWith(dialogue: value));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class NovelBackgroundInspector extends HookConsumerWidget {
  final FullId<Background>? currentBackgroundId;
  final ValueChanged<FullId<Background>> onChanged;

  const NovelBackgroundInspector({
    super.key,
    required this.currentBackgroundId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    final currentBytes = ref.watch(
      selectedSceneGroupProvider.select((group) {
        final backgroundId = currentBackgroundId;

        if (group == null || backgroundId == null) return null;
        return group.backgroundPath(backgroundId).get(group)?.value.image;
      }),
    );

    return InkWell(
      borderRadius: BorderRadius.circular(designValues.small),
      onTap: () => showDialog(
        context: context,
        builder: (context) => Consumer(
          builder: (context, ref, child) {
            final placesCollection = ref.watch(
              selectedSceneGroupProvider.select((group) => group?.places),
            );

            if (placesCollection == null) return const SizedBox.shrink();

            return NovelImageGroupEditor<Background>(
              title: Text("Select Background"),
              addParentLabel: Text("Add Place"),
              emptySelectionLabel: Text("Select a Place"),
              imageCollection: placesCollection,
              currentSelectionId: currentBackgroundId,
              onSelectionChanged: onChanged,
              onImageCollectionEdited: (newCollection) => ref
                  .read(selectedSceneGroupProvider.notifier)
                  .updatePlaces(newCollection as Places),
            );
          },
        ),
      ),
      child: Container(
        height: 120,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(designValues.small),
        ),
        child: currentBytes != null
            ? Image.memory(currentBytes, fit: BoxFit.cover)
            : const Center(child: Text("No Image")),
      ),
    );
  }
}

class NovelImageGroupEditor<ImageItem extends ImageResource>
    extends HookWidget {
  final Widget title;
  final Widget addParentLabel;
  final Widget emptySelectionLabel;

  final Collection<ImageCollectionResource<ImageItem>> imageCollection;
  final ValueChanged<Collection<ImageCollectionResource<ImageItem>>>
  onImageCollectionEdited;

  final FullId<ImageItem>? currentSelectionId;
  final ValueChanged<FullId<ImageItem>> onSelectionChanged;

  const NovelImageGroupEditor({
    super.key,
    required this.title,
    required this.addParentLabel,
    required this.emptySelectionLabel,
    required this.imageCollection,
    required this.onImageCollectionEdited,
    required this.currentSelectionId,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    final selectedParentId = useState<Id<CollectionResource<ImageItem>>?>(
      currentSelectionId?.parentId,
    );

    return AlertDialog(
      title: title,
      content: SizedBox(
        width: 800,
        height: 500,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: NovelImageCollectionViewer(
                collection: imageCollection,
                selectedParentId: selectedParentId,
                addParentLabel: addParentLabel,
                designValues: designValues,
                onCollectionChanged: onImageCollectionEdited,
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              flex: 3,
              child: selectedParentId.value == null
                  ? Center(child: emptySelectionLabel)
                  : NovelImageResourceViewer(
                      collection: imageCollection,
                      parentId: selectedParentId.value!,
                      currentSelectionId: currentSelectionId,
                      designValues: designValues,
                      onSelectionChanged: (id) {
                        onSelectionChanged(id);
                        Navigator.of(context).pop();
                      },
                      onCollectionChanged: onImageCollectionEdited,
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}

class NovelImageCollectionViewer<ImageItem extends ImageResource>
    extends HookWidget {
  final Collection<ImageCollectionResource<ImageItem>> collection;

  final ValueNotifier<Id<CollectionResource<ImageItem>>?> selectedParentId;
  final Widget addParentLabel;
  final DesignValues designValues;
  final ValueChanged<Collection<ImageCollectionResource<ImageItem>>>
  onCollectionChanged;

  const NovelImageCollectionViewer({
    super.key,
    required this.collection,
    required this.selectedParentId,
    required this.addParentLabel,
    required this.designValues,
    required this.onCollectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final parentList = collection.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: parentList.length,
            itemBuilder: (context, index) {
              // FIX 4 continued: Cast the key to satisfy Dart's strict generic boundaries
              final parentId =
                  parentList[index].key as Id<CollectionResource<ImageItem>>;
              final parent = parentList[index].value;
              final isSelected = parentId == selectedParentId.value;

              return ListTile(
                selected: isSelected,
                selectedTileColor: Theme.of(
                  context,
                ).primaryColor.withOpacity(0.1),
                title: Text(parent.metadata.name),
                onTap: () => selectedParentId.value = parentId,
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  onPressed: () {
                    final nextCollection = Collection.childSelector(
                      parentId,
                    ).set(collection, null);
                    onCollectionChanged(
                      nextCollection
                          as Collection<ImageCollectionResource<ImageItem>>,
                    );

                    if (isSelected) {
                      selectedParentId.value = null;
                    }
                  },
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        TextButton.icon(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(designValues.medium),
            shape: const RoundedRectangleBorder(),
          ),
          icon: const Icon(Icons.add),
          label: addParentLabel,
          onPressed: () async {
            final placeName = await showDialog<String>(
              context: context,
              builder: (context) =>
                  const NovelNewNameDialog(title: "New Parent"),
            );

            if (placeName != null && placeName.isNotEmpty) {
              final nextCollection =
                  Collection.childSelector<ImageCollectionResource<ImageItem>>(
                    Id.create(),
                  ).set(
                    collection,
                    ImageCollectionResource(
                      name: Name(placeName),
                      images: Collection.empty(),
                    ),
                  );

              onCollectionChanged(nextCollection);
            }
          },
        ),
      ],
    );
  }
}

class NovelImageResourceViewer<ImageItem extends ImageResource>
    extends HookWidget {
  final Collection<ImageCollectionResource<ImageItem>> collection;
  final Id<CollectionResource<ImageItem>> parentId;
  final FullId<ImageItem>? currentSelectionId;
  final DesignValues designValues;
  final ValueChanged<FullId<ImageItem>> onSelectionChanged;
  final ValueChanged<Collection<ImageCollectionResource<ImageItem>>>
  onCollectionChanged;

  const NovelImageResourceViewer({
    super.key,
    required this.collection,
    required this.parentId,
    required this.currentSelectionId,
    required this.designValues,
    required this.onSelectionChanged,
    required this.onCollectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final parent = collection.find(
      parentId as Id<ImageCollectionResource<ImageItem>>,
    );
    final childList = parent?.value.entries.toList() ?? [];

    return GridView.builder(
      padding: EdgeInsets.all(designValues.small),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: designValues.small,
        mainAxisSpacing: designValues.small,
        childAspectRatio: 0.85,
      ),
      itemCount: childList.length + 1,
      itemBuilder: (context, index) {
        if (index == childList.length) {
          return NovelAddChildButton(
            designValues: designValues,
            onAdd: () async {
              final image = await pickImage();

              if (image == null) return;

              final customName = await showDialog<String>(
                context: context,
                builder: (context) =>
                    const NovelNewNameDialog(title: "Name this Image"),
              );

              if (customName != null && customName.isNotEmpty) {
                final nextCollection =
                    FullId(
                      parentId: parentId,
                      childId: Id.create<ImageItem>(),
                    ).childSelector().set(
                      collection,
                      ImageResource(
                            name: Name(customName),
                            image: ImageData(image: image),
                          )
                          as ImageItem,
                    );

                onCollectionChanged(
                  nextCollection
                      as Collection<ImageCollectionResource<ImageItem>>,
                );
              }
            },
          );
        }

        final childEntry = childList[index];
        final childId = childEntry.key;
        final child = childEntry.value;

        // FIX 5 continued: parentId is now implicitly correctly typed
        final fullId = FullId(parentId: parentId, childId: childId);

        final isCurrentlyApplied =
            currentSelectionId?.parentId == parentId &&
            currentSelectionId?.childId == childId;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  InkWell(
                    onTap: () => onSelectionChanged(fullId),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(designValues.small),
                        border: Border.all(
                          color: isCurrentlyApplied
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: Image.memory(child.value.image),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.redAccent),
                      onPressed: () {
                        final nextCollection = fullId.childSelector().set(
                          collection,
                          null,
                        );
                        onCollectionChanged(
                          nextCollection
                              as Collection<ImageCollectionResource<ImageItem>>,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: designValues.verySmall),
            TextFormField(
              key: ValueKey(childId),
              initialValue: child.metadata.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
              onChanged: (newValue) {
                if (newValue.isNotEmpty) {
                  final nextCollection = fullId.childSelector().update(
                    collection,
                    (child) {
                      if (child == null) return null;

                      return child.copyWith(metadata: Name(newValue))
                          as ImageItem;
                    },
                  );

                  onCollectionChanged(
                    nextCollection
                        as Collection<ImageCollectionResource<ImageItem>>,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<Uint8List?> pickImage() async {
    final readHandles = await WebReadHandle.showOpenFileDialog(
      multiple: false,
      accept: [
        XTypeGroup(extensions: ['png', 'jpg', 'jpeg', 'webp']),
      ],
    );

    if (readHandles.isEmpty) return null;

    final fileItem = await readHandles.first.read();
    final fileBytes = fileItem.value;

    return fileBytes.bytes;
  }
}

class NovelAddChildButton extends StatelessWidget {
  final DesignValues designValues;
  final VoidCallback onAdd;

  const NovelAddChildButton({
    super.key,
    required this.designValues,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAdd,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(designValues.small),
        ),
        child: const Center(child: Icon(Icons.add_rounded, size: 32)),
      ),
    );
  }
}

class NovelNewNameDialog extends HookWidget {
  final String title;
  final String? initialText;

  const NovelNewNameDialog({super.key, required this.title, this.initialText});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialText);

    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: "Enter name..."),
        onSubmitted: (value) => Navigator.of(context).pop(value),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(controller.text),
          child: const Text("Confirm"),
        ),
      ],
    );
  }
}
