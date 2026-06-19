import "package:drift/drift.dart";
import "package:drift/wasm.dart";
import "package:flutter/foundation.dart";
import "package:junction/junction.dart";
import "package:prac_res/core/database/data.dart";

typedef WebSceneGroupDetails = (WebStorageApi, CrossFilesystemName);

class WebSceneGroup {
  final Future<WebSceneGroupDetails> _webDetailsFuture;
  final SceneGroup sceneGroup;

  WebSceneGroup({
    required this.sceneGroup,
    required Future<WebSceneGroupDetails> webDetailsFuture,
  }) : _webDetailsFuture = webDetailsFuture;
}

class SceneGroupManager {
  SceneGroupManager._();

  static final Uri sqlite3Uri = Uri.parse("sqlite3.wasm");
  static final Uri driftWorkerUri = Uri.parse("drift_worker.js");

  static WebSceneGroup instance = SceneGroupBuilder._().empty(
    CrossFilesystemName("Untitled"),
  );

  static final Future<WasmProbeResult> probe = WasmDatabase.probe(
    sqlite3Uri: sqlite3Uri,
    driftWorkerUri: driftWorkerUri,
  );

  static Future<CrossFilesystemName> databaseDisplayName() async {
    final uniqueDatabaseNameParts = (await instance._webDetailsFuture).$2.split(
      "_",
    );

    return CrossFilesystemName(
      uniqueDatabaseNameParts
          .sublist(0, uniqueDatabaseNameParts.length - 1)
          .join("_"),
    );
  }

  // SAFETY: This also causes an
  // `InvalidStateError: Failed to read the 'error' property from 'IDBRequest': The request has not finished.`
  // which is probably safe to ignore? Fix this someday.
  static Future<SceneGroup> replace(
    WebSceneGroup Function(SceneGroupBuilder) replacer,
  ) async {
    final webDetails = await instance._webDetailsFuture;

    // Currently, something is making [close] hang when awaited.
    // Not sure what's causing it, but for now, I'm doing this so
    // that I'm still technically delete the database *once* it finishes closing.
    instance.sceneGroup.close().then((_) async {
      // SAFETY: This may seem unsafe, but this only deletes the copy of the database in OPFS. It doesn't delete the file its bytes were loaded from.
      // SAFETY: [webDetailsFuture] is an instance variable, not a static variable. This doesn't delete the current [instance]'s [webDetailsFuture].
      await (await probe).deleteDatabase(webDetails);
    });

    instance = replacer(SceneGroupBuilder._());

    // SAFETY: NOOP Just to ensure that the database is actually loaded.
    await instance.sceneGroup.customStatement("SELECT 1");

    return instance.sceneGroup;
  }

  static Future<Uint8List> toBytes() async {
    return (await (await probe).exportDatabase(
      await instance._webDetailsFuture,
    ))!;
  }
}

class SceneGroupBuilder {
  static int _uniqueId = 0;

  bool _used;

  SceneGroupBuilder._() : _used = false;

  WebSceneGroup _fromWasmDatabaseResult(
    CrossFilesystemName databaseDisplayName, {
    Uint8List? initialBytes,
  }) {
    if (_used) {
      throw StateError("You can only make one Database instance at a time!");
    }

    _used = true;

    final uniqueDatabaseName = CrossFilesystemName(
      "${databaseDisplayName}_$_uniqueId",
    );
    _uniqueId += 1;

    final resultFuture = WasmDatabase.open(
      databaseName: uniqueDatabaseName,
      sqlite3Uri: SceneGroupManager.sqlite3Uri,
      driftWorkerUri: SceneGroupManager.driftWorkerUri,
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

    return WebSceneGroup(
      sceneGroup: SceneGroup(DatabaseConnection.delayed(connectionFuture)),
      webDetailsFuture: webDetailsFuture,
    );
  }

  WebSceneGroup fromBytes(CrossFilesystemName databaseName, Uint8List bytes) {
    return _fromWasmDatabaseResult(databaseName, initialBytes: bytes);
  }

  WebSceneGroup empty(CrossFilesystemName databaseName) {
    return _fromWasmDatabaseResult(databaseName);
  }
}
