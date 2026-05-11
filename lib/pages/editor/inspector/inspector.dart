// import 'dart:typed_data';
// import 'package:drift/drift.dart' hide Column;
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:junction/junction.dart';
// import 'package:prac_res/data/data.dart';
// import 'package:prac_res/pages/design_values.dart';
// import 'package:prac_res/pages/editor_state.dart';

import 'package:flutter/material.dart';

class NovelInspector extends StatelessWidget {
  const NovelInspector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// class NovelInspector extends ConsumerWidget {
//   const NovelInspector({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = Theme.of(context);
//     final textTheme = theme.textTheme;
//     final designValues = theme.extension<DesignValues>()!;

//     final sceneGroup = ref.watch(selectedSceneGroupProvider);

//     if (sceneGroup == null) {
//       return const Placeholder(child: Text("sceneGroup == null"));
//     }

//     final selectedSceneId = ref.watch(selectedSceneProvider);

//     if (selectedSceneId == null) {
//       return const Placeholder(child: Text("selectedSceneId == null"));
//     }

//     final selectedScenePartId = ref.watch(selectedScenePartProvider);

//     if (selectedScenePartId == null) {
//       return const Placeholder(child: Text("selectedScenePartId == null"));
//     }

//     // final scenePartFullId =
//     //     selectedSceneId != null && selectedScenePartId != null
//     //     ? FullId<OrderedScenePart>(
//     //         parentId: selectedSceneId,
//     //         childId: selectedScenePartId,
//     //       )
//     //     : null;

//     final scenePart =
//         (sceneGroup.sceneTimelineView.select()
//               ..where((scenePart) => scenePart.id.equals(selectedScenePartId)))
//             .getSingle();
//     // scenePartFullId != null
//     //     ? sceneGroup?.scenePartPath(scenePartFullId).get(sceneGroup)?.part
//     //     : null;

//     return Padding(
//       padding: EdgeInsets.all(designValues.small),
//       child: SingleChildScrollView(
//         child: FutureBuilder(
//           future: scenePart,
//           builder: (context, asyncSnapshot) {
//             if (!asyncSnapshot.hasData) {
//               return Placeholder(child: Text("scenePart !hasData"));
//             }

//             final maybeFrame = asyncSnapshot.data;

//             if (maybeFrame == null) {
//               return Placeholder(child: Text("maybeFrame == null"));
//             }

//             final timelineItem = SceneTimelineItem.fromSceneTimelineViewData(
//               maybeFrame,
//             ).specifics;

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Edit Properties", style: textTheme.bodyLarge),
//                 const Divider(),
//                 if (timelineItem is TimelineFrame) ...[
//                   Text("Background", style: textTheme.bodyMedium),
//                   SizedBox(height: designValues.small),
//                   NovelBackgroundInspector(
//                     currentBackgroundId: timelineItem.frameData.backgroundId,
//                     onChanged: (newBackgroundId) {
//                       if (selectedScenePartId == null && newBackgroundId == null) return;

//                       sceneGroup
//                           .update(sceneGroup.frames)
//                           .replace(
//                             FramesCompanion(
//                               scenePartId: drift.Value(selectedScenePartId),
//                               backgroundId: drift.Value(newBackgroundId),
//                             ),
//                           );
//                     },
//                   ),
//                   SizedBox(height: designValues.medium),
//                   Text("Dialogue", style: textTheme.bodyMedium),
//                   SizedBox(height: designValues.small),
//                   // +++ NEW DIALOGUE INSPECTOR +++
//                   NovelDialogueInspector(
//                     currentDialogue: scenePart.dialogueBox,
//                     onChanged: (newDialogueBox) {
//                                  sceneGroup
//                           .update(sceneGroup.dialogueBoxes)
//                           .replace(
//                             FramesCompanion(

//                             ),
//                           );

//                       // ref
//                       //     .read(selectedSceneGroupProvider.notifier)
//                       //     .changeFrameDialogueBox(
//                       //       scenePartFullId,
//                       //       newDialogueBox,
//                       //     );
//                     },
//                   ),
//                 ] else ...[
//                   Text(
//                     "Select a Frame to inspect.",
//                     style: textTheme.bodyMedium,
//                   ),
//                 ],
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class NovelDialogueInspector extends HookWidget {
//   final DialogueBox? currentDialogue;
//   final ValueChanged<DialogueBox?> onChanged;

//   const NovelDialogueInspector({
//     super.key,
//     required this.currentDialogue,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final designValues = Theme.of(context).extension<DesignValues>()!;

//     final hasDialogueBox = currentDialogue != null;
//     final hasNameBox = currentDialogue?.name != null;

//     // We use controllers here so Riverpod rebuilds don't jump the cursor while typing.
//     final nameController = useTextEditingController(
//       text: currentDialogue?.name ?? "",
//     );
//     final dialogueController = useTextEditingController(
//       text: currentDialogue?.dialogue ?? "",
//     );

//     // Sync controllers if the user selects an entirely different frame
//     useEffect(() {
//       if (currentDialogue?.name != null &&
//           nameController.text != currentDialogue?.name) {
//         nameController.text = currentDialogue!.name!;
//       }
//       if (currentDialogue?.dialogue != null &&
//           dialogueController.text != currentDialogue?.dialogue) {
//         dialogueController.text = currentDialogue!.dialogue;
//       }
//       return null;
//     }, [currentDialogue]);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         SwitchListTile(
//           title: const Text("Enable Dialogue Box"),
//           contentPadding: EdgeInsets.zero,
//           value: hasDialogueBox,
//           onChanged: (enabled) {
//             if (enabled) {
//               // Initializes with no name box, and empty dialogue
//               onChanged(const DialogueBox(name: null, dialogue: ""));
//             } else {
//               // Entire dialogue box is disabled (null)
//               onChanged(null);
//             }
//           },
//         ),
//         if (hasDialogueBox) ...[
//           Card(
//             elevation: 0,
//             margin: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(
//               side: BorderSide(color: Theme.of(context).dividerColor),
//               borderRadius: BorderRadius.circular(designValues.small),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(designValues.small),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SwitchListTile(
//                     title: const Text("Show Speaker Name"),
//                     contentPadding: EdgeInsets.zero,
//                     value: hasNameBox,
//                     onChanged: (enabled) {
//                       if (enabled) {
//                         // Restore whatever was in the text controller, or default to ""
//                         onChanged(
//                           currentDialogue?.copyWith(name: nameController.text),
//                         );
//                       } else {
//                         // Remove the name box entirely (null)
//                         onChanged(currentDialogue?.copyWith(name: null));
//                       }
//                     },
//                   ),
//                   if (hasNameBox) ...[
//                     Text(
//                       "Speaker Name",
//                       style: Theme.of(context).textTheme.bodySmall,
//                     ),
//                     SizedBox(height: designValues.verySmall),
//                     TextField(
//                       controller: nameController,
//                       decoration: const InputDecoration(
//                         isDense: true,
//                         border: OutlineInputBorder(),
//                         hintText: "Enter name...",
//                       ),
//                       onChanged: (value) {
//                         onChanged(currentDialogue?.copyWith(name: value));
//                       },
//                     ),
//                     SizedBox(height: designValues.small),
//                   ],
//                   Text(
//                     "Dialogue Text",
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                   SizedBox(height: designValues.verySmall),
//                   TextField(
//                     controller: dialogueController,
//                     maxLines: 4,
//                     decoration: const InputDecoration(
//                       isDense: true,
//                       border: OutlineInputBorder(),
//                       hintText: "Enter dialogue...",
//                     ),
//                     onChanged: (value) {
//                       onChanged(currentDialogue?.copyWith(dialogue: value));
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ],
//     );
//   }
// }

// class NovelBackgroundInspector extends HookConsumerWidget {
//   final FullId<Background>? currentBackgroundId;
//   final ValueChanged<FullId<Background>> onChanged;

//   const NovelBackgroundInspector({
//     super.key,
//     required this.currentBackgroundId,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final designValues = Theme.of(context).extension<DesignValues>()!;

//     final currentBytes = ref.watch(
//       selectedSceneGroupProvider.select((group) {
//         final backgroundId = currentBackgroundId;

//         if (group == null || backgroundId == null) return null;
//         return group.backgroundPath(backgroundId).get(group)?.value.image;
//       }),
//     );

//     return InkWell(
//       borderRadius: BorderRadius.circular(designValues.small),
//       onTap: () => showDialog(
//         context: context,
//         builder: (context) => Consumer(
//           builder: (context, ref, child) {
//             final placesCollection = ref.watch(
//               selectedSceneGroupProvider.select((group) => group?.places),
//             );

//             if (placesCollection == null) return const SizedBox.shrink();

//             return NovelImageGroupEditor<Background>(
//               title: Text("Select Background"),
//               addParentLabel: Text("Add Place"),
//               emptySelectionLabel: Text("Select a Place"),
//               imageCollection: placesCollection,
//               currentSelectionId: currentBackgroundId,
//               onSelectionChanged: onChanged,
//               onImageCollectionEdited: (newCollection) => ref
//                   .read(selectedSceneGroupProvider.notifier)
//                   .updatePlaces(newCollection as Places),
//             );
//           },
//         ),
//       ),
//       child: Container(
//         height: 120,
//         width: double.infinity,
//         clipBehavior: Clip.antiAlias,
//         decoration: BoxDecoration(
//           border: Border.all(color: Theme.of(context).dividerColor),
//           borderRadius: BorderRadius.circular(designValues.small),
//         ),
//         child: currentBytes != null
//             ? Image.memory(currentBytes, fit: BoxFit.cover)
//             : const Center(child: Text("No Image")),
//       ),
//     );
//   }
// }
