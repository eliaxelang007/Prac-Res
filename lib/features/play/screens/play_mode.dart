import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/stdlib/core.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/widgets/database/query_builder.dart';
import 'package:prac_res/core/widgets/fitted_icon.dart';
import 'package:prac_res/features/editor/screens/editor_page.dart';
import 'package:prac_res/features/scene_viewer/widgets/selected_scene_part.dart';

extension ScenePartResolverResolve on ScenePartResolver {
  Future<SceneTimelineItem?> resolve(SceneGroup sceneGroup) async {
    final selectedOptions =
        await (sceneGroup.choiceOptions.select()
              ..orderBy([(u) => OrderingTerm(expression: u.id)])
              ..where((t) => t.isSelected.equals(true)))
            .get();

    final resolvedScenePartId =
        eval(
              "int resolve(Map<dynamic, dynamic> choiceIdToSelectedId) {$dartResolverScript}",
              function: "resolve",
              args: [
                $Map.wrap({
                  for (var option in selectedOptions)
                    $int(option.choiceId): $int(option.id),
                }),
              ],
            )
            as int;

    final scenePart =
        (await (sceneGroup.sceneTimelineView.select()..where(
                  (scenePartEntry) =>
                      scenePartEntry.id.equals(resolvedScenePartId),
                ))
                .getSingleOrNull())
            ?.intoSceneTimelineItem();

    if (scenePart == null) {
      debugPrint("No scene part found!");
    }

    return scenePart;
  }
}

class PlayingScenePartNotifier extends AsyncNotifier<SceneTimelineItem?> {
  @override
  Future<SceneTimelineItem?> build() async {
    final selectedScenePart = ref.watch(
      NovelSelectedScenePart.selectedScenePartProvider,
    );

    if (selectedScenePart != null) {
      return selectedScenePart;
    }

    final sceneGroup = ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider);

    final firstScene =
        await (sceneGroup.sceneTimelineView.select()
              ..orderBy([
                (u) => OrderingTerm(expression: u.sceneId),
                (u) => OrderingTerm(expression: u.order),
              ])
              ..limit(1))
            .getSingleOrNull();

    if (firstScene == null) return null;

    return SceneTimelineItem.fromSceneTimelineViewData(firstScene);
  }

  Future<void> next() async {
    final sceneGroup = ref.read(NovelSceneGroupEditorPage.sceneGroupProvider);
    final playingScenePart = await future;

    // This must mean there are no scenes in the scene group at all, right?
    if (playingScenePart == null) return;

    final nextScenePart =
        (await (sceneGroup.sceneTimelineView.select()
                  ..where(
                    (entry) =>
                        entry.sceneId.equals(playingScenePart.part.sceneId),
                  )
                  ..where(
                    (entry) => entry.order.isBiggerThanValue(
                      playingScenePart.part.order,
                    ),
                  )
                  ..orderBy([(u) => OrderingTerm(expression: u.order)])
                  ..limit(1))
                .getSingleOrNull())
            ?.intoSceneTimelineItem();

    if (nextScenePart == null) return;

    final resolvedNextScenePart = switch (nextScenePart.specifics) {
      TimelineResolver(:final resolverData) => await resolverData.resolve(
        sceneGroup,
      ),
      _ => nextScenePart,
    };

    ref
        .read(NovelSelectedScenePart.selectedScenePartProvider.notifier)
        .set(resolvedNextScenePart);
  }
}

final playingScenePartProvider =
    AsyncNotifierProvider<PlayingScenePartNotifier, SceneTimelineItem?>(
      PlayingScenePartNotifier.new,
    );

class NovelPlayMode extends StatelessWidget {
  const NovelPlayMode({super.key});

  // static final playingScenePartProvider = FutureProvider<SceneTimelineItem?>((ref) async {
  //   final selectedScenePart = ref.watch(NovelSelectedScenePart.selectedScenePartProvider);
  // });

  //   if (selectedScenePart != null) {
  //     return selectedScenePart;
  //   }

  //   final sceneGroup = ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider);

  //   final firstScene =    await   (sceneGroup.sceneTimelineView.select()
  //       ..orderBy([
  //         (u) => OrderingTerm(expression: u.sceneId),
  //         (u) => OrderingTerm(expression: u.order),
  //       ])).getSingleOrNull() ;

  //   return  ?? SceneTimelineItem.fromSceneTimelineViewData(

  //   );
  // });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) => ref.watch(playingScenePartProvider),
      builder: (context, ref, selectedScenePart) {
        return HookBuilder(
          builder: (context) {
            useEffect(() {
              bool handleGlobalKeyEvent(KeyEvent keyEvent) {
                if (keyEvent is KeyDownEvent) {
                  if (keyEvent.logicalKey == LogicalKeyboardKey.arrowRight) {
                    ref.read(playingScenePartProvider.notifier).next();
                  }
                }

                return false;
              }

              ServicesBinding.instance.keyboard.addHandler(
                handleGlobalKeyEvent,
              );

              return () {
                ServicesBinding.instance.keyboard.removeHandler(
                  handleGlobalKeyEvent,
                );
              };
            }, []);

            // TODO: fix

            final scenePart = selectedScenePart?.specifics;

            return SizedBox.expand(
              child: (scenePart != null)
                  ? NovelScenePartPreview(specifics: scenePart)
                  : NovelFittedIcon(
                      icon: Icon(Icons.image_not_supported_rounded),
                      sizePercentage: 0.5,
                    ),
            );
          },
        );
      },
    );
  }
}
