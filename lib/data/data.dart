import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

part 'data.g.dart';

/* -- Places & Backgrounds -- */

class Places extends Table {
  late final id = integer().autoIncrement()();
  late final name = text()();
}

class Backgrounds extends Table {
  late final id = integer().autoIncrement()();
  late final placeId = integer().references(
    Places,
    #id,
    onDelete: KeyAction.cascade,
  )();

  late final name = text()();
  late final imageData = blob()();
}

/* -- Actors & Poses -- */

class Actors extends Table {
  late final id = integer().autoIncrement()();
  late final name = text()();
}

class Poses extends Table {
  late final id = integer().autoIncrement()();
  late final actorId = integer().references(
    Actors,
    #id,
    onDelete: KeyAction.cascade,
  )();

  late final name = text()();
  late final imageData = blob()();
}

/* -- Choices & Options -- */

class Choices extends Table {
  late final id = integer().autoIncrement()();
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

class Scenes extends Table {
  late final id = integer().autoIncrement()();
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
    Backgrounds,
    #id,
    onDelete: KeyAction.setNull,
  )();

  @override
  Set<Column> get primaryKey => {scenePartId};
}

class FrameResolvers extends Table {
  late final scenePartId = integer().references(
    SceneParts,
    #id,
    onDelete: KeyAction.cascade,
  )();

  late final resolverScript = text()();

  @override
  Set<Column> get primaryKey => {scenePartId};
}

class Custom extends Table {
  late final scenePartId = integer().references(
    SceneParts,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final eventId = text()();

  @override
  Set<Column> get primaryKey => {scenePartId};
}

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
  late final poseId = integer().references(
    Poses,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final order = real()();
}

abstract class FramePosesView extends View {
  FramePoses get framePoses;
  Poses get poses;

  @override
  Query as() =>
      select([
        framePoses.id,
        framePoses.frameScenePartId,
        framePoses.poseId,
        framePoses.order,
        poses.actorId,
        poses.name,
        poses.imageData,
      ]).from(framePoses).join([
        innerJoin(poses, poses.id.equalsExp(framePoses.poseId)),
      ]);
}

abstract class SceneTimelineView extends View {
  SceneParts get sceneParts;
  Frames get frames;
  FrameResolvers get frameResolvers;
  Custom get custom;

  @override
  Query as() =>
      select([
        sceneParts.id,
        sceneParts.sceneId,
        sceneParts.order,
        sceneParts.partType,
        frames.backgroundId,
        frameResolvers.resolverScript,
        custom.eventId,
      ]).from(sceneParts).join([
        leftOuterJoin(frames, frames.scenePartId.equalsExp(sceneParts.id)),
        leftOuterJoin(
          frameResolvers,
          frameResolvers.scenePartId.equalsExp(sceneParts.id),
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
          FrameResolver(
            scenePartId: id,
            // SAFETY: This bang operator is safe because we know this is a resolver!
            resolverScript: entry.resolverScript!,
          ),
        ),

        'custom' => TimelineCustom(
          CustomData(
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
  final FrameResolver resolverData;
  TimelineResolver(this.resolverData);
}

class TimelineCustom extends SceneTimelineItemSpecifics {
  final CustomData customData;
  TimelineCustom(this.customData);
}

/* -- Database -- */

@DriftDatabase(
  tables: [
    Places,
    Backgrounds,
    Actors,
    Poses,
    Choices,
    ChoiceOptions,
    Scenes,
    SceneParts,
    Frames,
    FrameResolvers,
    Custom,
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
    // Currently, something is making [close] hang when awaited.
    // Not sure what's causing it, but for now, I'm doing this so
    // that I'm still technically delete the database *once* it finishes closing.
    close().then((_) async {
      // SAFETY: This may seem unsafe, but this only deletes the copy of the database in OPFS. It doesn't delete the file its bytes were loaded from.
      // SAFETY: [webDetailsFuture] is an instance variable, not a static variable. This doesn't delete the current [instance]'s [webDetailsFuture].
      await (await probe).deleteDatabase(await webDetailsFuture);
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
