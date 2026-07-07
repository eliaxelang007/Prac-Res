import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junction/junction.dart';
import 'package:prac_res/core/database/web.dart';
import 'package:prac_res/core/theme/design_values.dart';
import 'package:prac_res/core/widgets/editable_text.dart';
import 'package:prac_res/core/widgets/fitted_icon.dart';
import 'package:prac_res/core/widgets/outlined_button.dart';
import 'package:prac_res/features/editor/widgets/scene_selector.dart';
import 'package:prac_res/features/play/screens/play_mode.dart';
import 'package:prac_res/features/scene_viewer/widgets/frame.dart';

class NovelMainMenu extends StatelessWidget {
  const NovelMainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: HookBuilder(
          builder: (context) {
            final futureData = useMemoized(() {
              final computeSceneGroup = compute((selected) async {
                final file = await rootBundle.load("assets/game.novel");

                return await SceneGroupManager.replace((replacer) {
                  return replacer.fromBytes(
                    CrossFilesystemName("game.novel"),
                    file.buffer.asUint8List(),
                  );
                });
              }, null);

              return computeSceneGroup;
            }, []);

            // 3. Listen to the future
            final snapshot = useFuture(futureData);

            final a = Consumer(
              builder: (context, ref, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: DesignValues.large,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sociolingo",
                          style: textTheme.headlineLarge?.copyWith(
                            fontSize: 60,
                          ),
                        ),
                        Text(
                          "Development and Evaluation of a Gamified ASD Symptoms Screening System",
                          style: textTheme.titleMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      child: NovelEditableText(
                        builder: (context, controller, focusNode) {
                          return TextField(
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              hintText: "What would you like to be called?",
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(),
                            ),
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            controller: controller,
                            onChanged: (newName) => ref
                                .read(templaterProvider.notifier)
                                .add("y_n", newName),
                          );
                        },
                        sourceText: ref.watch(templaterProvider)["y_n"] ?? "",
                      ),
                    ),
                    Row(
                      spacing: DesignValues.large,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: DesignValues.veryLarge * 2,
                          height: DesignValues.veryLarge * 2,
                          child: NovelOutlinedButton(
                            onPressed: () {
                              ref
                                  .read(
                                    NovelSceneSelector
                                        .selectedSceneIdProvider
                                        .notifier,
                                  )
                                  .set(1);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NovelPlayModeRoute(),
                                ),
                              );
                            },
                            child: Image.asset(
                              "assets/characters_transparent_backgrounds/thomas_talk.png",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: DesignValues.veryLarge * 2,
                          height: DesignValues.veryLarge * 2,
                          child: NovelOutlinedButton(
                            onPressed: () {
                              ref
                                  .read(
                                    NovelSceneSelector
                                        .selectedSceneIdProvider
                                        .notifier,
                                  )
                                  .set(2);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NovelPlayModeRoute(),
                                ),
                              );
                            },
                            child: Image.asset(
                              "assets/characters_transparent_backgrounds/laila_happy.png",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: DesignValues.veryLarge * 2,
                          height: DesignValues.veryLarge * 2,
                          child: NovelOutlinedButton(
                            onPressed: () {
                              ref
                                  .read(
                                    NovelSceneSelector
                                        .selectedSceneIdProvider
                                        .notifier,
                                  )
                                  .set(3);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NovelPlayModeRoute(),
                                ),
                              );
                            },
                            child: Image.asset(
                              "assets/characters_transparent_backgrounds/mom_happy.png",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: DesignValues.veryLarge * 2,
                          height: DesignValues.veryLarge * 2,
                          child: NovelOutlinedButton(
                            onPressed: () {
                              ref
                                  .read(
                                    NovelSceneSelector
                                        .selectedSceneIdProvider
                                        .notifier,
                                  )
                                  .set(4);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NovelPlayModeRoute(
                                    backButtonColor: Colors.black,
                                  ),
                                ),
                              );
                            },
                            child: NovelFittedIcon(
                              icon: Icon(Icons.table_chart_rounded),
                              sizePercentage: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );

            if (snapshot.hasData) {
              return a;
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class NovelPlayModeRoute extends StatelessWidget {
  final Color backButtonColor;

  const NovelPlayModeRoute({super.key, this.backButtonColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Consumer(
          builder: (context, ref, child) {
            return BackButton(
              color: backButtonColor,
              onPressed: () {
                ref.read(playingHistoryProvider.notifier).reset();
                Navigator.maybePop(context);
              },
            );
          },
        ),
      ),
      body: NovelPlayMode(),
    );
  }
}
