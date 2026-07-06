import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/stdlib/core.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/core/database/data.dart';
import 'package:prac_res/core/widgets/database/query_builder.dart';
import 'package:prac_res/core/widgets/fitted_icon.dart';
import 'package:prac_res/features/editor/screens/editor_page.dart';
import 'package:prac_res/features/editor/widgets/scene_selector.dart';
import 'package:prac_res/features/scene_viewer/widgets/selected_scene_part.dart';

extension ScenePartResolverResolve on ScenePartResolver {
  Future<SceneTimelineItem?> resolve(SceneGroup sceneGroup) async {
    final selectedOptions =
        await (sceneGroup.choiceOptions.select()
              ..orderBy([(u) => OrderingTerm(expression: u.id)])
              ..where((t) => t.isSelected.equals(true)))
            .get();

    final int resolvedScenePartId;

    try {
      resolvedScenePartId =
          eval(
                "int resolve(Map<int, int> choiceIdToSelectedId) {$dartResolverScript}",
                function: "resolve",
                args: [
                  $Map.wrap({
                    for (var option in selectedOptions)
                      $int(option.choiceId): $int(option.id),
                  }),
                ],
              )
              as int;
    } catch (error) {
      debugPrint(
        "Something went wrong while trying to resolve the scene part ID!\n$error",
      );
      return null;
    }

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

class PlayingHistoryNotifier extends Notifier<IList<ScenePart>> {
  @override
  IList<ScenePart> build() {
    return IList();
  }

  void reset() {
    state = IList();
  }

  void push(ScenePart visited) {
    state = state.add(visited);
  }

  ScenePart? pop() {
    final last = state.lastOrNull;

    if (last == null) return last;

    state = state.removeLast();

    return last;
  }
}

final playingHistoryProvider =
    NotifierProvider<PlayingHistoryNotifier, IList<ScenePart>>(
      PlayingHistoryNotifier.new,
    );

class PlayingScenePartNotifier extends AsyncNotifier<SceneTimelineItem?> {
  @override
  Future<SceneTimelineItem?> build() async {
    final selectedScenePart = await ref.watch(
      NovelSelectedScenePart.selectedScenePartProvider.future,
    );

    if (selectedScenePart != null) {
      return selectedScenePart;
    }

    final sceneGroup = ref.watch(NovelSceneGroupEditorPage.sceneGroupProvider);

    final query = sceneGroup.sceneTimelineView.select();

    final scene = ref.watch(NovelSceneSelector.selectedSceneIdProvider);

    if (scene != null) {
      query.where((scenePartEntry) => scenePartEntry.sceneId.equals(scene));
    }

    final firstScene =
        await (query
              ..orderBy([
                (u) => OrderingTerm(expression: u.sceneId),
                (u) => OrderingTerm(expression: u.order),
              ])
              ..limit(1))
            .getSingleOrNull();

    if (firstScene == null) return null;

    return SceneTimelineItem.fromSceneTimelineViewData(firstScene);
  }

  void back() {
    final notifier = ref.read(playingHistoryProvider.notifier);
    final previous = notifier.pop();

    if (previous == null) return;

    ref
        .read(NovelSceneSelector.selectedSceneIdProvider.notifier)
        .set(previous.sceneId);
    ref
        .read(NovelSelectedScenePart.selectedScenePartIdProvider.notifier)
        .set(previous.id);
  }

  Future<void> next() async {
    final sceneGroup = ref.read(NovelSceneGroupEditorPage.sceneGroupProvider);
    final playingScenePart = await future;

    // This must mean there are no scenes in the scene group at all, right?
    if (playingScenePart == null) return;

    ref.read(playingHistoryProvider.notifier).push(playingScenePart.part);

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

    if (resolvedNextScenePart == null) return;

    final part = resolvedNextScenePart.part;

    ref
        .read(NovelSceneSelector.selectedSceneIdProvider.notifier)
        .set(part.sceneId);
    ref
        .read(NovelSelectedScenePart.selectedScenePartIdProvider.notifier)
        .set(part.id);
  }
}

final playingScenePartProvider =
    AsyncNotifierProvider<PlayingScenePartNotifier, SceneTimelineItem?>(
      PlayingScenePartNotifier.new,
    );

class NovelPlayMode extends StatelessWidget {
  const NovelPlayMode({super.key});

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      query: (ref) => ref.watch(playingScenePartProvider),
      builder: (context, ref, selectedScenePart) {
        return HookBuilder(
          builder: (context) {
            useEffect(() {
              bool handleGlobalKeyEvent(KeyEvent keyEvent) {
                ref.read(playingScenePartProvider.future).then((
                  sceneTimelineItem,
                ) async {
                  if (sceneTimelineItem?.specifics is TimelineCustom) {
                    return false;
                  }

                  if (keyEvent is KeyDownEvent) {
                    final logicalKey = keyEvent.logicalKey;
                    final playingScenePart = ref.read(
                      playingScenePartProvider.notifier,
                    );

                    if (logicalKey == LogicalKeyboardKey.arrowRight) {
                      await playingScenePart.next();
                    }

                    if (logicalKey == LogicalKeyboardKey.arrowLeft) {
                      playingScenePart.back();
                    }
                  }
                });

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

            final scenePart = selectedScenePart?.specifics;

            return SizedBox.expand(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: (scenePart != null)
                        ? NovelScenePartPreview(
                            specifics: scenePart,
                            showCustom: true,
                          )
                        : NovelFittedIcon(
                            icon: Icon(Icons.image_not_supported_rounded),
                            sizePercentage: 0.5,
                          ),
                  ),
                  if (scenePart is! TimelineCustom)
                    Positioned.fill(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: SizedBox.expand(),
                              onTap: () {
                                ref
                                    .read(playingScenePartProvider.notifier)
                                    .back();
                              },
                            ),
                          ),
                          Expanded(flex: 3, child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: SizedBox.expand(),
                              onTap: () async {
                                await ref
                                    .read(playingScenePartProvider.notifier)
                                    .next();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
