import 'package:device_frame/device_frame.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/design_values.dart';
import 'package:prac_res/pages/editor/scene_selector.dart';
import 'package:prac_res/pages/frame/frame.dart';
import 'package:prac_res/pages/open.dart';

class SelectedScenePartIdProvider extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? id) {
    state = id;
  }
}

final selectedScenePartIdProvider =
    NotifierProvider<SelectedScenePartIdProvider, int?>(
      SelectedScenePartIdProvider.new,
    );

class NovelSceneViewer extends StatelessWidget {
  const NovelSceneViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(DesignValues.veryLarge),
              child: NovelSelectedScenePart(),
            ),
          ),
        ),
        const Divider(),
        Expanded(child: NovelScenePartTimeline()),
      ],
    );
  }
}

class NovelSelectedScenePart extends StatelessWidget {
  const NovelSelectedScenePart({super.key});

  static final selectedScenePartProvider = StreamProvider<SceneTimelineItem?>((
    ref,
  ) {
    final sceneGroup = ref.watch(sceneGroupProvider);
    final selectedScenePartId = ref.watch(selectedScenePartIdProvider);

    return (selectedScenePartId != null)
        ? (sceneGroup.sceneTimelineView.select()..where(
                (scenePart) => scenePart.id.equals(selectedScenePartId),
              ))
              .watchSingleOrNull()
              .map(
                (selectedScenePart) => (selectedScenePart != null)
                    ? SceneTimelineItem.fromSceneTimelineViewData(
                        selectedScenePart,
                      )
                    : null,
              )
        : Stream.value(null);
  });

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      provider: (_) => selectedScenePartProvider,
      builder: (context, ref, selectedScenePart) => (selectedScenePart != null)
          ? DeviceFrame(
              device: Devices.android.bigPhone,
              screen: Stack(
                children: [
                  Positioned.fill(child: ColoredBox(color: Colors.white)),
                  Positioned.fill(
                    child: NovelScenePartPreview(
                      specifics: selectedScenePart.specifics,
                    ),
                  ),
                ],
              ),
              orientation: Orientation.landscape,
            )
          : SizedBox.shrink(),
    );
  }
}

class NovelScenePartTimeline extends StatelessWidget {
  const NovelScenePartTimeline({super.key});

  static final sceneProvider =
      StreamProvider.family<List<SceneTimelineItem>, int>((ref, sceneId) {
        final sceneGroup = ref.watch(sceneGroupProvider);

        return (sceneGroup.sceneTimelineView.select()
              ..where((scenePart) => scenePart.sceneId.equals(sceneId))
              ..orderBy([(scenePart) => OrderingTerm.asc(scenePart.order)]))
            .watch()
            .map(
              (sceneTimeline) => sceneTimeline
                  .map(
                    (scenePart) =>
                        SceneTimelineItem.fromSceneTimelineViewData(scenePart),
                  )
                  .toList(),
            );
      });

  static final selectedSceneProvider = FutureProvider<List<SceneTimelineItem>?>(
    (ref) async {
      final selectedSceneId = ref.watch(selectedSceneIdProvider);

      return (selectedSceneId != null)
          ? ref.watch(sceneProvider(selectedSceneId).future)
          : null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return NovelQueryBuilder(
      provider: (_) => selectedSceneProvider,
      builder: (context, ref, sceneParts) {
        if (sceneParts == null) return SizedBox.shrink();

        final scenePartCount = sceneParts.length;

        return HookBuilder(
          builder: (context) {
            final controller = useScrollController();

            return Scrollbar(
              controller: controller,
              child: ReorderableListView.builder(
                scrollController: controller,
                onReorderItem: (oldIndex, newIndex) async {
                  final double newOrder;

                  if ((newIndex + 1) == scenePartCount) {
                    newOrder = (sceneParts.lastOrNull?.part.order ?? -1) + 1;
                  } else if (newIndex == 0) {
                    newOrder = (sceneParts.firstOrNull?.part.order ?? 1) + -1;
                  } else {
                    final leftIndex =
                        newIndex - ((oldIndex > newIndex) ? 1 : 0);
                    final rightIndex = leftIndex + 1;

                    final beforeOrder = sceneParts[leftIndex].part.order;
                    final afterOrder = sceneParts[rightIndex].part.order;

                    newOrder = (beforeOrder + afterOrder) / 2;
                  }

                  final sceneGroup = ref.read(sceneGroupProvider);

                  await (sceneGroup.sceneParts.update()..where(
                        (scenePart) =>
                            scenePart.id.equals(sceneParts[oldIndex].part.id),
                      ))
                      .write(ScenePartsCompanion(order: Value(newOrder)));
                },
                scrollDirection: Axis.horizontal,
                footer: AspectRatio(
                  aspectRatio: 1,
                  child: IconButton(
                    onPressed: () async {
                      final selectedSceneId = ref.read(selectedSceneIdProvider);

                      if (selectedSceneId == null) return;

                      final sceneGroup = ref.read(sceneGroupProvider);

                      await sceneGroup.sceneParts.insert().insert(
                        ScenePartsCompanion.insert(
                          sceneId: selectedSceneId,
                          order: (sceneParts.lastOrNull?.part.order ?? -1) + 1,
                          partType: "frame",
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_rounded),
                  ),
                ),
                itemCount: scenePartCount,
                itemBuilder: (context, index) {
                  final scenePart = sceneParts[index];

                  return NovelSceneTimelineItem(
                    key: ValueKey(scenePart.part.id),
                    scenePart: scenePart,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class NovelSceneTimelineItem extends StatelessWidget {
  final SceneTimelineItem scenePart;

  const NovelSceneTimelineItem({super.key, required this.scenePart});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedScenePartId = ref.watch(selectedScenePartIdProvider);

        final scenePartId = scenePart.part.id;
        final isSelected = scenePartId == selectedScenePartId;

        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              Positioned.fill(
                child: NovelCard(
                  isSelected: isSelected,
                  onTap: () {
                    ref
                        .read(selectedScenePartIdProvider.notifier)
                        .set(isSelected ? null : scenePartId);
                  },
                  child: NovelScenePartPreview(specifics: scenePart.specifics),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final answer = await NovelDeletionDialog.show(context);

                      if (answer != true) return;

                      final sceneGroup = ref.read(sceneGroupProvider);

                      await (sceneGroup.sceneParts.delete()..where(
                            (scenePart) => scenePart.id.equals(scenePartId),
                          ))
                          .go();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class NovelCard extends StatelessWidget {
  final bool isSelected;
  final Widget child;
  final void Function()? onTap;

  const NovelCard({
    super.key,
    required this.child,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).colorScheme.onPrimaryContainer;

    final cardBuilder = (isSelected) ? Card.outlined : Card.new;
    final shape = (isSelected)
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignValues.small),
            side: BorderSide(width: 3.0, color: selectedColor),
          )
        : null;

    return cardBuilder(
      shape: shape,
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(child: child),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: onTap),
            ),
          ),
        ],
      ),
    );
  }
}

class NovelScenePartPreview extends StatelessWidget {
  final SceneTimelineItemSpecifics specifics;

  const NovelScenePartPreview({super.key, required this.specifics});

  @override
  Widget build(BuildContext context) {
    return switch (specifics) {
      TimelineFrame(:final frameData) => NovelFrame(frame: frameData),
      TimelineResolver() => NovelFittedIcon(
        icon: Icon(Icons.alt_route_rounded),
        sizePercentage: 0.5,
      ),
      TimelineCustom() => NovelFittedIcon(
        icon: Icon(Icons.build_circle_rounded),
        sizePercentage: 0.5,
      ),
    };
  }
}

class NovelFittedIcon extends StatelessWidget {
  final Widget icon;
  final BoxFit fit;
  final double sizePercentage;

  const NovelFittedIcon({
    super.key,
    required this.icon,
    required this.sizePercentage,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    const double kArbitrarySize = 500;

    return FittedBox(
      fit: fit,
      child: SizedBox(
        width: kArbitrarySize,
        height: kArbitrarySize,
        child: Center(
          child: IconTheme(
            data: Theme.of(
              context,
            ).iconTheme.copyWith(size: kArbitrarySize * sizePercentage),
            child: icon,
          ),
        ),
      ),
    );
  }
}
