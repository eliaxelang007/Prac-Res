// import "package:flutter/material.dart";
// import 'package:drift/drift.dart' hide Column;
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:prac_res/data/data.dart';
// import 'package:prac_res/pages/design_values.dart';
// import 'package:prac_res/pages/open.dart';

// class NovelImageCollectionGroupInspector<
//   ImageCollectionTable extends HasResultSet,
//   ImageCollection
// >
//     extends HookWidget {
//   final ResultSetImplementation<ImageCollectionTable, ImageCollection>
//   collection;
//   final Widget title;
//   final Widget addParentLabel;
//   final Widget emptySelectionLabel;

//   final int? currentSelectionId;
//   final ValueChanged<int> onSelectionChanged;

//   const NovelImageCollectionGroupInspector({
//     super.key,
//     required this.collection,
//     required this.title,
//     required this.addParentLabel,
//     required this.emptySelectionLabel,
//     required this.currentSelectionId,
//     required this.onSelectionChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final designValues = Theme.of(context).extension<DesignValues>()!;

//     final selectedPlaceId = useState<int?>(null);

//     return AlertDialog(
//       title: title,
//       content: SizedBox(
//         width: 800,
//         height: 500,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               flex: 1,
//               child: NovelImageCollectionInspector(
//                 collection: collection,
//                 selectedPlaceId: selectedPlaceId,
//                 addParentLabel: addParentLabel,
//                 designValues: designValues,
//               ),
//             ),
//             const VerticalDivider(width: 1),
//             Expanded(
//               flex: 3,
//               child: selectedPlaceId.value == null
//                   ? Center(child: emptySelectionLabel)
//                   : NovelImagesInspector(
//                       collection: collection,
//                       placeId: selectedPlaceId.value!,
//                       currentSelectionId: currentSelectionId,
//                       designValues: designValues,
//                       onSelectionChanged: (id) {
//                         onSelectionChanged(id);
//                         Navigator.of(context).pop();
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text("Cancel"),
//         ),
//       ],
//     );
//   }
// }

// class NovelImageCollectionInspector<
//   ImageCollectionTable extends HasResultSet,
//   ImageCollection
// >
//     extends HookWidget {
//   final ResultSetImplementation<ImageCollectionTable, ImageCollection>
//   collection;
//   final ValueNotifier<int?> selectedPlaceId;
//   final Widget addParentLabel;
//   final DesignValues designValues;

//   const NovelImageCollectionInspector({
//     super.key,
//     required this.collection,
//     required this.selectedPlaceId,
//     required this.addParentLabel,
//     required this.designValues,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Reactively watch the database! No more manual state updates.
//     final placeStream = useStream(collection.select().watch());
//     final placeList = placeStream.data ?? [];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: placeList.length,
//             itemBuilder: (context, index) {
//               final place = placeList[index];
//               final isSelected = place.id == selectedPlaceId.value;

//               return ListTile(
//                 selected: isSelected,
//                 selectedTileColor: Theme.of(
//                   context,
//                 ).primaryColor.withOpacity(0.1),
//                 title: Text(place.name),
//                 onTap: () => selectedPlaceId.value = place.id,
//                 trailing: IconButton(
//                   icon: const Icon(Icons.delete_outline, size: 20),
//                   onPressed: () async {
//                     // Drift automatically handles cascading deletes!
//                     await db.places.deleteWhere((t) => t.id.equals(place.id));
//                     if (isSelected) {
//                       selectedPlaceId.value = null;
//                     }
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//         const Divider(height: 1),
//         TextButton.icon(
//           style: TextButton.styleFrom(
//             padding: EdgeInsets.all(designValues.medium),
//             shape: const RoundedRectangleBorder(),
//           ),
//           icon: const Icon(Icons.add),
//           label: addParentLabel,
//           onPressed: () async {
//             final placeName = await showDialog<String>(
//               context: context,
//               builder: (context) =>
//                   const NovelNewNameDialog(title: "New Parent"),
//             );

//             if (placeName != null && placeName.isNotEmpty) {
//               // Simply insert into the database. The stream will auto-refresh the UI!
//               await db
//                   .into(db.places)
//                   .insert(PlacesCompanion.insert(name: placeName));
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

// class NovelImagesInspector<
//   ImageCollectionTable extends HasResultSet,
//   ImageCollection
// >
//     extends HookWidget {
//   final ResultSetImplementation<ImageCollectionTable, ImageCollection>
//   collection;
//   final int placeId;
//   final int? currentSelectionId;
//   final DesignValues designValues;
//   final ValueChanged<int> onSelectionChanged;

//   const NovelImagesInspector({
//     super.key,
//     required this.collection,
//     required this.placeId,
//     required this.currentSelectionId,
//     required this.designValues,
//     required this.onSelectionChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Watch the children for the currently selected parent
//     final backgroundStream = useStream(db.watchBackgroundsForPlace(placeId));
//     final childList = backgroundStream.data ?? [];

//     return GridView.builder(
//       padding: EdgeInsets.all(designValues.small),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: designValues.small,
//         mainAxisSpacing: designValues.small,
//         childAspectRatio: 0.85,
//       ),
//       itemCount: childList.length + 1,
//       itemBuilder: (context, index) {
//         if (index == childList.length) {
//           return NovelAddChildButton(
//             onAdd: () async {
//               final imageBytes = await pickImage();
//               if (imageBytes == null) return;

//               final customName = await NovelNewNameDialog.show(
//                 context,
//                 title: "Name this Image",
//               );

//               if (customName != null && customName.isNotEmpty) {
//                 // Execute a database transaction to insert both the background and its image blob
//                 await db.transaction(() async {
//                   final newBackgroundId = await db
//                       .into(db.backgrounds)
//                       .insert(
//                         BackgroundsCompanion.insert(
//                           placeId: placeId,
//                           name: customName,
//                         ),
//                       );

//                   await db
//                       .into(db.backgroundImages)
//                       .insert(
//                         BackgroundImagesCompanion.insert(
//                           backgroundId: newBackgroundId,
//                           imageData: imageBytes,
//                         ),
//                       );
//                 });
//               }
//             },
//           );
//         }

//         final item = childList[index];
//         final isCurrentlyApplied = currentSelectionId == item.background.id;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   InkWell(
//                     onTap: () => onSelectionChanged(item.background.id),
//                     child: Container(
//                       clipBehavior: Clip.antiAlias,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(designValues.small),
//                         border: Border.all(
//                           color: isCurrentlyApplied
//                               ? Theme.of(context).primaryColor
//                               : Colors.transparent,
//                           width: 3,
//                         ),
//                       ),
//                       child: Image.memory(item.image.imageData),
//                     ),
//                   ),
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: IconButton(
//                       icon: const Icon(Icons.cancel, color: Colors.redAccent),
//                       onPressed: () async {
//                         // Cascade delete will remove the image data automatically
//                         await db.backgrounds.deleteWhere(
//                           (t) => t.id.equals(item.background.id),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: designValues.verySmall),
//             TextFormField(
//               key: ValueKey(item.background.id),
//               initialValue: item.background.name,
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodySmall,
//               decoration: const InputDecoration(
//                 isDense: true,
//                 contentPadding: EdgeInsets.zero,
//                 border: InputBorder.none,
//               ),
//               onChanged: (newValue) async {
//                 if (newValue.isNotEmpty) {
//                   // Update the database instantly
//                   await (db.update(db.backgrounds)
//                         ..where((t) => t.id.equals(item.background.id)))
//                       .write(BackgroundsCompanion(name: Value(newValue)));
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class NovelAddChildButton extends StatelessWidget {
//   final VoidCallback onAdd;

//   const NovelAddChildButton({super.key, required this.onAdd});

//   @override
//   Widget build(BuildContext context) {
//     final designValues = Theme.of(context).extension<DesignValues>()!;

//     return InkWell(
//       onTap: onAdd,
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Theme.of(context).dividerColor,
//             style: BorderStyle.solid,
//           ),
//           borderRadius: BorderRadius.circular(designValues.small),
//         ),
//         child: const Center(child: Icon(Icons.add_rounded, size: 32)),
//       ),
//     );
//   }
// }
