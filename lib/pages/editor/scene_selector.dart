// import 'package:drift/drift.dart' hide Column;
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:prac_res/data/data.dart';
// import 'package:prac_res/pages/design_values.dart';
// import 'package:prac_res/pages/editor/editor_state.dart';
// import 'package:prac_res/pages/frame/frame.dart';
// import 'package:prac_res/pages/open.dart';

import 'package:flutter/material.dart';

class NovelSceneSelector extends StatelessWidget {
  const NovelSceneSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// class NovelSceneSelector extends ConsumerWidget {
//   const NovelSceneSelector({super.key});

//   static final scenesProvider = StreamProvider((ref) {
//     final sceneGroup = ref.watch(selectedSceneGroupProvider);

//     return sceneGroup.scenes.select().watch();
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = Theme.of(context);
//     final textTheme = theme.textTheme;

//     final selectedScene = ref.watch(selectedSceneProvider);

//     return Padding(
//       padding: EdgeInsets.all(DesignValues.small),
//       child: RadioGroup<int>(
//         onChanged: (selection) {
//           ref.read(selectedSceneProvider.notifier).set(selection);
//         },
//         groupValue: selectedScene,
//         child: NovelQueryBuilder(
//           provider: scenesProvider,
//           builder: (scenes) => Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Scenes", style: textTheme.bodyLarge),
//               const Divider(),

//               ...scenes.map(
//                 (scene) => RadioListTile(
//                   value: scene.id,
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(scene.name, style: textTheme.bodyMedium),
//                       IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: () async {
//                           final answer = await NovelDeletionDialog.show(
//                             context,
//                           );

//                           if (answer != true) return;

//                           final sceneGroup = ref.read(
//                             selectedSceneGroupProvider,
//                           );

//                           sceneGroup
//                               .delete(sceneGroup.scenes)
//                               .where(
//                                 (sceneEntry) => sceneEntry.id.equals(scene.id),
//                               );
//                         },
//                       ),
//                     ],
//                   ),
//                   toggleable: true,
//                 ),
//               ),

//               IconButton(
//                 onPressed: () async {
//                   final sceneName = await NovelNewNameDialog.show(
//                     context,
//                     title: "New Scene",
//                   );

//                   if (sceneName == null) {
//                     return;
//                   }

//                   final sceneGroup = ref.read(selectedSceneGroupProvider);

//                   sceneGroup
//                       .into(sceneGroup.scenes)
//                       .insert(ScenesCompanion.insert(name: sceneName));
//                 },
//                 icon: const Icon(Icons.add_rounded),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
