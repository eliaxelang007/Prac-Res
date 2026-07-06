import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/features/play/screens/play_mode.dart';
import 'package:prac_res/features/scene_viewer/widgets/frame.dart';

/// A data class to hold the state of each interactive cooking item.
/// The ID has been factored out to act as the key in the IMap.
class CookingItem {
  final Offset position;

  /// Replaced `color` and `size` with a function that returns a Widget.
  final WidgetBuilder builder;

  CookingItem({required this.position, required this.builder});

  /// Helpful for updating state immutably when you start moving them around.
  CookingItem copyWith({Offset? position, WidgetBuilder? builder}) {
    return CookingItem(
      position: position ?? this.position,
      builder: builder ?? this.builder,
    );
  }
}

bool isPointInPolygon(Offset point, List<Offset> polygon) {
  int intersections = 0;
  int verticesCount = polygon.length;

  for (int i = 0; i < verticesCount; i++) {
    Offset v1 = polygon[i];
    Offset v2 =
        polygon[(i + 1) % verticesCount]; // Wrap around to the first vertex

    // Check if the ray intersects the edge between v1 and v2
    if (((v1.dy > point.dy) != (v2.dy > point.dy)) &&
        (point.dx <
            (v2.dx - v1.dx) * (point.dy - v1.dy) / (v2.dy - v1.dy) + v1.dx)) {
      intersections++;
    }
  }
  return intersections % 2 != 0;
}

class NovelCookingMinigame1 extends StatelessWidget {
  const NovelCookingMinigame1({super.key});

  @override
  Widget build(BuildContext context) {
    return NovelFrameFit(
      child: HookBuilder(
        builder: (context) {
          final tapAreaKey = useMemoized(() => GlobalKey());

          // 1. Initialize the state using an IMap for fast immutable updates
          final cookingItems = useState<IMap<int, CookingItem>>(
            IMap({
              1: CookingItem(
                position: const Offset(205, 136),
                builder: (context) => ColoredBox(
                  color: Colors.transparent.withAlpha((255 * 0.5).toInt()),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset("assets/kitchen_assets/ground_beef.png"),
                  ),
                ),
              ),
              2: CookingItem(
                position: const Offset(202, 271),
                builder: (context) => ColoredBox(
                  color: Colors.transparent.withAlpha((255 * 0.5).toInt()),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      "assets/kitchen_assets/parmesan_cheese.png",
                    ),
                  ),
                ),
              ),
              3: CookingItem(
                position: const Offset(542, 264),
                builder: (context) => ColoredBox(
                  color: Colors.transparent.withAlpha((255 * 0.5).toInt()),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset("assets/kitchen_assets/salt_shaker.png"),
                  ),
                ),
              ),
              4: CookingItem(
                position: const Offset(376, 246),
                builder: (context) => ColoredBox(
                  color: Colors.transparent.withAlpha((255 * 0.5).toInt()),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset("assets/kitchen_assets/olive_oil.png"),
                  ),
                ),
              ),
              5: CookingItem(
                position: const Offset(407, 237),
                builder: (context) => ColoredBox(
                  color: Colors.transparent.withAlpha((255 * 0.5).toInt()),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      "assets/kitchen_assets/tomato_sauce.png",
                    ),
                  ),
                ),
              ),
              6: CookingItem(
                position: const Offset(405, 200),
                builder: (context) => ColoredBox(
                  color: Colors.transparent.withAlpha((255 * 0.5).toInt()),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset("assets/kitchen_assets/wheat.png"),
                  ),
                ),
              ),
            }),
          );

          return NovelFrameSafeArea(
            child: Consumer(
              builder: (context, ref, _) {
                return Stack(
                  key: tapAreaKey,
                  children: [
                    Positioned.fill(
                      child: Image.asset("assets/backgrounds/kitchen_all.jpg"),
                    ),

                    // 2. Iterate over the IMap entries
                    ...cookingItems.value.entries.map((entry) {
                      final id = entry.key;
                      final item = entry.value;

                      return Positioned(
                        key: ValueKey(
                          id,
                        ), // Using the map key helps Flutter efficiently rebuild items
                        top: item.position.dy,
                        left: item.position.dx,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            final RenderBox tapAreaBox =
                                tapAreaKey.currentContext!.findRenderObject()
                                    as RenderBox;

                            final Offset tapAreaLocalPosition = tapAreaBox
                                .globalToLocal(details.globalPosition);

                            final key = entry.key;

                            final item = cookingItems.value.get(key);

                            if (item == null) {
                              debugPrint("$key was null.");
                              return;
                            }

                            cookingItems.value = cookingItems.value.add(
                              key,
                              item.copyWith(position: tapAreaLocalPosition),
                            );
                          },
                          onPanEnd: (_) async {
                            final a = [
                              const Offset(
                                171.34918505509717,
                                329.19327983668336,
                              ),
                              const Offset(
                                518.0600802378246,
                                248.6774699084324,
                              ),
                              const Offset(
                                639.6553911677377,
                                289.7569709100943,
                              ),
                              const Offset(
                                639.6553911677377,
                                289.7569709100943,
                              ),
                              const Offset(
                                509.8441574718552,
                                359.5920887644643,
                              ),
                              const Offset(
                                143.41514543522823,
                                358.7705115316252,
                              ),
                            ];

                            bool allDone = true;

                            for (final item in cookingItems.value.entries) {
                              allDone =
                                  allDone &&
                                  isPointInPolygon(item.value.position, a);

                              if (!allDone) {
                                break;
                              }
                            }

                            if (allDone) {
                              await ref
                                  .read(playingScenePartProvider.notifier)
                                  .next();
                            }
                          },
                          // 3. Render the dynamic widget instead of a ColoredBox
                          child: item.builder(context),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class NovelCookingMinigame2 extends StatelessWidget {
  const NovelCookingMinigame2({super.key});

  @override
  Widget build(BuildContext context) {
    return NovelFrameFit(
      child: HookBuilder(
        builder: (context) {
          return NovelFrameSafeArea(
            child: Consumer(
              builder: (context, ref, _) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset("assets/cooking_minigame/pot.png"),
                    ),
                    Positioned(
                      left: 295,
                      top: 34.0,
                      child: GestureDetector(
                        onTap: () async {
                          await ref
                              .read(playingScenePartProvider.notifier)
                              .next();
                        },
                        child: ColoredBox(
                          color: Colors.transparent.withAlpha(
                            (255 * 0.3).toInt(),
                          ),
                          child: SizedBox(width: 26, height: 40),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class NovelCookingMinigame3 extends StatelessWidget {
  const NovelCookingMinigame3({super.key});

  @override
  Widget build(BuildContext context) {
    return NovelFrameFit(
      child: HookBuilder(
        builder: (context) {
          final tapAreaKey = useMemoized(() => GlobalKey());

          // 1. Initialize the state using an IMap for fast immutable updates
          final cookingItems = useState<IMap<int, CookingItem>>(
            IMap({
              1: CookingItem(
                position: const Offset(641.3, 50.7),
                builder: (context) => ColoredBox(
                  color: Colors.transparent.withAlpha((255 * 0.5).toInt()),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset("assets/kitchen_assets/salt_shaker.png"),
                  ),
                ),
              ),
            }),
          );

          return NovelFrameSafeArea(
            child: Consumer(
              builder: (context, ref, _) {
                return Stack(
                  key: tapAreaKey,
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        "assets/cooking_minigame/pot_with_water.png",
                      ),
                    ),

                    // 2. Iterate over the IMap entries
                    ...cookingItems.value.entries.map((entry) {
                      final id = entry.key;
                      final item = entry.value;

                      return Positioned(
                        key: ValueKey(
                          id,
                        ), // Using the map key helps Flutter efficiently rebuild items
                        top: item.position.dy,
                        left: item.position.dx,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            final RenderBox tapAreaBox =
                                tapAreaKey.currentContext!.findRenderObject()
                                    as RenderBox;

                            final Offset tapAreaLocalPosition = tapAreaBox
                                .globalToLocal(details.globalPosition);

                            final key = entry.key;

                            final item = cookingItems.value.get(key);

                            if (item == null) {
                              debugPrint("$key was null.");
                              return;
                            }

                            cookingItems.value = cookingItems.value.add(
                              key,
                              item.copyWith(position: tapAreaLocalPosition),
                            );
                          },
                          onPanEnd: (_) async {
                            final a = [
                              const Offset(250.2, 178.0),
                              const Offset(359.5, 171.4),
                              const Offset(362.8, 284.8),
                              const Offset(240.4, 298.0),
                            ];

                            bool allDone = true;

                            for (final item in cookingItems.value.entries) {
                              allDone =
                                  allDone &&
                                  isPointInPolygon(item.value.position, a);

                              if (!allDone) {
                                break;
                              }
                            }

                            if (allDone) {
                              await ref
                                  .read(playingScenePartProvider.notifier)
                                  .next();
                            }
                          },
                          // 3. Render the dynamic widget instead of a ColoredBox
                          child: item.builder(context),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class NovelPreCookingMinigame4 extends StatelessWidget {
  const NovelPreCookingMinigame4({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return HookBuilder(
          builder: (context) {
            useEffect(() {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref.read(firstTimeState.notifier).state = true;
                ref.read(isOvercookedState.notifier).state = false;
                ref.read(timeLeftState.notifier).state = 60;

                ref.read(playingScenePartProvider.notifier).next();
              });

              return null;
            }, []);

            return SizedBox.shrink();
          },
        );
      },
    );
  }
}

final firstTimeState = StateProvider<bool>((ref) => true);
final isOvercookedState = StateProvider<bool>((ref) => false);
final timeLeftState = StateProvider<int>((ref) => 60);

class NovelCookingMinigame4 extends StatelessWidget {
  const NovelCookingMinigame4({super.key});

  @override
  Widget build(BuildContext context) {
    return NovelFrameFit(
      child: Consumer(
        builder: (context, ref, _) {
          return HookBuilder(
            builder: (context) {
              final sauceController = useAnimationController(
                duration: Duration(seconds: 10),
              );

              final spaghettiController = useAnimationController(
                duration: Duration(seconds: 40),
              );

              final isDone = useState(false);

              useEffect(() {
                sauceController.forward(
                  from: ref.read(isOvercookedState) ? 0.9 : 0,
                );

                final double timeProgress =
                    ((60 - ref.read(timeLeftState)) / 40).clamp(0, 1);

                print("me $timeProgress");
                spaghettiController.forward(from: timeProgress);

                void sauceListener(state) {
                  if (state == AnimationStatus.completed) {
                    ref.read(isOvercookedState.notifier).state = true;
                  }
                }

                sauceController.addStatusListener(sauceListener);

                void spaghettiListener(state) {
                  // if (state == AnimationStatus.completed) {
                  //   isDone.value = true;
                  // }
                }

                spaghettiController.addStatusListener(spaghettiListener);

                return () {
                  sauceController.removeStatusListener(sauceListener);
                  spaghettiController.removeStatusListener(spaghettiListener);
                  sauceController.stop();
                  spaghettiController.stop();
                };
              }, []);

              final saucePercentage = useAnimation(
                Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                    parent: sauceController,
                    curve: Curves.linear,
                  ),
                ),
              );

              final spaghettiPercentage = useAnimation(
                Tween<double>(begin: 1, end: 0).animate(
                  CurvedAnimation(
                    parent: spaghettiController,
                    curve: Curves.easeInOutQuart,
                  ),
                ),
              );

              useEffect(() {
                final timer = Timer.periodic(const Duration(seconds: 1), (
                  timer,
                ) {
                  final timeLeft = ref.read(timeLeftState);

                  if (timeLeft <= 0) {
                    timer.cancel();
                    ref.read(playingScenePartProvider.notifier).next();
                    return;
                  }

                  if (timeLeft <= 30 && ref.read(firstTimeState)) {
                    timer.cancel();
                    ref.read(playingScenePartProvider.notifier).next();
                    ref.read(firstTimeState.notifier).state = false;
                    return;
                  }

                  ref.read(timeLeftState.notifier).state -= 1;
                });

                return () {
                  timer.cancel();
                };
              }, []);

              final textTheme = Theme.of(context).textTheme;

              final secondsLeft = ref.watch(timeLeftState);
              final minutes = (secondsLeft ~/ 60).toString().padLeft(2, '0');
              final seconds = (secondsLeft % 60).toString().padLeft(2, '0');

              return NovelFrameSafeArea(
                child: Stack(
                  children: [
                    NovelCookingMinigame4a(
                      saucePercentage: saucePercentage,
                      spaghettiPercentage: spaghettiPercentage,
                      spaghettiOffStove: isDone.value,
                    ),

                    Positioned(
                      top: 30,
                      left: 130,
                      child: Text(
                        "$minutes:$seconds",
                        style: textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Positioned(
                      top: 160,
                      left: 230,
                      child: GestureDetector(
                        onTap: () {
                          if (!ref.read(isOvercookedState.notifier).state) {
                            sauceController.forward(from: 0);
                          }
                        },
                        child: ColoredBox(
                          color: Colors.transparent,
                          child: SizedBox(width: 150, height: 190),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 160,
                      left: 230 + 150 + 30,
                      child: GestureDetector(
                        onTap: () {
                          if (secondsLeft <= 20) {
                            isDone.value = true;
                          }
                        },
                        child: ColoredBox(
                          color: Colors.transparent,
                          child: SizedBox(width: 150, height: 190),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NovelCookingMinigame4a extends StatelessWidget {
  const NovelCookingMinigame4a({
    super.key,
    required this.saucePercentage,
    required this.spaghettiPercentage,
    required this.spaghettiOffStove,
  });

  final double saucePercentage;
  final double spaghettiPercentage;
  final bool spaghettiOffStove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset("assets/cooking_minigame/stove.png"),
        ),

        Positioned(
          top: 50,
          left: 170,
          child: Stack(
            children: [
              RotatedBox(
                quarterTurns: 1,
                child: SizedBox(
                  height: 280,
                  // width: 200,
                  child: Image.asset(
                    "assets/cooking_minigame/sauce.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Opacity(
                opacity: saucePercentage,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: SizedBox(
                    height: 280,
                    child: Image.asset(
                      "assets/cooking_minigame/sauce_burnt.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!spaghettiOffStove)
          Positioned(
            top: 0,
            left: 355,
            child: Stack(
              children: [
                RotatedBox(
                  quarterTurns: 1,
                  child: SizedBox(
                    height: 260,
                    // width: 200,
                    child: Image.asset(
                      "assets/cooking_minigame/spaghetti_cooked.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),

                Opacity(
                  opacity: spaghettiPercentage,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: SizedBox(
                      height: 260,
                      // width: 200,
                      child: Image.asset(
                        "assets/cooking_minigame/spaghetti.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

final secondsElapsedState = StateProvider<int>((ref) => 0);

class NovelCookingMinigame5 extends StatelessWidget {
  const NovelCookingMinigame5({super.key});

  @override
  Widget build(BuildContext context) {
    return NovelFrameFit(
      child: Consumer(
        builder: (context, ref, child) {
          return HookBuilder(
            builder: (context) {
              useEffect(() {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(secondsElapsedState.notifier).state = 0;
                });

                final timer = Timer.periodic(const Duration(seconds: 1), (_) {
                  ref.read(secondsElapsedState.notifier).state++;
                });

                return () {
                  timer.cancel();
                };
              }, []);

              final secondsElapsed = ref.watch(secondsElapsedState);

              final minutes = (secondsElapsed ~/ 60).toString().padLeft(2, '0');
              final seconds = (secondsElapsed % 60).toString().padLeft(2, '0');

              final textTheme = Theme.of(context).textTheme;

              return NovelFrameSafeArea(
                child: Consumer(
                  builder: (context, ref, _) {
                    return GestureDetector(
                      onTap: () async {
                        await ref
                            .read(playingScenePartProvider.notifier)
                            .next();
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              "assets/cooking_minigame/stove.png",
                            ),
                          ),

                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Click anywhere to continue cooking!",
                                  style: textTheme.headlineMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "$minutes:$seconds",
                                  style: textTheme.headlineLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
