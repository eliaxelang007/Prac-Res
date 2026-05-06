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
}

class BackgroundImages extends Table {
  late final backgroundId = integer().references(
    Backgrounds,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final imageData = blob()();

  @override
  Set<Column> get primaryKey => {backgroundId};
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
}

class PoseImages extends Table {
  late final poseId = integer().references(
    Poses,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final imageData = blob()();

  @override
  Set<Column> get primaryKey => {poseId};
}

/* -- Choices & Options -- */

class Choices extends Table {
  late final id = integer().autoIncrement()();
  late final name = text()();
}

@TableIndex.sql('''
  CREATE UNIQUE INDEX one_selected_per_choice 
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
  late final frameId = integer().references(
    Frames,
    #scenePartId,
    onDelete: KeyAction.cascade,
  )();
  late final name = text().nullable()();
  late final dialogue = text()();

  @override
  Set<Column> get primaryKey => {frameId};
}

class FramePoses extends Table {
  late final id = integer().autoIncrement()();
  late final frameId = integer().references(
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

/* -- Database -- */

@DriftDatabase(
  tables: [
    Places,
    Backgrounds,
    BackgroundImages,
    Actors,
    Poses,
    PoseImages,
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
  views: [SceneTimelineView],
)
class SceneGroup extends _$SceneGroup {
  final ExistingDatabase webDetails;

  SceneGroup._(this.webDetails, super.e);

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

  static Future<SceneGroup> _fromWasmDatabaseResult(
    String databaseName,
    WasmDatabaseResult result,
  ) async {
    if (result.missingFeatures.isNotEmpty) {
      // ignore: avoid_print
      print(
        'Using ${result.chosenImplementation} due to missing browser '
        'features: ${result.missingFeatures}',
      );
    }

    final storageApi = result.chosenImplementation.storageApi;

    if (storageApi == null) {
      throw StateError(
        "We can't export this database to bytes because the browser its running on doesn't support a valid storage API!",
      );
    }

    return SceneGroup._((storageApi, databaseName), result.resolvedExecutor);
  }

  static Future<SceneGroup> fromBytes(
    String databaseName,
    Uint8List bytes,
  ) async {
    return _fromWasmDatabaseResult(
      databaseName,
      await WasmDatabase.open(
        databaseName: databaseName,
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
        initializeDatabase: () => bytes,
      ),
    );
  }

  static Future<SceneGroup> empty(String databaseName) async {
    return _fromWasmDatabaseResult(
      databaseName,
      await WasmDatabase.open(
        databaseName: databaseName,
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
      ),
    );
  }

  Future<Uint8List> toBytes() async {
    final probe = await WasmDatabase.probe(
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );

    // The bang operator here should be safe because the web details are attached to [this] database.
    return (await probe.exportDatabase(webDetails))!;
  }
}

class SceneTimelineItem {
  final ScenePart part;
  final SceneTimelineItemData specifics;

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

sealed class SceneTimelineItemData {}

class TimelineFrame extends SceneTimelineItemData {
  final Frame frameData;
  TimelineFrame(this.frameData);
}

class TimelineResolver extends SceneTimelineItemData {
  final FrameResolver resolverData;
  TimelineResolver(this.resolverData);
}

class TimelineCustom extends SceneTimelineItemData {
  final CustomData customData;
  TimelineCustom(this.customData);
}
