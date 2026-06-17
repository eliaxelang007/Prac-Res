import 'package:drift/drift.dart';
import 'package:handy/handy.dart';
import 'data.steps.dart';

part 'data.g.dart';

abstract interface class GroupTable extends Table {
  Column<int> get id;
  Column<String> get name;
}

abstract interface class Group {
  int get id;
  String get name;
}

class GroupCompanion<T extends Group> extends UpdateCompanion<T> {
  final Value<int> id;
  final Value<String> name;

  const GroupCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });

  GroupCompanion.insert({this.id = const Value.absent(), required String name})
    : name = Value(name);

  static Insertable<T> custom<T>({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({'id': ?id, 'name': ?name});
  }

  GroupCompanion<T> copyWith({Value<int>? id, Value<String>? name}) {
    return GroupCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

abstract interface class ImageMetadataTable extends Table {
  Column<int> get id;
  Column<int> get groupId;
  Column<String> get name;
}

abstract interface class ImageMetadata {
  int get id;
  int get groupId;
  String get name;
}

class ImageMetadataCompanion<T extends ImageMetadata>
    extends UpdateCompanion<T> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<String> name;

  const ImageMetadataCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.name = const Value.absent(),
  });

  ImageMetadataCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    required String name,
  }) : groupId = Value(groupId),
       name = Value(name);

  static Insertable<T> custom<T>({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      'id': ?id,
      'group_id': ?groupId,
      'name': ?name,
    });
  }

  ImageMetadataCompanion<T> copyWith({
    Value<int>? id,
    Value<int>? groupId,
    Value<String>? name,
  }) {
    return ImageMetadataCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageMetadataCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

abstract interface class ImageDataTable extends Table {
  Column<int> get metadataId;
  Column<Uint8List> get imageData;
}

abstract interface class ImageData {
  int get metadataId;
  Uint8List get imageData;
}

class ImageDataCompanion<T extends ImageData> extends UpdateCompanion<T> {
  final Value<int> metadataId;
  final Value<Uint8List> imageData;
  const ImageDataCompanion({
    this.metadataId = const Value.absent(),
    this.imageData = const Value.absent(),
  });
  ImageDataCompanion.insert({
    this.metadataId = const Value.absent(),
    required Uint8List imageData,
  }) : imageData = Value(imageData);
  static Insertable<T> custom<T>({
    Expression<int>? metadataId,
    Expression<Uint8List>? imageData,
  }) {
    return RawValuesInsertable({
      'metadata_id': ?metadataId,
      'image_data': ?imageData,
    });
  }

  ImageDataCompanion<T> copyWith({
    Value<int>? metadataId,
    Value<Uint8List>? imageData,
  }) {
    return ImageDataCompanion(
      metadataId: metadataId ?? this.metadataId,
      imageData: imageData ?? this.imageData,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (metadataId.present) {
      map['metadata_id'] = Variable<int>(metadataId.value);
    }
    if (imageData.present) {
      map['image_data'] = Variable<Uint8List>(imageData.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageDataCompanion(')
          ..write('metadataId: $metadataId, ')
          ..write('imageData: $imageData')
          ..write(')'))
        .toString();
  }
}

class EquatableTableInfo<TableDsl extends Table, TableRow> {
  final TableInfo<TableDsl, TableRow> wrapped;

  EquatableTableInfo(this.wrapped);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EquatableTableInfo) return false;

    final otherWrapped = other.wrapped;

    // SAFETY: In TableInfo equality,
    // Drift assumes that you'll only have one database for the entire lifetime of the program.
    // In this app, multiple different databases can exist, but only one can exist at a time.
    // That's why we're also doing equality on the attached databases themselves (even if attachedDatabase is only supposed to be used internally).
    return wrapped == otherWrapped &&
        wrapped.attachedDatabase == // ignore: invalid_use_of_internal_member
            otherWrapped
                .attachedDatabase; // ignore: invalid_use_of_internal_member
  }

  @override
  // Excuse the use of the internal [attachedDatabase]! See the equality operator override for more details.
  int get hashCode => Object.hash(wrapped, wrapped.attachedDatabase); // ignore: invalid_use_of_internal_member
}

/* -- Places & Backgrounds -- */

@DataClassName("Place", implementing: [Group])
class Places extends GroupTable {
  @override
  late final id = integer().autoIncrement()();

  @override
  late final name = text()();
}

@DataClassName("BackgroundMetadata", implementing: [ImageMetadata])
class BackgroundMetadatas extends ImageMetadataTable {
  @override
  late final id = integer().autoIncrement()();

  @override
  late final groupId = integer().references(
    Places,
    #id,
    onDelete: KeyAction.cascade,
  )();

  @override
  late final name = text()();
}

@DataClassName("BackgroundImage", implementing: [ImageData])
class BackgroundImages extends ImageDataTable {
  @override
  late final metadataId = integer().references(
    BackgroundMetadatas,
    #id,
    onDelete: KeyAction.cascade,
  )();

  @override
  late final imageData = blob()();

  @override
  Set<Column> get primaryKey => {metadataId};
}

/* -- Actors & Poses -- */

@DataClassName("Actor", implementing: [Group])
class Actors extends GroupTable {
  @override
  late final id = integer().autoIncrement()();

  @override
  late final name = text()();
}

@DataClassName("PoseMetadata", implementing: [ImageMetadata])
class PoseMetadatas extends ImageMetadataTable {
  @override
  late final id = integer().autoIncrement()();

  @override
  late final groupId = integer().references(
    Actors,
    #id,
    onDelete: KeyAction.cascade,
  )();

  @override
  late final name = text()();
}

@DataClassName("PoseImage", implementing: [ImageData])
class PoseImages extends ImageDataTable {
  @override
  late final metadataId = integer().references(
    PoseMetadatas,
    #id,
    onDelete: KeyAction.cascade,
  )();

  @override
  late final imageData = blob()();

  @override
  Set<Column> get primaryKey => {metadataId};
}

/* -- Choices & Options -- */

class Choices extends Table {
  late final id = integer().autoIncrement()();
  late final name = text()();
}

@DataClassName("ChoiceOption", implementing: [Group])
@TableIndex.sql('''
  CREATE UNIQUE INDEX IF NOT EXISTS one_selected_per_choice 
  ON choice_options(choice_id) 
  WHERE is_selected = 1;
''')
class ChoiceOptions extends GroupTable {
  @override
  late final id = integer().autoIncrement()();
  late final choiceId = integer().references(
    Choices,
    #id,
    onDelete: KeyAction.cascade,
  )();

  @override
  late final name = text()();

  late final isSelected = boolean().withDefault(const Constant(false))();
}

/* -- Scenes -- */

@DataClassName("Scene", implementing: [Group])
class Scenes extends GroupTable {
  @override
  late final id = integer().autoIncrement()();

  @override
  late final name = text()();
}

enum ScenePartType {
  frame,
  resolver,
  custom;

  @override
  String toString() {
    return HandyEnum.staticToShortString(super.toString()).capitalize();
  }
}

class SceneParts extends Table {
  late final id = integer().autoIncrement()();
  late final sceneId = integer().references(
    Scenes,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final order = real()();
  late final TextColumn partType = text().check(
    partType.isIn(ScenePartType.values.map((value) => value.name)),
  )();
}

abstract interface class ScenePartSpecificsTable extends Table {
  Column<int> get scenePartId;
}

class Frames extends ScenePartSpecificsTable {
  @override
  late final scenePartId = integer().references(
    SceneParts,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final backgroundId = integer().nullable().references(
    BackgroundMetadatas,
    #id,
    onDelete: KeyAction.setNull,
  )();

  @override
  Set<Column> get primaryKey => {scenePartId};
}

class ScenePartResolvers extends ScenePartSpecificsTable {
  @override
  late final scenePartId = integer().references(
    SceneParts,
    #id,
    onDelete: KeyAction.cascade,
  )();

  late final dartResolverScript = text()();

  @override
  Set<Column> get primaryKey => {scenePartId};
}

class ResolverChoiceReference extends Table {
  late final id = integer().autoIncrement()();
  late final resolverScenePartId = integer().references(
    ScenePartResolvers,
    #scenePartId,
    onDelete: KeyAction.cascade,
  )();
  late final choiceId = integer().nullable().references(
    Choices,
    #id,
    onDelete: KeyAction.setNull,
  )();
  late final identifier = text()();
}

class ResolverScenePartReference extends Table {
  late final id = integer().autoIncrement()();
  late final resolverScenePartId = integer().references(
    ScenePartResolvers,
    #scenePartId,
    onDelete: KeyAction.cascade,
  )();
  late final scenePartId = integer().nullable().references(
    SceneParts,
    #id,
    onDelete: KeyAction.setNull,
  )();
  late final identifier = text()();
}

class CustomSceneParts extends ScenePartSpecificsTable {
  @override
  late final scenePartId = integer().references(
    SceneParts,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final eventId = text()();

  @override
  Set<Column> get primaryKey => {scenePartId};
}

@DataClassName("DialogueBox")
class DialogueBoxes extends Table {
  late final frameScenePartId = integer().references(
    Frames,
    #scenePartId,
    onDelete: KeyAction.cascade,
  )();
  late final name = text().nullable()();
  late final dialogue = text()();

  @override
  Set<Column> get primaryKey => {frameScenePartId};
}

class FrameChoices extends Table {
  late final frameScenePartId = integer().references(
    Frames,
    #scenePartId,
    onDelete: KeyAction.cascade,
  )();

  late final choiceId = integer().nullable().references(
    Choices,
    #id,
    onDelete: KeyAction.setNull,
  )();

  @override
  Set<Column> get primaryKey => {frameScenePartId};
}

class FramePoses extends Table {
  late final id = integer().autoIncrement()();
  late final frameScenePartId = integer().references(
    Frames,
    #scenePartId,
    onDelete: KeyAction.cascade,
  )();
  late final poseId = integer().nullable().references(
    PoseMetadatas,
    #id,
    onDelete: KeyAction.setNull,
  )();
  late final order = real()();
}

class SceneTimelineItem {
  final ScenePart part;
  final SceneTimelineItemSpecifics specifics;

  SceneTimelineItem({required this.part, required this.specifics});

  static SceneTimelineItem fromSceneTimelineViewData(
    SceneTimelineViewData entry,
  ) {
    final id = entry.id;
    final partType = entry.partType;

    return SceneTimelineItem(
      part: ScenePart(
        id: entry.id,
        sceneId: entry.sceneId,
        order: entry.order,
        partType: partType,
      ),
      specifics: switch (partType) {
        'frame' => TimelineFrame(
          Frame(scenePartId: id, backgroundId: entry.backgroundId),
        ),

        'resolver' => TimelineResolver(
          ScenePartResolver(
            scenePartId: id,
            // SAFETY: This bang operator is safe because we know this is a resolver!
            dartResolverScript: entry.dartResolverScript!,
          ),
        ),

        'custom' => TimelineCustom(
          CustomScenePart(
            scenePartId: entry.id,
            // SAFETY: This bang operator is safe because we know this is a custom event!
            eventId: entry.eventId!,
          ),
        ),

        _ => throw StateError("Invalid partType [$partType]!"),
      },
    );
  }
}

sealed class SceneTimelineItemSpecifics {}

class TimelineFrame extends SceneTimelineItemSpecifics {
  final Frame frameData;
  TimelineFrame(this.frameData);
}

class TimelineResolver extends SceneTimelineItemSpecifics {
  final ScenePartResolver resolverData;
  TimelineResolver(this.resolverData);
}

class TimelineCustom extends SceneTimelineItemSpecifics {
  final CustomScenePart customData;
  TimelineCustom(this.customData);
}

/* -- Database -- */

@DriftDatabase(
  tables: [
    Places,
    BackgroundMetadatas,
    BackgroundImages,
    Actors,
    PoseMetadatas,
    PoseImages,
    Choices,
    ChoiceOptions,
    FrameChoices,
    Scenes,
    SceneParts,
    Frames,
    ScenePartResolvers,
    ResolverChoiceReference,
    ResolverScenePartReference,
    CustomSceneParts,
    DialogueBoxes,
    FramePoses,
  ],
  include: {'views.drift'},
)
class SceneGroup extends _$SceneGroup {
  SceneGroup(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: stepByStep(
        from1To2: (migrator, schema) async {
          await migrator.createTable(schema.resolverChoiceReference);
          await migrator.createTable(schema.resolverScenePartReference);
        },
      ),
      onCreate: (migrator) async {
        await migrator.createAll();
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
