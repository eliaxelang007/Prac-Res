import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/components/dialogs/deletion_dialog.dart';
import 'package:prac_res/components/editable_text.dart';
import 'package:prac_res/components/dialogs/new_name_dialog.dart';
import 'package:prac_res/components/lists/scrolling.dart';
import 'package:prac_res/components/database/query_builder.dart';

class NovelGroupSelector<G extends Group> extends StatelessWidget {
  final Widget title;
  final ProviderListenable<TableInfo<GroupTable, G>> groupTableProvider;
  final void Function(int?) onChanged;
  final int? selectedGroup;

  static final groupsProvider =
      StreamProvider.family<List<Group>, EquatableTableInfo<GroupTable, Group>>(
        (ref, equatableWrapper) {
          return equatableWrapper.wrapped.select().watch();
        },
      );

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
        query: (ref) => ref.watch(
          groupsProvider(EquatableTableInfo(ref.watch(groupTableProvider))),
        ),
        builder: (context, ref, groups) {
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
