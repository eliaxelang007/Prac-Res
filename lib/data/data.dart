import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

part 'data.g.dart';

/* -- Data Shapes -- */

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

class Choices extends GroupTable {
  @override
  late final id = integer().autoIncrement()();

  @override
  late final name = text()();
}

@TableIndex.sql('''
  CREATE UNIQUE INDEX IF NOT EXISTS one_selected_per_choice 
  ON choice_options(choice_id) 
  WHERE is_selected = 1;
''')
class ChoiceOptions extends Table {
  late final id = integer().autoIncrement()();
  late final choiceId = integer().references(
    Choices,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final optionText = text()();

  late final IntColumn isSelected = integer()
      .withDefault(const Constant(0))
      .check(isSelected.isIn([0, 1]))();
}

/* -- Scenes -- */

@DataClassName("Scene", implementing: [Group])
class Scenes extends GroupTable {
  @override
  late final id = integer().autoIncrement()();

  @override
  late final name = text()();
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
    partType.isIn(["frame", "resolver", "custom"]),
  )();
}

class Frames extends Table {
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

class ScenePartResolvers extends Table {
  late final scenePartId = integer().references(
    SceneParts,
    #id,
    onDelete: KeyAction.cascade,
  )();

  late final resolverScript = text()();

  @override
  Set<Column> get primaryKey => {scenePartId};
}

class CustomSceneParts extends Table {
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

abstract class FramePosesView extends View {
  FramePoses get framePoses;
  PoseMetadatas get poses;

  @override
  Query as() =>
      select([
        framePoses.id,
        framePoses.frameScenePartId,
        framePoses.poseId,
        framePoses.order,
        poses.groupId,
        poses.name,
      ]).from(framePoses).join([
        innerJoin(poses, poses.id.equalsExp(framePoses.poseId)),
      ]);
}

abstract class SceneTimelineView extends View {
  SceneParts get sceneParts;
  Frames get frames;
  ScenePartResolvers get scenePartResolvers;
  CustomSceneParts get custom;

  @override
  Query as() =>
      select([
        sceneParts.id,
        sceneParts.sceneId,
        sceneParts.order,
        sceneParts.partType,
        frames.backgroundId,
        scenePartResolvers.resolverScript,
        custom.eventId,
      ]).from(sceneParts).join([
        leftOuterJoin(frames, frames.scenePartId.equalsExp(sceneParts.id)),
        leftOuterJoin(
          scenePartResolvers,
          scenePartResolvers.scenePartId.equalsExp(sceneParts.id),
        ),
        leftOuterJoin(custom, custom.scenePartId.equalsExp(sceneParts.id)),
      ]);
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
            resolverScript: entry.resolverScript!,
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
    Scenes,
    SceneParts,
    Frames,
    ScenePartResolvers,
    CustomSceneParts,
    DialogueBoxes,
    FramePoses,
  ],
  views: [SceneTimelineView, FramePosesView],
)
class SceneGroup extends _$SceneGroup {
  final Future<ExistingDatabase> webDetailsFuture;

  static final Uri sqlite3Uri = Uri.parse("sqlite3.wasm");
  static final Uri driftWorkerUri = Uri.parse("drift_worker.js");

  static SceneGroup instance = SceneGroupBuilder._().empty("Untitled");

  static final Future<WasmProbeResult> probe = WasmDatabase.probe(
    sqlite3Uri: sqlite3Uri,
    driftWorkerUri: driftWorkerUri,
  );

  Future<String> databaseDisplayName() async {
    final uniqueDatabaseNameParts = (await webDetailsFuture).$2.split("_");

    return uniqueDatabaseNameParts
        .sublist(0, uniqueDatabaseNameParts.length - 1)
        .join("_");
  }

  // SAFETY: This also causes an
  // `InvalidStateError: Failed to read the 'error' property from 'IDBRequest': The request has not finished.`
  // which is probably safe to ignore? Fix this someday.
  Future<SceneGroup> replace(
    SceneGroup Function(SceneGroupBuilder) replacer,
  ) async {
    final webDetails = await webDetailsFuture;

    // Currently, something is making [close] hang when awaited.
    // Not sure what's causing it, but for now, I'm doing this so
    // that I'm still technically delete the database *once* it finishes closing.
    close().then((_) async {
      // SAFETY: This may seem unsafe, but this only deletes the copy of the database in OPFS. It doesn't delete the file its bytes were loaded from.
      // SAFETY: [webDetailsFuture] is an instance variable, not a static variable. This doesn't delete the current [instance]'s [webDetailsFuture].
      await (await probe).deleteDatabase(webDetails);
    });

    instance = replacer(SceneGroupBuilder._());

    // SAFETY: NOOP Just to ensure that the database is actually loaded.
    await instance.customStatement("SELECT 1");

    return instance;
  }

  SceneGroup._(this.webDetailsFuture, super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<Uint8List> toBytes() async {
    return (await (await probe).exportDatabase(await webDetailsFuture))!;
  }
}

class SceneGroupBuilder {
  static int _uniqueId = 0;

  bool _used;

  SceneGroupBuilder._() : _used = false;

  SceneGroup _fromWasmDatabaseResult(
    String databaseDisplayName, {
    Uint8List? initialBytes,
  }) {
    if (_used) {
      throw StateError("You can only make one Database instance at a time!");
    }

    _used = true;

    final uniqueDatabaseName = "${databaseDisplayName}_$_uniqueId";
    _uniqueId += 1;

    final resultFuture = WasmDatabase.open(
      databaseName: uniqueDatabaseName,
      sqlite3Uri: SceneGroup.sqlite3Uri,
      driftWorkerUri: SceneGroup.driftWorkerUri,
      initializeDatabase: (initialBytes != null) ? (() => initialBytes) : null,
    );

    final connectionFuture = resultFuture.then((result) {
      if (result.missingFeatures.isNotEmpty) {
        debugPrint(
          'Using ${result.chosenImplementation} due to missing browser '
          'features: ${result.missingFeatures}',
        );
      }
      return result.resolvedExecutor;
    });

    final webDetailsFuture = resultFuture.then((result) {
      final storageApi = result.chosenImplementation.storageApi;
      if (storageApi == null) {
        throw StateError(
          "We can't export this database to bytes because the browser its running on doesn't support a valid storage API!",
        );
      }
      return (storageApi, uniqueDatabaseName);
    });

    return SceneGroup._(
      webDetailsFuture,
      DatabaseConnection.delayed(connectionFuture),
    );
  }

  SceneGroup fromBytes(String databaseName, Uint8List bytes) {
    return _fromWasmDatabaseResult(databaseName, initialBytes: bytes);
  }

  SceneGroup empty(String databaseName) {
    return _fromWasmDatabaseResult(databaseName);
  }
}
