// import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:prac_res/data/data.dart';
// import 'package:prac_res/pages/design_values.dart';
// import 'package:prac_res/pages/editor/editor_state.dart';
// import 'package:prac_res/pages/frame/frame.dart';
// import 'package:prac_res/pages/open.dart';

class NovelScenePartTimeline extends StatelessWidget {
  const NovelScenePartTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// class NovelScenePartTimeline extends ConsumerWidget {
//   const NovelScenePartTimeline({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final selectedScene = ref.watch(selectedSceneProvider);

//     // final scene = ref.watch(
//     //   selectedSceneGroupProvider.select((sceneGroup) {
//     //     return sceneGroup
//     //         ?.select(sceneGroup.scenes)
//     //         .where((scene) => scene.id.equals(selectedScene));
//     //   }),
//     // );

//     // final selectedScenePart = ref.watch(selectedScenePartProvider);

//     // final scenePart =
//     // final sceneParts = scene?.value.entries.toList();

//     // sceneParts?.sort((a, b) => a.value.order.compareTo(b.value.order));

//     final sceneGroup = ref.watch(selectedSceneGroupProvider);

//     final selectedScenePart = ref.watch(selectedScenePartProvider);

//     if (selectedScenePart == null) {
//       return const Placeholder(child: Text("sceneGroup == null"));
//     }

//     final scenePart =
//         (sceneGroup.sceneTimelineView.select()
//               ..where((scenePart) => scenePart.id.equals(selectedScenePart)))
//             .getSingleOrNull();

//     final selectedScene = ref.watch(selectedSceneProvider);

//     if (selectedScene == null) {
//       return const Placeholder(child: Text("selectedScene == null"));
//     }

//     final sceneParts =
//         (sceneGroup.sceneTimelineView.select()
//               ..where((scenePart) => scenePart.sceneId.equals(selectedScene))
//               ..orderBy([
//                 (u) => OrderingTerm.asc(sceneGroup.sceneTimelineView.order),
//               ]))
//             .get();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Expanded(
//           flex: 5,
//           child: Center(
//             child: Padding(
//               padding: EdgeInsets.all(DesignValues.veryLarge),
//               child: FutureBuilder(
//                 future: scenePart,
//                 builder: (context, asyncSnapshot) {
//                   if (!asyncSnapshot.hasData) {
//                     return Placeholder(child: Text("scenePart !hasData"));
//                   }

//                   final maybeFrame = asyncSnapshot.data;

//                   if (maybeFrame == null) {
//                     return Placeholder(child: Text("maybeFrame == null"));
//                   }

//                   final timelineItem =
//                       SceneTimelineItem.fromSceneTimelineViewData(
//                         maybeFrame,
//                       ).specifics;

//                   if (timelineItem is! TimelineFrame) {
//                     return Placeholder(
//                       child: Text("timelineItem is! TimelineFrame"),
//                     );
//                   }

//                   return NovelFrame(frame: timelineItem.frameData);
//                 },
//               ),
//             ),
//           ),
//         ),
//         const Divider(),
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.all(DesignValues.small),
//             child: FutureBuilder(
//               future: sceneParts,
//               builder: (context, asyncSnapshot) {
//                 if (!asyncSnapshot.hasData) {
//                   return Placeholder(child: Text("sceneParts !hasData"));
//                 }

//                 final maybeParts = asyncSnapshot.data
//                     ?.map(
//                       (part) =>
//                           SceneTimelineItem.fromSceneTimelineViewData(part),
//                     )
//                     .toList();

//                 if (maybeParts == null) {
//                   return Placeholder(child: Text("maybeParts == null"));
//                 }

//                 return Row(
//                   spacing: DesignValues.medium,
//                   children: [
//                     ...[
//                       for (final orderedPart in maybeParts)
//                         NovelScenePartPreview(orderedPart: orderedPart),
//                       IconButton(
//                         onPressed: () async {
//                           sceneGroup
//                               .into(sceneGroup.sceneParts)
//                               .insert(
//                                 ScenePartsCompanion.insert(
//                                   sceneId: selectedScene,
//                                   order: maybeParts.lastOrNull?.part.order ?? 0,
//                                   partType: "frame",
//                                 ),
//                               );
//                         },
//                         icon: const Icon(Icons.add_rounded),
//                       ),
//                     ],
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class NovelScenePartPreview extends ConsumerWidget {
//   final SceneTimelineItem orderedPart;

//   const NovelScenePartPreview({super.key, required this.orderedPart});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final sceneGroup = ref.watch(selectedSceneGroupProvider);
//     final selectedPartId = ref.watch(selectedScenePartProvider);
//     final selectedScene = ref.watch(selectedSceneProvider);

//     final scenePartId = orderedPart.part.id;
//     final isSelected = selectedPartId == scenePartId;
//     final scenePart = orderedPart.specifics;

//     final preview = Padding(
//       padding: EdgeInsets.all(DesignValues.verySmall),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(DesignValues.small),
//         child: Stack(
//           children: [
//             (scenePart is TimelineFrame)
//                 ? AspectRatio(
//                     aspectRatio: 16 / 9,
//                     child: NovelFrame(frame: scenePart.frameData),
//                   )
//                 : const Icon(Icons.alt_route_rounded),
//             Positioned.fill(
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   onTap: () {
//                     ref
//                         .read(selectedScenePartProvider.notifier)
//                         .set(isSelected ? null : scenePartId);
//                   },
//                 ),
//               ),
//             ),

//             Positioned.fill(
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () async {
//                     if (selectedScene == null) return;

//                     final answer = await NovelDeletionDialog.show(context);

//                     if (answer != true) return;

//                     final sceneGroup = ref.read(selectedSceneGroupProvider);

//                     sceneGroup.sceneParts.delete().where(
//                       (scenePart) => scenePart.id.equals(scenePartId),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

//     return isSelected
//         ? DecoratedBox(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(
//                 DesignValues.small * (1 + DesignValues.semiSmallPercent),
//               ),
//               border: Border.all(
//                 width: 2,
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//             child: preview,
//           )
//         : preview;
//   }
// }
