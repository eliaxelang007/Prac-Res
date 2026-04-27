import 'dart:typed_data';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:prac_res/data/data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "editor_state.g.dart";

class Editor<Edited, InnerProperty> {
  final InnerProperty property;
  final Edited Function(InnerProperty) editor;

  static Editor<T, T> from<T>(T value) {
    return Editor._(value, (newValue) => value);
  }

  Editor._(this.property, this.editor);

  Editor<Edited, InnerInnerProperty> select<InnerInnerProperty>(
    InnerInnerProperty Function(InnerProperty) getInnerInner,
    InnerProperty Function(InnerProperty, InnerInnerProperty) updateInner,
  ) {
    return Editor._(getInnerInner(property), (
      InnerInnerProperty newInnerInner,
    ) {
      return editor(updateInner(property, newInnerInner));
    });
  }

  Edited apply(InnerProperty newInner) => editor(newInner);

  Edited update(InnerProperty Function(InnerProperty) updater) =>
      editor(updater(property));
}

@Riverpod(keepAlive: true)
class SelectedSceneGroup extends _$SelectedSceneGroup {
  @override
  SceneGroup? build() => null;

  void select(SceneGroup sceneGroup) {
    state = sceneGroup;
    ref.read(selectedSceneProvider.notifier).select(null);
  }

  Editor<SceneGroup, Places>? get _placesEditor {
    if (state == null) return null;
    return Editor.from(
      state!,
    ).select((s) => s.places, (s, p) => s.copyWith(places: p));
  }

  Editor<SceneGroup, Place?>? _placeEditor(PlaceId id) {
    return _placesEditor?.select(
      (places) => places.find(id),
      (places, newPlace) => newPlace != null
          ? Places(Collection(places.add(id, newPlace)))
          : places,
    );
  }

  Editor<SceneGroup, Collection<BackgroundId, Background>?>? _backgroundsEditor(
    PlaceId placeId,
  ) {
    return _placeEditor(placeId)?.select(
      (place) => place?.value,
      (place, newBackgrounds) => place != null && newBackgrounds != null
          ? Place(
              ImageCollectionResource(
                CollectionResource(
                  Resource(metadata: place.metadata, value: newBackgrounds),
                ),
              ),
            )
          : place,
    );
  }

  Editor<SceneGroup, Actors>? get _actorsEditor {
    if (state == null) return null;
    return Editor.from(
      state!,
    ).select((s) => s.actors, (s, a) => s.copyWith(actors: a));
  }

  // --- 2. State Modifiers ---
  // Using the editors above, the actual updates become trivial one-liners.

  void updatePlaces(PlaceId id, Places Function(Places) updater) {
    final editor = _placesEditor;
    if (editor != null) state = editor.update(updater);
  }

  void editPlace(PlaceId id, Place place) {
    final editor = _placesEditor;
    if (editor != null) {
      state = editor.update(
        (places) => Places(Collection(places.add(id, place))),
      );
    }
  }

  void deletePlace(PlaceId placeId) {
    final editor = _placesEditor;
    if (editor != null) {
      state = editor.update(
        (places) => Places(Collection(places.remove(placeId))),
      );
    }
  }

  void editBackground(FullBackgroundId backgroundId, Background background) {
    final editor = _backgroundsEditor(backgroundId.parentId);
    if (editor != null) {
      state = editor.update(
        (backgrounds) => backgrounds != null
            ? Collection(backgrounds.add(backgroundId.childId, background))
            : backgrounds,
      );
    }
  }

  void deleteBackground(FullBackgroundId background) {
    final editor = _backgroundsEditor(background.parentId);
    if (editor != null) {
      state = editor.update(
        (backgrounds) => backgrounds != null
            ? Collection(backgrounds.remove(background.childId))
            : backgrounds,
      );
    }
  }

  void deleteBackgroundById(PlaceId placeId, BackgroundId bgId) {
    final editor = _backgroundsEditor(placeId);
    if (editor != null) {
      state = editor.update(
        (backgrounds) => backgrounds != null
            ? Collection(backgrounds.remove(bgId))
            : backgrounds,
      );
    }
  }

  void addBackground(PlaceId placeId, String filename, Uint8List bytes) {
    final editor = _backgroundsEditor(placeId);
    if (editor != null) {
      final newBackgroundId = BackgroundId(Id.create());
      final newBackground = Background(
        ImageResource(
          Resource(
            metadata: Name(filename),
            value: ImageData(image: bytes),
          ),
        ),
      );

      state = editor.update(
        (backgrounds) => backgrounds != null
            ? Collection(backgrounds.add(newBackgroundId, newBackground))
            : backgrounds,
      );
    }
  }

  void addActor(String name) {
    final editor = _actorsEditor;
    if (editor != null) {
      state = editor.update(
        (actors) => Actors(
          Collection(
            actors.add(
              ActorId(Id.create()),
              Actor(
                ImageCollectionResource(
                  CollectionResource(
                    Resource<Name, Collection<PoseId, Pose>>(
                      metadata: Name(name),
                      value: Collection<PoseId, Pose>(IMap()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
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
