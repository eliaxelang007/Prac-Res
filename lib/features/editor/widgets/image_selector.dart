import 'package:flutter/material.dart' hide Table;

import 'package:drift/drift.dart' hide Column;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:junction/junction.dart';
import 'package:prac_res/core/theme/design_values.dart';
import 'package:prac_res/core/widgets/deletion_dialog.dart';
import 'package:prac_res/core/widgets/new_name_dialog.dart';
import 'package:prac_res/core/widgets/scrolling.dart';

import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/widgets/card.dart';
import 'package:prac_res/core/widgets/editable_text.dart';
import 'package:prac_res/core/widgets/database/group_selector.dart';
import 'package:prac_res/core/widgets/database/query_builder.dart';
import 'package:prac_res/features/editor/screens/editor_page.dart';
import 'package:prac_res/features/scene_viewer/widgets/frame.dart';

class NovelImageSelectorPreview<
  G extends Group,
  M extends ImageMetadata,
  D extends ImageData
>
    extends StatelessWidget {
  final ProviderListenable<TableInfo<GroupTable, G>> imageGroupTable;
  final ProviderListenable<TableInfo<ImageMetadataTable, M>> imageMetadataTable;
  final ProviderListenable<TableInfo<ImageDataTable, D>> imageDataTable;

  final int? selectedImageId;
  final void Function(int?) onImageSelected;

  final Widget title;

  const NovelImageSelectorPreview({
    super.key,
    required this.title,
    required this.imageGroupTable,
    required this.imageMetadataTable,
    required this.imageDataTable,
    required this.selectedImageId,
    required this.onImageSelected,
  });

  static final metadataProvider =
      StreamProvider.family<
        ImageMetadata?,
        (EquatableTableInfo<ImageMetadataTable, ImageMetadata>, int?)
      >((ref, identifiers) {
        final (imageMetadataTableWrapper, metadataId) = identifiers;

        if (metadataId == null) {
          return Stream.value(null);
        }

        return (imageMetadataTableWrapper.wrapped.select()
              ..where((metadataEntry) => metadataEntry.id.equals(metadataId)))
            .watchSingleOrNull();
      });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: NovelCard(
        onTap: () => showDialog(
          context: context,
          builder: (context) => NovelQueryBuilder(
            query: (ref) => ref.watch(
              metadataProvider((
                EquatableTableInfo(ref.watch(imageMetadataTable)),
                selectedImageId,
              )),
            ),
            builder: (context, ref, metadata) {
              return HookBuilder(
                builder: (context) {
                  final maybeMetadataGroupId = metadata?.groupId;

                  final selectedImageGroup = useState<int?>(
                    maybeMetadataGroupId,
                  );

                  // We need this so that changes propagate because we're in a Dialog!
                  final selectedImageIdNotifier = useState<int?>(
                    selectedImageId,
                  );

                  return NovelImageSelectorLayout(
                    title: title,
                    imageGroupSelector: NovelImageGroupSelector(
                      imageGroupTable: imageGroupTable,
                      selectedGroupState: selectedImageGroup,
                    ),
                    imageSelector: NovelImageSelector(
                      imageMetadataTable: imageMetadataTable,
                      imageDataTable: imageDataTable,
                      selectedImageGroup: selectedImageGroup.value,
                      selectedImageId: selectedImageIdNotifier.value,
                      onImageSelected: (newImageId) {
                        selectedImageIdNotifier.value = newImageId;
                        onImageSelected(newImageId);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
        child: SizedBox.expand(
          child: NovelImage(
            imageTable: imageDataTable,
            maybeImageId: selectedImageId,
          ),
        ),
      ),
    );
  }
}

class NovelImageSelectorLayout extends StatelessWidget {
  final Widget imageGroupSelector;
  final Widget imageSelector;
  final Widget title;

  const NovelImageSelectorLayout({
    super.key,
    required this.imageGroupSelector,
    required this.imageSelector,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: SizedBox(
        width: 800,
        height: 500,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(DesignValues.verySmall),
                child: imageGroupSelector,
              ),
            ),
            VerticalDivider(),
            Expanded(
              flex: 11,
              child: Padding(
                padding: EdgeInsets.all(DesignValues.verySmall),
                child: imageSelector,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NovelImageGroupSelector<G extends Group> extends StatelessWidget {
  final ProviderListenable<TableInfo<GroupTable, G>> imageGroupTable;
  final ValueNotifier<int?> selectedGroupState;

  const NovelImageGroupSelector({
    super.key,
    required this.imageGroupTable,
    required this.selectedGroupState,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollbarView(
        scrollDirection: Axis.vertical,
        child: NovelGroupSelector(
          title: Text("Image Group"),
          onChanged: (selectedGroup) {
            selectedGroupState.value = selectedGroup;
          },
          groupTableProvider: imageGroupTable,
          selectedGroup: selectedGroupState.value,
        ),
      ),
    );
  }
}

class NovelImageSelector<M extends ImageMetadata, D extends ImageData>
    extends StatelessWidget {
  final ProviderListenable<TableInfo<ImageMetadataTable, M>> imageMetadataTable;
  final ProviderListenable<TableInfo<ImageDataTable, D>> imageDataTable;
  final int? selectedImageGroup;
  final int? selectedImageId;
  final void Function(int?) onImageSelected;

  const NovelImageSelector({
    super.key,
    required this.imageMetadataTable,
    required this.imageDataTable,
    required this.selectedImageGroup,
    required this.selectedImageId,
    required this.onImageSelected,
  });

  static final metadataGroupProvider =
      StreamProvider.family<
        List<ImageMetadata>,
        (EquatableTableInfo<ImageMetadataTable, ImageMetadata>, int?)
      >((ref, identifiers) {
        final (imageMetadataTableWrapper, groupId) = identifiers;

        if (groupId == null) {
          return Stream.value([]);
        }

        return (imageMetadataTableWrapper.wrapped.select()
              ..orderBy([(u) => OrderingTerm(expression: u.id)])
              ..where((row) => row.groupId.equals(groupId)))
            .watch();
      });

  @override
  Widget build(BuildContext context) {
    final imageGroupId = selectedImageGroup;

    return NovelQueryBuilder(
      query: (ref) => ref.watch(
        metadataGroupProvider((
          EquatableTableInfo(ref.watch(imageMetadataTable)),
          imageGroupId,
        )),
      ),
      builder: (context, ref, metadatas) {
        return GridView.count(
          crossAxisCount: 4,
          children: [
            for (final metadata in metadatas)
              NovelImageSelectable(
                selectedImageId: selectedImageId,
                metadata: metadata,
                onImageSelected: onImageSelected,
                imageDataTable: imageDataTable,
                imageMetadataTable: imageMetadataTable,
              ),

            if (imageGroupId != null)
              Center(
                child: IconButton(
                  onPressed: () async {
                    final selectedImage =
                        await WebReadHandle.showOpenFileDialog(
                          accept: [
                            XTypeGroup(
                              extensions: <String>['jpg', 'jpeg', 'png'],
                            ),
                          ],
                        );

                    if (selectedImage.isEmpty) return;

                    final imageBytes =
                        (await selectedImage.first.read()).value.bytes;

                    final customName = await NovelNewNameDialog.show(
                      context,
                      title: "Name this Image",
                    );

                    if (customName == null) return;

                    // SAFETY: I'm kind of iffy about this one because of a potential database to table mismatch,
                    // but AI says I should do it in a transaction, and I agree.
                    final sceneGroup = ref.read(
                      NovelSceneGroupEditorPage.sceneGroupProvider,
                    );

                    await sceneGroup.transaction(() async {
                      final newMetadataId = await sceneGroup
                          .into(ref.read(imageMetadataTable))
                          .insert(
                            ImageMetadataCompanion.insert(
                              groupId: imageGroupId,
                              name: customName,
                            ),
                          );

                      await sceneGroup
                          .into(ref.read(imageDataTable))
                          .insert(
                            ImageDataCompanion.insert(
                              metadataId: Value(newMetadataId),
                              imageData: imageBytes,
                            ),
                          );
                    });
                  },
                  icon: Icon(Icons.add_rounded),
                ),
              ),
          ].map((widget) => AspectRatio(aspectRatio: 1, child: widget)).toList(),
        );
      },
    );
  }
}

class NovelImageSelectable<M extends ImageMetadata> extends StatelessWidget {
  const NovelImageSelectable({
    super.key,
    required this.selectedImageId,
    required this.metadata,
    required this.onImageSelected,
    required this.imageDataTable,
    required this.imageMetadataTable,
  });

  final int? selectedImageId;
  final ImageMetadata metadata;
  final void Function(int?) onImageSelected;
  final ProviderListenable<TableInfo<ImageDataTable, ImageData>> imageDataTable;
  final ProviderListenable<TableInfo<ImageMetadataTable, M>> imageMetadataTable;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Stack(
            children: [
              Positioned.fill(
                child: NovelCard(
                  isSelected: selectedImageId == metadata.id,
                  onTap: () => onImageSelected(metadata.id),
                  child: NovelImage(
                    imageTable: imageDataTable,
                    maybeImageId: metadata.id,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Consumer(
                  builder: (context, ref, child) {
                    return IconButton(
                      icon: Icon(Icons.delete_rounded),
                      onPressed: () async {
                        final shouldDelete = await NovelDeletionDialog.show(
                          context,
                        );

                        if (!shouldDelete) return;

                        final metadataTable = ref.read(imageMetadataTable);

                        await (metadataTable.delete()..where(
                              (metadataEntry) =>
                                  metadataEntry.id.equals(metadata.id),
                            ))
                            .go();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: DesignValues.verySmall),
            child: Consumer(
              builder: (context, ref, child) {
                return NovelEditableText(
                  sourceText: metadata.name,
                  builder: (context, controller, focusNode) => TextField(
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(),
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    controller: controller,
                    onChanged: (newName) async {
                      final metadataTable = ref.read(imageMetadataTable);

                      await (metadataTable.update()..where(
                            (metadataEntry) =>
                                metadataEntry.id.equals(metadata.id),
                          ))
                          .write(ImageMetadataCompanion(name: Value(newName)));
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
