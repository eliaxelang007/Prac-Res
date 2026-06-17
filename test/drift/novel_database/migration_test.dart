// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:prac_res/data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = SceneGroup(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  // The following template shows how to write tests ensuring your migrations
  // preserve existing data.
  // Testing this can be useful for migrations that change existing columns
  // (e.g. by alterating their type or constraints). Migrations that only add
  // tables or columns typically don't need these advanced tests. For more
  // information, see https://drift.simonbinder.eu/migrations/tests/#verifying-data-integrity
  // TODO: This generated template shows how these tests could be written. Adopt
  // it to your own needs when testing migrations with data integrity.
  test('migration from v1 to v2 does not corrupt data', () async {
    // Add data to insert into the old database, and the expected rows after the
    // migration.
    // TODO: Fill these lists
    final oldScenesData = <v1.ScenesData>[];
    final expectedNewScenesData = <v2.ScenesData>[];

    final oldScenePartsData = <v1.ScenePartsData>[];
    final expectedNewScenePartsData = <v2.ScenePartsData>[];

    final oldPlacesData = <v1.PlacesData>[];
    final expectedNewPlacesData = <v2.PlacesData>[];

    final oldBackgroundMetadatasData = <v1.BackgroundMetadatasData>[];
    final expectedNewBackgroundMetadatasData = <v2.BackgroundMetadatasData>[];

    final oldFramesData = <v1.FramesData>[];
    final expectedNewFramesData = <v2.FramesData>[];

    final oldScenePartResolversData = <v1.ScenePartResolversData>[];
    final expectedNewScenePartResolversData = <v2.ScenePartResolversData>[];

    final oldCustomScenePartsData = <v1.CustomScenePartsData>[];
    final expectedNewCustomScenePartsData = <v2.CustomScenePartsData>[];

    final oldActorsData = <v1.ActorsData>[];
    final expectedNewActorsData = <v2.ActorsData>[];

    final oldPoseMetadatasData = <v1.PoseMetadatasData>[];
    final expectedNewPoseMetadatasData = <v2.PoseMetadatasData>[];

    final oldFramePosesData = <v1.FramePosesData>[];
    final expectedNewFramePosesData = <v2.FramePosesData>[];

    final oldChoicesData = <v1.ChoicesData>[];
    final expectedNewChoicesData = <v2.ChoicesData>[];

    final oldFrameChoicesData = <v1.FrameChoicesData>[];
    final expectedNewFrameChoicesData = <v2.FrameChoicesData>[];

    final oldBackgroundImagesData = <v1.BackgroundImagesData>[];
    final expectedNewBackgroundImagesData = <v2.BackgroundImagesData>[];

    final oldPoseImagesData = <v1.PoseImagesData>[];
    final expectedNewPoseImagesData = <v2.PoseImagesData>[];

    final oldChoiceOptionsData = <v1.ChoiceOptionsData>[];
    final expectedNewChoiceOptionsData = <v2.ChoiceOptionsData>[];

    final oldDialogueBoxesData = <v1.DialogueBoxesData>[];
    final expectedNewDialogueBoxesData = <v2.DialogueBoxesData>[];

    final oldResolverChoiceReferenceData = <v1.ResolverChoiceReferenceData>[];
    final expectedNewResolverChoiceReferenceData =
        <v2.ResolverChoiceReferenceData>[];

    final oldResolverScenePartReferenceData =
        <v1.ResolverScenePartReferenceData>[];
    final expectedNewResolverScenePartReferenceData =
        <v2.ResolverScenePartReferenceData>[];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: SceneGroup.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.scenes, oldScenesData);
        batch.insertAll(oldDb.sceneParts, oldScenePartsData);
        batch.insertAll(oldDb.places, oldPlacesData);
        batch.insertAll(oldDb.backgroundMetadatas, oldBackgroundMetadatasData);
        batch.insertAll(oldDb.frames, oldFramesData);
        batch.insertAll(oldDb.scenePartResolvers, oldScenePartResolversData);
        batch.insertAll(oldDb.customSceneParts, oldCustomScenePartsData);
        batch.insertAll(oldDb.actors, oldActorsData);
        batch.insertAll(oldDb.poseMetadatas, oldPoseMetadatasData);
        batch.insertAll(oldDb.framePoses, oldFramePosesData);
        batch.insertAll(oldDb.choices, oldChoicesData);
        batch.insertAll(oldDb.frameChoices, oldFrameChoicesData);
        batch.insertAll(oldDb.backgroundImages, oldBackgroundImagesData);
        batch.insertAll(oldDb.poseImages, oldPoseImagesData);
        batch.insertAll(oldDb.choiceOptions, oldChoiceOptionsData);
        batch.insertAll(oldDb.dialogueBoxes, oldDialogueBoxesData);
        batch.insertAll(
          oldDb.resolverChoiceReference,
          oldResolverChoiceReferenceData,
        );
        batch.insertAll(
          oldDb.resolverScenePartReference,
          oldResolverScenePartReferenceData,
        );
      },
      validateItems: (newDb) async {
        expect(expectedNewScenesData, await newDb.select(newDb.scenes).get());
        expect(
          expectedNewScenePartsData,
          await newDb.select(newDb.sceneParts).get(),
        );
        expect(expectedNewPlacesData, await newDb.select(newDb.places).get());
        expect(
          expectedNewBackgroundMetadatasData,
          await newDb.select(newDb.backgroundMetadatas).get(),
        );
        expect(expectedNewFramesData, await newDb.select(newDb.frames).get());
        expect(
          expectedNewScenePartResolversData,
          await newDb.select(newDb.scenePartResolvers).get(),
        );
        expect(
          expectedNewCustomScenePartsData,
          await newDb.select(newDb.customSceneParts).get(),
        );
        expect(expectedNewActorsData, await newDb.select(newDb.actors).get());
        expect(
          expectedNewPoseMetadatasData,
          await newDb.select(newDb.poseMetadatas).get(),
        );
        expect(
          expectedNewFramePosesData,
          await newDb.select(newDb.framePoses).get(),
        );
        expect(expectedNewChoicesData, await newDb.select(newDb.choices).get());
        expect(
          expectedNewFrameChoicesData,
          await newDb.select(newDb.frameChoices).get(),
        );
        expect(
          expectedNewBackgroundImagesData,
          await newDb.select(newDb.backgroundImages).get(),
        );
        expect(
          expectedNewPoseImagesData,
          await newDb.select(newDb.poseImages).get(),
        );
        expect(
          expectedNewChoiceOptionsData,
          await newDb.select(newDb.choiceOptions).get(),
        );
        expect(
          expectedNewDialogueBoxesData,
          await newDb.select(newDb.dialogueBoxes).get(),
        );
        expect(
          expectedNewResolverChoiceReferenceData,
          await newDb.select(newDb.resolverChoiceReference).get(),
        );
        expect(
          expectedNewResolverScenePartReferenceData,
          await newDb.select(newDb.resolverScenePartReference).get(),
        );
      },
    );
  });
}
