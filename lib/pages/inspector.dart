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
    final selectedScene = ref.watch(selectedSceneProvider);
    final selectedScenePart = ref.watch(selectedScenePartProvider);

    final scene = sceneGroup?.scenes.items.find(selectedScene);
    final scenePart = scene?.resource.find(selectedScenePart)?.part;

    return Padding(
      padding: EdgeInsets.all(designValues.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Edit Properties", style: textTheme.bodyLarge),
          const Divider(),
          if (scenePart is Frame) ...[
            Text("Background", style: textTheme.bodyMedium),
            SizedBox(height: designValues.small),
            NovelBackgroundInspector(
              currentBackgroundId: scenePart.background,
              onChanged: (newBackgroundId) {
                // TODO: Update your provider here!
                // ref.read(selectedSceneGroupProvider.notifier).updateGroup(...)
                print("Selected new background: ${newBackgroundId.toJson()}");
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
  final FullBackgroundId? currentBackgroundId;
  final ValueChanged<FullBackgroundId> onChanged;

  const NovelBackgroundInspector({
    super.key,
    required this.currentBackgroundId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    final backgroundId = currentBackgroundId;

    if (backgroundId == null) {
      return const Placeholder();
    }

    final currentBytes = ref.watch(
      selectedSceneGroupProvider.select((group) {
        final currentPlace = group?.places.items.find(backgroundId.parentId);
        final currentBackground = currentPlace?.resource.collection.find(
          backgroundId.childId,
        );
        return currentBackground?.resource.resource.value.image;
      }),
    );

    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => Consumer(
          builder: (context, ref, child) {
            final places = ref.watch(
              selectedSceneGroupProvider.select((group) => group?.places),
            );

            // if (places == null) {
            //   return const Placeholder();
            // }

            return NovelCollectionEditor<
              PlaceId,
              BackgroundId,
              Background,
              FullBackgroundId
            >(
              title: "Select Background",
              addParentLabel: "Add Place",
              emptySelectionLabel: "Select a Place",
              collection: places?.items,
              currentImageId: backgroundId,
              onChanged: onChanged,
              idFactory: (placeId, bgId) => FullBackgroundId.fromJson({
                'metadata': Id.toJson(placeId),
                'value': Id.toJson(bgId),
              }),

              // --- NEW: Add Place Implementation ---
              onAddParent: () async {
                final placeName = await showDialog<String>(
                  context: context,
                  builder: (context) =>
                      const _NewNameDialog(title: "New Place"),
                );

                if (placeName != null && placeName.isNotEmpty) {
                  ref
                      .read(selectedSceneGroupProvider.notifier)
                      .addPlace(placeName);
                }
              },

              onAddChild: (placeId) async {
                final readHandles = await WebReadHandle.showOpenFileDialog(
                  multiple: false,
                  accept: [
                    XTypeGroup(extensions: ['png', 'jpg', 'jpeg', 'webp']),
                  ],
                );

                if (readHandles.isEmpty) return;

                final fileItem = await readHandles.first.read();
                final filename = fileItem.key;
                final fileBytes = fileItem.value;

                // Strip the extension for a cleaner default name
                final defaultName = filename.contains('.')
                    ? filename.substring(0, filename.lastIndexOf('.'))
                    : filename;

                // Prompt the user for a meaningful name
                final customName = await showDialog<String>(
                  context: context,
                  builder: (context) => _NewNameDialog(
                    title: "Name this Image",
                    initialText: defaultName,
                  ),
                );

                // Bail out if they cancelled or left it blank
                if (customName == null || customName.trim().isEmpty) return;

                ref
                    .read(selectedSceneGroupProvider.notifier)
                    .addBackground(placeId, customName.trim(), fileBytes.bytes);
              },

              // --- NEW: Deletion Callbacks ---
              onDeleteParent: (placeId) {
                ref
                    .read(selectedSceneGroupProvider.notifier)
                    .deletePlace(placeId);
              },
              onDeleteChild: (placeId, bgId) {
                ref
                    .read(selectedSceneGroupProvider.notifier)
                    .deleteBackground(placeId, bgId);
              },
            );
          },
        ),
      ),
      borderRadius: BorderRadius.circular(designValues.small),
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

class _NewNameDialog extends HookWidget {
  final String title;
  final String? initialText;

  const _NewNameDialog({required this.title, this.initialText});

  @override
  Widget build(BuildContext context) {
    // Pass the initial text to the hook
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

class NovelCollectionEditor<
  ParentId extends Id,
  ChildId extends Id,
  ImageItem,
  FullImageId extends FullId<ParentId, ChildId, ImageItem>
>
    extends HookWidget {
  final String title;
  final String addParentLabel;
  final String emptySelectionLabel;
  final Collection<ParentId, ImageCollectionResource<ChildId, ImageItem>>?
  collection;
  final FullImageId currentImageId;
  final ValueChanged<FullImageId> onChanged;
  final FullImageId Function(ParentId parentId, ChildId childId) idFactory;
  final VoidCallback? onAddParent;
  final ValueChanged<ParentId>? onAddChild;

  final ValueChanged<ParentId>? onDeleteParent;
  final void Function(ParentId parentId, ChildId childId)? onDeleteChild;

  // 1. Added callback for updating the name
  final void Function(ParentId parentId, ChildId childId, String newName)?
  onUpdateChildName;

  const NovelCollectionEditor({
    super.key,
    required this.title,
    this.addParentLabel = "Add Collection",
    this.emptySelectionLabel = "Select a Collection",
    required this.collection,
    required this.currentImageId,
    required this.onChanged,
    required this.idFactory,
    this.onAddParent,
    this.onAddChild,
    this.onDeleteParent,
    this.onDeleteChild,
    this.onUpdateChildName, // Make sure to add it here
  });

  @override
  Widget build(BuildContext context) {
    final designValues = Theme.of(context).extension<DesignValues>()!;

    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 800,
        height: 500,
        child: (collection != null)
            ? HookBuilder(
                builder: (context) {
                  // We can use the parentId getter from FullId!
                  final selectedParentId = useState<ParentId?>(
                    currentImageId.parentId,
                  );

                  final parentList = collection!.items.entries.toList();
                  final viewedParent = collection!.find(selectedParentId.value);
                  final childList =
                      viewedParent?.collection.resource.value.items.entries
                          .toList() ??
                      [];

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // --- LEFT SIDE: PARENT LIST ---
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: parentList.length,
                                itemBuilder: (context, index) {
                                  final parentEntry = parentList[index];
                                  final parentId = parentEntry.key;
                                  final parent = parentEntry.value;
                                  final isSelected =
                                      parentId == selectedParentId.value;

                                  return ListTile(
                                    selected: isSelected,
                                    selectedTileColor: Theme.of(
                                      context,
                                    ).primaryColor.withOpacity(0.1),
                                    title: Text(parent.metadata.toString()),
                                    onTap: () =>
                                        selectedParentId.value = parentId,
                                    trailing: onDeleteParent != null
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              // Optional: Show a confirmation dialog here first!
                                              onDeleteParent!(parentId);
                                              // Reset selection if we deleted the viewed item
                                              if (isSelected) {
                                                selectedParentId.value = null;
                                              }
                                            },
                                          )
                                        : null,
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
                              onPressed: onAddParent,
                              icon: const Icon(Icons.add),
                              label: Text(addParentLabel),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(width: 1),

                      // --- RIGHT SIDE: IMAGES GRID ---
                      Expanded(
                        flex: 3,
                        child: selectedParentId.value == null
                            ? Center(child: Text(emptySelectionLabel))
                            : Column(
                                children: [
                                  Expanded(
                                    child: GridView.builder(
                                      padding: EdgeInsets.all(
                                        designValues.small,
                                      ),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing:
                                                designValues.small,
                                            mainAxisSpacing: designValues.small,
                                            childAspectRatio: 0.85,
                                          ),
                                      itemCount: childList.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index == childList.length) {
                                          return InkWell(
                                            onTap: () => onAddChild?.call(
                                              selectedParentId.value!,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Theme.of(
                                                    context,
                                                  ).dividerColor,
                                                  style: BorderStyle.solid,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      designValues.small,
                                                    ),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.add_photo_alternate,
                                                  size: 32,
                                                ),
                                              ),
                                            ),
                                          );
                                        }

                                        final childEntry = childList[index];
                                        final childId = childEntry.key;
                                        final imageBytes =
                                            childEntry.value.value.image;

                                        final isCurrentlyApplied =
                                            currentImageId.parentId ==
                                                selectedParentId.value &&
                                            currentImageId.childId == childId;

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              child: Stack(
                                                fit: StackFit.expand,
                                                children: [
                                                  // Image Container
                                                  InkWell(
                                                    onTap: () {
                                                      final fullId = idFactory(
                                                        selectedParentId.value!,
                                                        childId,
                                                      );
                                                      onChanged(fullId);
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },
                                                    child: Container(
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              designValues
                                                                  .small,
                                                            ),
                                                        border: Border.all(
                                                          color:
                                                              isCurrentlyApplied
                                                              ? Theme.of(
                                                                  context,
                                                                ).primaryColor
                                                              : Colors
                                                                    .transparent,
                                                          width: 3,
                                                        ),
                                                      ),
                                                      child: Image.memory(
                                                        imageBytes,
                                                        // 4. Change to contain to fit portrait actors
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),

                                                  // 5. Child Delete Button
                                                  if (onDeleteChild != null)
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: IconButton(
                                                        icon: const Icon(
                                                          Icons.cancel,
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                        onPressed: () =>
                                                            onDeleteChild!(
                                                              selectedParentId
                                                                  .value!,
                                                              childId,
                                                            ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: designValues.verySmall,
                                            ),

                                            // 6. Meaningful Name Label (Now Editable)
                                            TextFormField(
                                              // Use a key so the field resets if the underlying data completely changes
                                              key: ValueKey(childId),
                                              initialValue: childEntry
                                                  .value
                                                  .metadata
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall,
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder
                                                    .none, // Hide the underline for a cleaner look
                                              ),
                                              onFieldSubmitted: (newValue) {
                                                if (onUpdateChildName != null &&
                                                    newValue !=
                                                        childEntry
                                                            .value
                                                            .metadata
                                                            .toString()) {
                                                  onUpdateChildName!(
                                                    selectedParentId.value!,
                                                    childId,
                                                    newValue,
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  );
                },
              )
            : const Placeholder(),
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
