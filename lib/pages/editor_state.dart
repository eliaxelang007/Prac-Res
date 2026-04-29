import 'dart:typed_data';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:prac_res/data/data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "editor_state.g.dart";

@Riverpod(keepAlive: true)
class SelectedSceneGroup extends _$SelectedSceneGroup {
  @override
  SceneGroup? build() => null;

  void select(SceneGroup sceneGroup) {
    state = sceneGroup;
    ref.read(selectedSceneProvider.notifier).select(null);
  }

  void addPlace(String name) {
    _placesEditor?.update(
      (p) => Places(
        Collection(
          p.add(
            PlaceId(Id.create()),
            Place(
              ImageCollectionResource(
                CollectionResource(
                  Resource(metadata: Name(name), value: Collection(IMap())),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void removePlace(PlaceId id) {
    _placesEditor?.update((p) => Places(Collection(p.remove(id))));
  }

  void editPlaceName(PlaceId id, String newName) {
    _placeEditor(id)?.update((p) => Place(p.copyWith(metadata: Name(newName))));
  }

  // --- 2. BACKGROUNDS ---

  void addBackground(PlaceId placeId, String name, Uint8List bytes) {
    _backgroundsEditor(placeId)?.update(
      (bgs) => bgs.add(
        BackgroundId(Id.create()),
        Background(
          ImageResource(
            Resource(
              metadata: Name(name),
              value: ImageData(image: bytes),
            ),
          ),
        ),
      ),
    );
  }

  void removeBackground(PlaceId placeId, BackgroundId bgId) {
    _backgroundsEditor(placeId)?.update((bgs) => bgs.remove(bgId));
  }

  void editBackgroundMetadata(
    PlaceId placeId,
    BackgroundId backgroundId, {
    String? name,
    Uint8List? image,
  }) {
    _backgroundEditor(placeId, backgroundId)?.update((bg) {
      var resource = bg.metadata; // Background is an ImageResource
      var value = bg.value;

      return Background(
        ImageResource(
          Resource(
            metadata: name != null ? Name(name) : resource,
            value: image != null ? ImageData(image: image) : value,
          ),
        ),
      );
    });
  }

  // --- 3. ACTORS & POSES ---

  void addActor(String name) {
    _actorsEditor?.update(
      (a) => a.add(
        ActorId(Id.create()),
        Actor(
          ImageCollectionResource(
            CollectionResource(
              Resource(metadata: Name(name), value: Collection(IMap())),
            ),
          ),
        ),
      ),
    );
  }

  void removeActor(ActorId id) {
    _actorsEditor?.update((a) => a.remove(id));
  }

  void editActorName(ActorId id, String name) {
    _actorEditor(id)?.update((a) => a.copyWith(metadata: Name(name)));
  }

  void addPose(ActorId actorId, String name, Uint8List bytes) {
    _posesEditor(actorId)?.update(
      (ps) => ps.add(
        PoseId(Id.create()),
        Pose(
          ImageResource(
            Resource(
              metadata: Name(name),
              value: ImageData(image: bytes),
            ),
          ),
        ),
      ),
    );
  }

  // --- 4. SCENES & SCENEPARTS ---

  void addScene(String name) {
    _scenesEditor?.update(
      (s) => s.add(
        SceneId(Id.create()),
        Scene(
          CollectionResource(
            Resource(metadata: Name(name), value: Collection(IMap())),
          ),
        ),
      ),
    );
  }

  void editSceneName(SceneId id, String name) {
    _sceneEditor(id)?.update((s) => s.copyWith(metadata: Name(name)));
  }

  void addFrame(SceneId sceneId) {
    _scenePartsEditor(sceneId)?.update((items) {
      final partId = ScenePartId(Id.create());
      final order = items.isEmpty
          ? 0.0
          : (items.values.map((e) => e.order).reduce((a, b) => a > b ? a : b) +
                1.0);

      return items.add(
        partId,
        OrderedScenePart(
          order: order,
          part: ScenePart.frame(
            background: null,
            poses: IList(),
            dialogueBox: const DialogueBox(name: "Speaker", dialogue: "..."),
          ),
        ),
      );
    });
  }

  void editFrame(
    SceneId sId,
    ScenePartId pId, {
    FullBackgroundId? bg,
    IList<FullPoseId>? poses,
    DialogueBox? dialogue,
  }) {
    _scenePartEditor(sId, pId)?.update((ordered) {
      final part = ordered.part;
      if (part is Frame) {
        return ordered.copyWith(
          part: part.copyWith(
            background: bg ?? part.background,
            poses: poses ?? part.poses,
            dialogueBox: dialogue ?? part.dialogueBox,
          ),
        );
      }
      return ordered;
    });
  }

  // --- 5. SELECTIONS ---

  void updateSelection(
    SelectionId id, {
    String? name,
    ISet<Option>? options,
    Option? selected,
  }) {
    _selectionEditor(id)?.update((current) {
      return current.copyWith(
        metadata: name != null ? Name(name) : current.metadata,
        value: current.value.copyWith(
          options: options ?? current.value.options,
          selected: selected ?? current.value.selected,
        ),
      );
    });
  }

  // --- PRIVATE EDITOR HELPERS ---
  // This is where the magic "drilling" happens.

  Editor<SceneGroup, Places>? get _placesEditor => state == null
      ? null
      : Editor.from(
          state!,
        ).select((s) => s.places, (s, v) => s.copyWith(places: v));

  Editor<SceneGroup, Place>? _placeEditor(PlaceId id) =>
      _placesEditor?.select((ps) => ps.find(id)!, (ps, p) => ps.add(id, p));

  Editor<SceneGroup, Collection<BackgroundId, Background>>? _backgroundsEditor(
    PlaceId id,
  ) => _placeEditor(id)?.select((p) => p.value, (p, v) => p.copyWith(value: v));

  Editor<SceneGroup, Background>? _backgroundEditor(
    PlaceId pId,
    BackgroundId bId,
  ) => _backgroundsEditor(
    pId,
  )?.select((bgs) => bgs.find(bId)!, (bgs, b) => bgs.add(bId, b));

  Editor<SceneGroup, Actors>? get _actorsEditor => state == null
      ? null
      : Editor.from(
          state!,
        ).select((s) => s.actors, (s, v) => s.copyWith(actors: v));

  Editor<SceneGroup, Actor>? _actorEditor(ActorId id) =>
      _actorsEditor?.select((as) => as.find(id)!, (as, a) => as.add(id, a));

  Editor<SceneGroup, Collection<PoseId, Pose>>? _posesEditor(ActorId id) =>
      _actorEditor(id)?.select((a) => a.value, (a, v) => a.copyWith(value: v));

  Editor<SceneGroup, Scenes>? get _scenesEditor => state == null
      ? null
      : Editor.from(
          state!,
        ).select((s) => s.scenes, (s, v) => s.copyWith(scenes: v));

  Editor<SceneGroup, Scene>? _sceneEditor(SceneId id) =>
      _scenesEditor?.select((ss) => ss.find(id)!, (ss, s) => ss.add(id, s));

  Editor<SceneGroup, Collection<ScenePartId, OrderedScenePart>>?
  _scenePartsEditor(SceneId id) =>
      _sceneEditor(id)?.select((s) => s.value, (s, v) => s.copyWith(value: v));

  Editor<SceneGroup, OrderedScenePart>? _scenePartEditor(
    SceneId sId,
    ScenePartId pId,
  ) => _scenePartsEditor(
    sId,
  )?.select((ps) => ps.find(pId)!, (ps, p) => ps.add(pId, p));

  Editor<SceneGroup, SelectionResource>? _selectionEditor(SelectionId id) =>
      state == null
      ? null
      : Editor.from(state!).select(
          (s) => s.selections.find(id)!,
          (s, v) => s.copyWith(selections: s.selections.add(id, v)),
        );
}

@Riverpod(keepAlive: true)
class SelectedScene extends _$SelectedScene {
  @override
  SceneId? build() => null;
  void select(SceneId? id) {
    state = id;
    ref.read(selectedScenePartProvider.notifier).select(null);
  }
}

@Riverpod(keepAlive: true)
class SelectedScenePart extends _$SelectedScenePart {
  @override
  ScenePartId? build() => null;
  void select(ScenePartId? id) => state = id;
}
