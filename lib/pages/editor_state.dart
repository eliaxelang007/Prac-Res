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
    if (state == null) return;

    // 1. Generate the new PlaceId and Name metadata
    final newPlaceId = PlaceId(Id.create());
    final placeName = Name(name);

    // 2. Create an empty collection for the backgrounds this place will eventually hold
    final emptyBackgrounds = Collection<BackgroundId, Background>(IMap());

    // 3. Construct the nested Resource types to build an empty Place
    final placeResource = Resource<Name, Collection<BackgroundId, Background>>(
      metadata: placeName,
      value: emptyBackgrounds,
    );

    final newPlace = Place(
      ImageCollectionResource(CollectionResource(placeResource)),
    );

    // 4. Add the new place to the immutable map
    // Since `Places` implements `IMap`, we can call `.add()` directly,
    // which returns a new `IMap` containing our addition.
    final updatedPlacesMap = state!.places.add(newPlaceId, newPlace);

    // 5. Repackage the updated map back into your Extension Types
    final updatedPlaces = Places(Collection(updatedPlacesMap));

    // 6. Update the state using Freezed's generated copyWith
    state = state!.copyWith(places: updatedPlaces);
  }

  void addBackground(PlaceId placeId, String filename, Uint8List bytes) {
    if (state == null) return;

    // 1. Generate IDs and Metadata
    final newBgId = BackgroundId(Id.create());
    final bgName = Name(filename);

    // 2. Wrap raw bytes into the ImageData class (triggers custom deep equality)
    final imageData = ImageData(image: bytes);

    // 3. Construct the nested Resource types to build the Background extension type
    final imageResource = Resource<Name, ImageData>(
      metadata: bgName,
      value: imageData,
    );
    final newBackground = Background(ImageResource(imageResource));

    // 4. Find the targeted place to add the background to
    final viewedPlace = state!.places.find(placeId);

    // Safety check in case the place was deleted in another view
    if (viewedPlace == null) return;

    // 5. Build the updated Place
    // We use .unlock here because `Collection` implements `IMap`.
    // This gives us a new IMap containing the added background.
    final updatedBackgroundsMap = viewedPlace.value.add(newBgId, newBackground);

    // Package it back up into a pure Collection extension type
    final updatedBackgroundsCollection = Collection<BackgroundId, Background>(
      updatedBackgroundsMap,
    );

    // Rebuild the Place Resource structure
    final updatedPlaceResource =
        Resource<Name, Collection<BackgroundId, Background>>(
          // Preserve the existing Place name metadata
          metadata: viewedPlace.metadata,
          value: updatedBackgroundsCollection,
        );

    // Finalize the updated Place extension type
    final updatedPlace = Place(
      ImageCollectionResource(CollectionResource(updatedPlaceResource)),
    );

    // 6. Update the main Places collection with the modified place
    // Places implements IMap, so we call .add which is an upsert (replace)
    final updatedPlacesMap = state!.places.add(placeId, updatedPlace);
    final updatedPlaces = Places(Collection(updatedPlacesMap));

    // 7. Finally, update the main SceneGroup state
    state = state!.copyWith(places: updatedPlaces);
  }

  void deletePlace(PlaceId placeId) {
    if (state == null) return;

    // Removing from an IMap returns a new IMap without the item
    final updatedPlacesMap = state!.places.remove(placeId);
    state = state!.copyWith(places: Places(Collection(updatedPlacesMap)));
  }

  void deleteBackground(PlaceId placeId, BackgroundId bgId) {
    if (state == null) return;

    final viewedPlace = state!.places.find(placeId);
    if (viewedPlace == null) return;

    // Remove the background from the place's inner collection
    final updatedBackgroundsMap = viewedPlace.value.remove(bgId);

    // Package it back up
    final updatedBackgroundsCollection = Collection<BackgroundId, Background>(
      updatedBackgroundsMap,
    );

    final updatedPlaceResource =
        Resource<Name, Collection<BackgroundId, Background>>(
          metadata: viewedPlace.metadata,
          value: updatedBackgroundsCollection,
        );

    final updatedPlace = Place(
      ImageCollectionResource(CollectionResource(updatedPlaceResource)),
    );

    // Update the main map
    final updatedPlacesMap = state!.places.add(placeId, updatedPlace);
    state = state!.copyWith(places: Places(Collection(updatedPlacesMap)));
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
