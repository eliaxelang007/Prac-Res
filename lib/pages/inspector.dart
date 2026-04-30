import 'dart:typed_data';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
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
          ] else ...[
            Text("Select a Frame to inspect.", style: textTheme.bodyMedium),
          ],
        ],
      ),
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

    if (currentBackgroundId == null) {
      return const Placeholder();
    }

    final currentBytes = ref.watch(
      selectedSceneGroupProvider.select((group) {
        if (group == null) return null;
        return group
            .backgroundPath(currentBackgroundId!)
            .get(group)
            ?.value
            .image;
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

            return NovelImageCollectionEditor<Background>(
              title: "Select Background",
              addParentLabel: "Add Place",
              emptySelectionLabel: "Select a Place",
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

/// A highly reusable and clean editor taking an immutable collection.
class NovelImageCollectionEditor<ImageItem extends ImageResource>
    extends HookWidget {
  final String title;
  final String addParentLabel;
  final String emptySelectionLabel;

  final Collection<ImageCollectionResource<ImageItem>> imageCollection;
  final ValueChanged<Collection<ImageCollectionResource<ImageItem>>>
  onImageCollectionEdited;

  final FullId<ImageItem>? currentSelectionId;
  final ValueChanged<FullId<ImageItem>> onSelectionChanged;

  const NovelImageCollectionEditor({
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
      title: Text(title),
      content: SizedBox(
        width: 800,
        height: 500,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: _ParentViewer(
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
                  ? Center(child: Text(emptySelectionLabel))
                  : _ChildGridView(
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

class _ParentViewer<ImageItem extends ImageResource> extends HookWidget {
  final Collection<ImageCollectionResource<ImageItem>> collection;

  final ValueNotifier<Id<CollectionResource<ImageItem>>?> selectedParentId;
  final String addParentLabel;
  final DesignValues designValues;
  final ValueChanged<Collection<ImageCollectionResource<ImageItem>>>
  onCollectionChanged;

  const _ParentViewer({
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
          label: Text(addParentLabel),
          onPressed: () async {
            final placeName = await showDialog<String>(
              context: context,
              builder: (context) => const _NewNameDialog(title: "New Parent"),
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

class _ChildGridView<ImageItem extends ImageResource> extends HookWidget {
  final Collection<ImageCollectionResource<ImageItem>> collection;
  final Id<CollectionResource<ImageItem>> parentId;
  final FullId<ImageItem>? currentSelectionId;
  final DesignValues designValues;
  final ValueChanged<FullId<ImageItem>> onSelectionChanged;
  final ValueChanged<Collection<ImageCollectionResource<ImageItem>>>
  onCollectionChanged;

  const _ChildGridView({
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
          return _AddChildButton(
            designValues: designValues,
            onAdd: () async {
              final image = await pickImage();

              if (image == null) return;

              final customName = await showDialog<String>(
                context: context,
                builder: (context) =>
                    const _NewNameDialog(title: "Name this Image"),
              );

              if (customName != null && customName.isNotEmpty) {
                print("Woah!");

                // // Sorry I'm kind of confused about what this is. Could you please fix this callback?

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

class _AddChildButton extends StatelessWidget {
  final DesignValues designValues;
  final VoidCallback onAdd;

  const _AddChildButton({required this.designValues, required this.onAdd});

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

class _NewNameDialog extends HookWidget {
  final String title;
  final String? initialText;

  const _NewNameDialog({required this.title, this.initialText});

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
