import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:prac_res/data/data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "editor_state.g.dart";

extension SceneGroupPaths on SceneGroup {
  // -- Places & Backgrounds --
  Selector<SceneGroup, Place?> placePath(Id<Place> id) {
    final childSelector = Collection.childSelector<Place>(id);
    return SceneGroup.placesSelector.select<Place?>(
      (places) => childSelector.get(places),
      (places, place) => Places.from(childSelector.set(places, place)),
    );
  }

  Selector<SceneGroup, Background?> backgroundPath(
    FullId<Place, Background> id,
  ) => SceneGroup.placesSelector.compose(
    id.childSelector() as Selector<Places, Background?>,
  );

  // -- Actors & Poses --
  Selector<SceneGroup, Actor?> actorPath(Id<Actor> id) {
    final childSelector = Collection.childSelector<Actor>(id);
    return SceneGroup.actorsSelector.select<Actor?>(
      (actors) => childSelector.get(actors),
      (actors, actor) => Actors.from(childSelector.set(actors, actor)),
    );
  }

  Selector<SceneGroup, Pose?> posePath(FullId<Actor, Pose> id) => SceneGroup
      .actorsSelector
      .compose(id.childSelector() as Selector<Actors, Pose?>);

  // -- Scenes & Scene Parts --
  Selector<SceneGroup, Scene?> scenePath(Id<Scene> id) {
    final childSelector = Collection.childSelector<Scene>(id);
    return SceneGroup.scenesSelector.select<Scene?>(
      (scenes) => childSelector.get(scenes),
      (scenes, scene) => Scenes.from(childSelector.set(scenes, scene)),
    );
  }

  Selector<SceneGroup, OrderedScenePart?> scenePartPath(
    FullId<Scene, OrderedScenePart> id,
  ) => SceneGroup.scenesSelector.compose(
    id.childSelector() as Selector<Scenes, OrderedScenePart?>,
  );

  // -- Frames --
  Selector<SceneGroup, Frame?> framePath(FullId<Scene, OrderedScenePart> id) =>
      scenePartPath(id).select<Frame?>(
        (ordered) {
          final part = ordered?.part;
          return (part is Frame) ? part : null;
        },
        (ordered, newFrame) => (ordered != null && newFrame != null)
            ? ordered.copyWith(part: newFrame)
            : ordered,
      );

  // -- Dialogue Box --
  Selector<SceneGroup, DialogueBox?> dialogueBoxPath(
    FullId<Scene, OrderedScenePart> id,
  ) => framePath(id).select<DialogueBox?>(
    (frame) => frame?.dialogueBox,
    (frame, newBox) =>
        frame != null ? frame.copyWith(dialogueBox: newBox) : frame,
  );
}

@Riverpod(keepAlive: true)
class SelectedSceneGroup extends _$SelectedSceneGroup {
  @override
  SceneGroup? build() => null;

  void select(SceneGroup? sceneGroup) {
    state = sceneGroup;
    ref.read(selectedSceneProvider.notifier).select(null);
  }

  void _update(SceneGroup Function(SceneGroup) updater) {
    if (state != null) {
      state = updater(state!);
    }
  }

  void setPlace(Id<Place> id, Place place) =>
      _update((sceneGroup) => sceneGroup.placePath(id).set(sceneGroup, place));

  void removePlace(Id<Place> id) =>
      _update((sceneGroup) => sceneGroup.placePath(id).set(sceneGroup, null));

  void editPlaceName(Id<Place> id, String name) => _update(
    (sceneGroup) => sceneGroup
        .placePath(id)
        .select<String?>(
          (p) => p?.metadata.name,
          (p, n) => (p != null && n != null)
              ? Place.fromBackgrounds(name: Name(n), backgrounds: p.value)
              : p,
        )
        .set(sceneGroup, name),
  );

  void setBackground(FullId<Place, Background> id, Background bg) => _update(
    (sceneGroup) => sceneGroup.backgroundPath(id).set(sceneGroup, bg),
  );

  void removeBackground(FullId<Place, Background> id) => _update(
    (sceneGroup) => sceneGroup.backgroundPath(id).set(sceneGroup, null),
  );

  void editBackgroundName(FullId<Place, Background> id, String name) => _update(
    (sceneGroup) => sceneGroup
        .backgroundPath(id)
        .select<String?>(
          (background) => background?.metadata.name,
          (b, n) => (b != null && n != null)
              ? Background(name: Name(n), image: b.value)
              : b,
        )
        .set(sceneGroup, name),
  );

  void editBackgroundImage(FullId<Place, Background> id, ImageData image) =>
      _update(
        (sceneGroup) => sceneGroup
            .backgroundPath(id)
            .select<ImageData?>(
              (background) => background?.value,
              (background, newImage) => (background != null && newImage != null)
                  ? Background(name: background.metadata, image: newImage)
                  : background,
            )
            .set(sceneGroup, image),
      );

  // ==== ACTORS ====
  void setActor(Id<Actor> id, Actor actor) =>
      _update((sceneGroup) => sceneGroup.actorPath(id).set(sceneGroup, actor));

  void removeActor(Id<Actor> id) =>
      _update((sceneGroup) => sceneGroup.actorPath(id).set(sceneGroup, null));

  void editActorName(Id<Actor> id, String name) => _update(
    (sceneGroup) => sceneGroup
        .actorPath(id)
        .select<String?>(
          (actor) => actor?.metadata.name,
          (actor, n) => (actor != null && n != null)
              ? Actor.fromPoses(name: Name(n), poses: actor.value)
              : actor,
        )
        .set(sceneGroup, name),
  );

  // ==== POSES ====
  void setPose(FullId<Actor, Pose> id, Pose pose) =>
      _update((sceneGroup) => sceneGroup.posePath(id).set(sceneGroup, pose));

  void removePose(FullId<Actor, Pose> id) =>
      _update((sceneGroup) => sceneGroup.posePath(id).set(sceneGroup, null));

  void editPoseName(FullId<Actor, Pose> id, String name) => _update(
    (sceneGroup) => sceneGroup
        .posePath(id)
        .select<String?>(
          (pose) => pose?.metadata.name,
          (pose, newName) => (pose != null && newName != null)
              ? Pose(name: Name(newName), image: pose.value)
              : pose,
        )
        .set(sceneGroup, name),
  );

  void editPoseImage(FullId<Actor, Pose> id, ImageData image) => _update(
    (sceneGroup) => sceneGroup
        .posePath(id)
        .select<ImageData?>(
          (pose) => pose?.value,
          (pose, newImage) => (pose != null && newImage != null)
              ? Pose(name: pose.metadata, image: newImage)
              : pose,
        )
        .set(sceneGroup, image),
  );

  // ==== SCENES ====
  void setScene(Id<Scene> id, Scene scene) =>
      _update((sceneGroup) => sceneGroup.scenePath(id).set(sceneGroup, scene));

  void removeScene(Id<Scene> id) =>
      _update((sceneGroup) => sceneGroup.scenePath(id).set(sceneGroup, null));

  void editSceneName(Id<Scene> id, String name) => _update(
    (sceneGroup) => sceneGroup
        .scenePath(id)
        .select<String?>(
          (scene) => scene?.metadata.name,
          (scene, newName) => (scene != null && newName != null)
              ? Scene.fromParts(name: Name(newName), parts: scene.value)
              : scene,
        )
        .set(sceneGroup, name),
  );

  // ==== SCENE PARTS ====
  void setScenePart(
    FullId<Scene, OrderedScenePart> id,
    OrderedScenePart part,
  ) => _update(
    (sceneGroup) => sceneGroup.scenePartPath(id).set(sceneGroup, part),
  );

  void removeScenePart(FullId<Scene, OrderedScenePart> id) => _update(
    (sceneGroup) => sceneGroup.scenePartPath(id).set(sceneGroup, null),
  );

  void reorderScenePart(FullId<Scene, OrderedScenePart> id, double newOrder) =>
      _update(
        (sceneGroup) => sceneGroup
            .scenePartPath(id)
            .select<double?>(
              (part) => part?.order,
              (part, newOrder) => (part != null && newOrder != null)
                  ? part.copyWith(order: newOrder)
                  : part,
            )
            .set(sceneGroup, newOrder),
      );

  // ==== FRAMES ====
  void changeFrameBackground(
    FullId<Scene, OrderedScenePart> id,
    FullId<Place, Background> bgId,
  ) => _update(
    (sceneGroup) => sceneGroup
        .framePath(id)
        .select<FullId<Place, Background>?>(
          (frame) => frame?.background,
          (frame, newBackground) => (frame != null && newBackground != null)
              ? frame.copyWith(background: newBackground)
              : frame,
        )
        .set(sceneGroup, bgId),
  );

  void changeFramePoses(
    FullId<Scene, OrderedScenePart> id,
    IList<FullId<Actor, Pose>> poses,
  ) => _update(
    (sceneGroup) => sceneGroup
        .framePath(id)
        .select<IList<FullId<Actor, Pose>>?>(
          (frame) => frame?.poses,
          (frame, newPoses) => (frame != null && newPoses != null)
              ? frame.copyWith(poses: newPoses)
              : frame,
        )
        .set(sceneGroup, poses),
  );

  // ==== DIALOGUE BOX ====
  void changeFrameDialogueBox(
    FullId<Scene, OrderedScenePart> id,
    DialogueBox? box,
  ) => _update(
    (sceneGroup) => sceneGroup.dialogueBoxPath(id).set(sceneGroup, box),
  );

  void changeDialogueText(FullId<Scene, OrderedScenePart> id, String text) =>
      _update(
        (sceneGroup) => sceneGroup
            .dialogueBoxPath(id)
            .select<String?>(
              (dialogueBox) => dialogueBox?.dialogue,
              (dialogueBox, newText) => (dialogueBox != null && newText != null)
                  ? dialogueBox.copyWith(dialogue: newText)
                  : dialogueBox,
            )
            .set(sceneGroup, text),
      );

  void changeDialogueName(FullId<Scene, OrderedScenePart> id, String? name) =>
      _update(
        (sceneGroup) => sceneGroup
            .dialogueBoxPath(id)
            .select<String?>(
              (dialogueBox) => dialogueBox?.name,
              (dialogueBox, newName) => dialogueBox != null
                  ? dialogueBox.copyWith(name: newName)
                  : dialogueBox,
            )
            .set(sceneGroup, name),
      );
}

@Riverpod(keepAlive: true)
class SelectedScene extends _$SelectedScene {
  @override
  Id<Scene>? build() => null;

  void select(Id<Scene>? id) {
    state = id;
    ref.read(selectedScenePartProvider.notifier).select(null);
  }
}

@Riverpod(keepAlive: true)
class SelectedScenePart extends _$SelectedScenePart {
  @override
  FullId<Scene, OrderedScenePart>? build() => null;

  void select(FullId<Scene, OrderedScenePart>? id) => state = id;
}
