import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/pages/editor/inspector/image_group.dart';
import 'package:prac_res/pages/editor/scene_viewer.dart';
import 'package:prac_res/pages/editor/scrolling.dart';
import 'package:prac_res/pages/frame/frame.dart';
import 'package:prac_res/pages/open.dart';

class SelectedSceneIdProvider extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? id) {
    state = id;
    ref.read(selectedScenePartIdProvider.notifier).set(null);
  }
}

final selectedSceneIdProvider = NotifierProvider<SelectedSceneIdProvider, int?>(
  SelectedSceneIdProvider.new,
);

class NovelSceneSelector extends StatelessWidget {
  const NovelSceneSelector({super.key});

  static final scenesTableProvider = Provider<$ScenesTable>((ref) {
    final sceneGroup = ref.watch(sceneGroupProvider);

    return sceneGroup.scenes;
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return NovelGroupSelector(
          title: Text("Scenes"),
          onChanged: (selection) {
            ref.read(selectedSceneIdProvider.notifier).set(selection);
          },
          groupTableProvider: scenesTableProvider,
          selectedGroup: ref.watch(selectedSceneIdProvider),
        );
      },
    );
  }
}

class NovelGroupSelector<G extends Group> extends StatelessWidget {
  final Widget title;
  final ProviderListenable<TableInfo<GroupTable, G>> groupTableProvider;
  final void Function(int?) onChanged;
  final int? selectedGroup;

  const NovelGroupSelector({
    super.key,
    required this.title,
    required this.onChanged,
    required this.groupTableProvider,
    required this.selectedGroup,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RadioGroup<int>(
      onChanged: onChanged,
      groupValue: selectedGroup,
      child: NovelQueryBuilder(
        provider: (ref) =>
            groupsProvider(EquatableTableInfo(ref.watch(groupTableProvider))),
        builder: (context, ref, groups) {
          // final table = ref.watch(groupTableProvider);

          return SingleChildScrollbarView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle.merge(
                  child: title,
                  style: textTheme.bodyLarge,
                ),

                const Divider(),

                for (final group in groups)
                  ListTile(
                    leading: Radio<int>(value: group.id, toggleable: true),
                    title: NovelEditableText(
                      sourceText: group.name,
                      builder: (controller, focusNode) => TextField(
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
                          final groupTable = ref.read(groupTableProvider);

                          await (groupTable.update()..where(
                                (groupEntry) => groupEntry.id.equals(group.id),
                              ))
                              .write(GroupCompanion(name: Value(newName)));
                        },
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        final answer = await NovelDeletionDialog.show(context);

                        if (answer != true) return;

                        final groupTable = ref.read(groupTableProvider);

                        await (groupTable.delete()..where(
                              (groupEntry) => groupEntry.id.equals(group.id),
                            ))
                            .go();
                      },
                    ),
                  ),

                ListTile(
                  leading: IconButton(
                    onPressed: () async {
                      final name = await NovelNewNameDialog.show(
                        context,
                        title: "New Group",
                      );

                      if (name == null) {
                        return;
                      }

                      final groupTable = ref.read(groupTableProvider);

                      await groupTable.insert().insert(
                        GroupCompanion.insert(name: name),
                      );
                    },
                    icon: Icon(Icons.add_rounded),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
