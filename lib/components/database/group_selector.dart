import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:prac_res/data/data.dart';
import 'package:prac_res/components/dialogs/deletion_dialog.dart';
import 'package:prac_res/components/editable_text.dart';
import 'package:prac_res/components/dialogs/new_name_dialog.dart';
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
    return NovelQueryBuilder(
      query: (ref) => ref.watch(
        groupsProvider(EquatableTableInfo(ref.watch(groupTableProvider))),
      ),
      builder: (context, ref, groups) {
        return NovelEditableRadioList(
          maybeTitle: title,
          groups: groups,
          onAdd: (name) async {
            final groupTable = ref.read(groupTableProvider);

            await groupTable.insert().insert(GroupCompanion.insert(name: name));
          },
          onChanged: onChanged,
          onDelete: (id) async {
            final groupTable = ref.read(groupTableProvider);

            await (groupTable.delete()
                  ..where((groupEntry) => groupEntry.id.equals(id)))
                .go();
          },
          onTileRename: (id, newName) async {
            final groupTable = ref.read(groupTableProvider);

            await (groupTable.update()
                  ..where((groupEntry) => groupEntry.id.equals(id)))
                .write(GroupCompanion(name: Value(newName)));
          },
          selectedRow: selectedGroup,
        );
      },
    );
  }
}

class NovelEditableRadioList<G extends Group> extends StatelessWidget {
  const NovelEditableRadioList({
    super.key,
    this.maybeTitle,
    required this.onChanged,
    required this.onTileRename,
    required this.onDelete,
    required this.onAdd,
    required this.selectedRow,
    required this.groups,
  });

  final void Function(int?) onChanged;
  final void Function(int id, String newName) onTileRename;
  final void Function(int id) onDelete;
  final void Function(String name) onAdd;
  final int? selectedRow;
  final List<G> groups;
  final Widget? maybeTitle;

  @override
  Widget build(BuildContext context) {
    final title = maybeTitle;
    final textTheme = Theme.of(context).textTheme;

    return RadioGroup<int>(
      onChanged: onChanged,
      groupValue: selectedRow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            DefaultTextStyle.merge(child: title, style: textTheme.bodyLarge),
            const Divider(),
          ],

          for (final group in groups)
            ListTile(
              leading: Radio<int>(value: group.id, toggleable: true),
              title: NovelEditableText(
                sourceText: group.name,
                builder: (context, controller, focusNode) => TextField(
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller,
                  onChanged: (newName) => onTileRename(group.id, newName),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  final answer = await NovelDeletionDialog.show(context);

                  if (answer != true) return;

                  onDelete(group.id);
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

                onAdd(name);
              },
              icon: Icon(Icons.add_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
