import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prac_res/archive.dart';
import 'package:result_type/result_type.dart';

part 'data.freezed.dart';
part "data.g.dart";

/* ++ Resources ++ */

@JsonSerializable(genericArgumentFactories: true, constructor: "_")
class Resource<Metadata, Value> {
  final Metadata metadata;
  final Value value;

  Resource._({required this.metadata, required this.value});

  factory Resource.fromJson(
    Map<String, dynamic> json,
    Metadata Function(Object? json) metadataFromJson,
    Value Function(Object? json) valueFromJson,
  ) => _$ResourceFromJson(json, metadataFromJson, valueFromJson);

  Map<String, dynamic> toJson(
    Object? Function(Metadata metadata) metadataToJson,
    Object? Function(Value value) valueToJson,
  ) => _$ResourceToJson(this, metadataToJson, valueToJson);
}

extension type Id._(String _id) implements String {
  static Id fromJson(Object? json) => Id._(json! as String);
  static String toJson(Id id) => id;

  static ArchiveItemName toFilename(Id id) =>
      ArchiveItemName.create(id).unwrap();
  static Id fromFilename(ArchiveItemName filename) => Id._(filename);
}

extension type Collection<ItemId, Item>._(Map<ItemId, Item> _collection)
    implements Map<ItemId, Item> {
  factory Collection.fromJson(
    Map<String, dynamic> json,
    ItemId Function(Object? json) itemIdFromJson,
    Item Function(Object? json) itemFromJson,
  ) {
    return Collection._(
      json.map(
        (idJson, itemJson) =>
            MapEntry(itemIdFromJson(idJson), itemFromJson(itemJson)),
      ),
    );
  }

  Map<String, dynamic> toJson(
    String Function(ItemId id) itemIdToJson,
    Object? Function(Item item) itemToJson,
  ) => _collection.map(
    (id, item) => MapEntry(itemIdToJson(id), itemToJson(item)),
  );

  FolderData toFolderData(
    ArchiveItemName Function(ItemId id) itemIdToFilename,
    Object? Function(Item item) itemToJson,
  ) {
    return FolderData(
      children: FolderChildren(
        _collection.map(
          (itemId, item) => File(
            name: itemIdToFilename(itemId),
            data: FileData.fromJson(itemToJson(item)),
          ),
        ),
      ),
    );
  }

  static Collection<ItemId, Item> fromFolderData<ItemId, Item>(
    FolderData data,
    ItemId Function(ArchiveItemName json) itemIdFromFilename,
    Item Function(Object? json) itemFromJson,
  ) {
    return Collection._(
      data.children.map(
        (itemId, item) => MapEntry(
          itemIdFromFilename(itemId),
          itemFromJson((item as FileData).toJson()),
        ),
      ),
    );
  }
}

extension type CollectionResource<Metadata, ItemId, Item>._(
  Resource<Metadata, Collection<ItemId, Item>> _resourceCollection
)
    implements Resource<Metadata, Map<ItemId, Item>> {
  factory CollectionResource.fromJson(
    Map<String, dynamic> json,
    Metadata Function(Object? json) metadataFromJson,
    ItemId Function(Object? json) itemIdFromJson,
    Item Function(Object? json) itemFromJson,
  ) {
    return CollectionResource._(
      Resource.fromJson(
        json,
        metadataFromJson,
        (json) => Collection.fromJson(
          json! as Map<String, dynamic>,
          itemIdFromJson,
          itemFromJson,
        ),
      ),
    );
  }

  Map<String, dynamic> toJson(
    Object? Function(Metadata metadata) metadataToJson,
    String Function(ItemId id) itemIdToJson,
    Object? Function(Item item) itemToJson,
  ) => _resourceCollection.toJson(
    metadataToJson,
    (collection) => collection.toJson(itemIdToJson, itemToJson),
  );
}

/* ++ Image Resources ++ */

extension type Name._(String _name) implements String {
  static Name fromJson(Object? json) => Name._(json! as String);
  static String toJson(Name name) => name._name;
}

extension type ImageData._(Uint8List _image) implements Uint8List {
  static ImageData fromJson(Object? json) =>
      ImageData._(base64Decode(json! as String));
  static String toJson(ImageData image) => base64Encode(image._image);
}

extension type ImageResource._(Resource<Name, ImageData> _resource)
    implements Resource<Name, ImageData> {
  factory ImageResource.fromJson(Map<String, dynamic> json) => ImageResource._(
    Resource.fromJson(json, Name.fromJson, ImageData.fromJson),
  );

  Map<String, dynamic> toJson() =>
      _resource.toJson(Name.toJson, ImageData.toJson);

  static Map<String, dynamic> staticToJson(ImageResource resource) =>
      resource.toJson();
}

extension type ImageCollectionResource._(
  CollectionResource<Name, Id, ImageResource> _imageCollection
)
    implements CollectionResource<Name, Id, ImageResource> {
  factory ImageCollectionResource.fromJson(Map<String, dynamic> json) {
    return ImageCollectionResource._(
      CollectionResource.fromJson(
        json,
        Name.fromJson,
        Id.fromJson,
        (json) => ImageResource.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }

  Map<String, dynamic> toJson() => _imageCollection.toJson(
    Name.toJson,
    Id.toJson,
    ImageResource.staticToJson,
  );

  // static Map<String, dynamic> staticToJson(ImageResourceCollection imageCollection) => imageCollection.toJson();
}

extension type PoseId._(Id _id) implements Id {} // TODO: Use in accessor.
extension type Pose._(ImageResource _pose) implements ImageResource {}

/// Json files of these will be stored in a subfolder called [/actors],
/// and the names of the json files will be the [Actor]'s id.
///
/// This way, we don't have to load all the actors at the same time.
extension type ActorId._(Id _id) implements Id {} // TODO: Use in accessor.
extension type Actor._(ImageCollectionResource _actor)
    implements ImageCollectionResource {
  factory Actor.fromJson(Map<String, dynamic> json) =>
      Actor._(ImageCollectionResource.fromJson(json));

  static Map<String, dynamic> staticToJson(Actor actor) => actor.toJson();
}

extension type BackgroundId._(Id _id) implements Id {} // TODO: Use in accessor.
extension type Background._(ImageResource _background)
    implements ImageResource {}

/// Json files of these will be stored in a subfolder called [/places],
/// and the names of the json files will be the [Place]'s id.
///
/// This way, we won't have to load all the places at the same time.
extension type PlaceId._(Id _id) implements Id {} // TODO: Use in accessor.
extension type Place._(ImageCollectionResource _place)
    implements ImageCollectionResource {
  factory Place.fromJson(Map<String, dynamic> json) =>
      Place._(ImageCollectionResource.fromJson(json));

  static Map<String, dynamic> staticToJson(Place place) => place.toJson();
}

/* -- Image Resources -- */

/* ++ Save Data Resource ++ */

extension type Option._(String _option) implements String {}
extension type SelectionId._(Id _id) implements Id {}

enum SelectionError implements Exception {
  invalidOption(
    "[selected] has to be either [null] or contained in the set of [options]!",
  );

  final String message;

  const SelectionError(this.message);

  @override
  String toString() => message;
}

@JsonSerializable()
class Selection {
  final Set<Option> options;
  final Option? selected;

  static Result<Null, SelectionError> _validate(
    Set<Option> options,
    Option? selected,
  ) {
    return (selected == null || options.contains(selected))
        ? Success(null)
        : Failure(SelectionError.invalidOption);
  }

  static Result<Selection, SelectionError> create({
    required Set<Option> options,
    required Option? selected,
  }) {
    return _validate(
      options,
      selected,
    ).map((_) => Selection._(options: options, selected: selected));
  }

  factory Selection({required Set<Option> options, required Option? selected}) {
    return create(
      options: options,
      selected: selected,
    ).unwrap(); // We need this for json_serializable.dart!
  }

  Selection._({required this.options, required this.selected});

  factory Selection.fromJson(Map<String, dynamic> json) =>
      _$SelectionFromJson(json);

  Map<String, dynamic> toJson() => _$SelectionToJson(this);

  static Map<String, dynamic> staticToJson(Selection selection) =>
      selection.toJson();
}

extension type SelectionResource._(Resource<Name, Selection> _resource)
    implements Resource<Name, Selection> {
  factory SelectionResource.fromJson(Map<String, dynamic> json) =>
      SelectionResource._(
        Resource.fromJson(
          json,
          Name.fromJson,
          (json) => Selection.fromJson(json! as Map<String, dynamic>),
        ),
      );

  Map<String, dynamic> toJson() =>
      _resource.toJson(Name.toJson, Selection.staticToJson);

  static Map<String, dynamic> staticToJson(SelectionResource selection) =>
      selection.toJson();
}

/* -- Save Data Resource -- */

/* -- Resources -- */

/// Why is this an extension type of [Resource<Id, Id>] you ask?
/// Well, it's really just because I was lazy and I saw that they have the same struct shape anyways.
/// And as a bonus, you can think of the [metadata] as the collection id, and the [value] inside it as the item id,
/// And that makes sense because [metadata] is data about [value].
extension type FullId._(Resource<Id, Id> _fullId) implements Resource<Id, Id> {
  factory FullId.fromJson(Map<String, dynamic> json) =>
      FullId._(Resource.fromJson(json, Id.fromJson, Id.fromJson));

  Map<String, dynamic> toJson() => _fullId.toJson(Id.toJson, Id.toJson);
}

extension type FullBackgroundId._(FullId _fullId) implements FullId {
  factory FullBackgroundId.fromJson(Map<String, dynamic> json) =>
      FullBackgroundId._(FullId.fromJson(json));
}

extension type FullPoseId._(FullId _fullId) implements FullId {
  factory FullPoseId.fromJson(Map<String, dynamic> json) =>
      FullPoseId._(FullId.fromJson(json));
}

@JsonSerializable(constructor: "_")
class DialogueBox {
  final String? name;
  final String dialogue;

  DialogueBox._({required this.name, required this.dialogue});

  factory DialogueBox.fromJson(Map<String, dynamic> json) =>
      _$DialogueBoxFromJson(json);

  Map<String, dynamic> toJson() => _$DialogueBoxToJson(this);
}

@Freezed(unionKey: 'type')
sealed class ScenePart with _$ScenePart {
  const factory ScenePart.frame({
    required FullBackgroundId background,
    required List<FullPoseId> poses,
    required DialogueBox? dialogueBox,
  }) = Frame;

  // TODO: Unimplemented!
  const factory ScenePart.frameResolver() = FrameResolver;

  factory ScenePart.fromJson(Map<String, dynamic> json) =>
      _$ScenePartFromJson(json);
}

@JsonSerializable(constructor: "_")
class OrderedScenePart {
  /// Scene parts are ordered like how Google Docs orders inputs from multiple users with each other.
  /// It's similar to operational transform but simplified!
  final double order;
  final ScenePart part;

  OrderedScenePart._({required this.order, required this.part});

  factory OrderedScenePart.fromJson(Map<String, dynamic> json) =>
      _$OrderedScenePartFromJson(json);

  Map<String, dynamic> toJson() => _$OrderedScenePartToJson(this);

  static Map<String, dynamic> staticToJson(OrderedScenePart part) =>
      part.toJson();
}

extension type ScenePartId._(String id) implements String {}
extension type SceneId._(String id) implements String {}

/// Json files of these will be stored in a subfolder called [/scenes],
/// and the names of the json files will be the [Scene]'s id.
///
/// Scenes can jump to each other with frame resolvers, but that hasn't been implemented yet!
extension type Scene._(CollectionResource<Name, Id, OrderedScenePart> _scene)
    implements CollectionResource<Name, Id, OrderedScenePart> {
  factory Scene.fromJson(Map<String, dynamic> json) {
    return Scene._(
      CollectionResource.fromJson(
        json,
        Name.fromJson,
        Id.fromJson,
        (json) => OrderedScenePart.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      _scene.toJson(Name.toJson, Id.toJson, OrderedScenePart.staticToJson);

  static Map<String, dynamic> staticToJson(Scene scene) => scene.toJson();
}

extension type Selections._(Collection<Id, SelectionResource> _imageCollection)
    implements Collection<Id, SelectionResource> {
  factory Selections.fromJson(Map<String, dynamic> json) {
    return Selections._(
      Collection.fromJson(
        json,
        Id.fromJson,
        (json) => SelectionResource.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      _imageCollection.toJson(Id.toJson, SelectionResource.staticToJson);

  FileData toArchiveItemData() {
    return FileData.fromJson(toJson());
  }

  static Selections fromArchiveItemData(FileData data) {
    return Selections.fromJson(data.toJson()! as Map<String, dynamic>);
  }
}

extension type Places._(Collection<Id, Place> _places)
    implements Collection<Id, Place> {
  FolderData toArchiveItemData() {
    return _places.toFolderData(Id.toFilename, Place.staticToJson);
  }

  static Places fromArchiveItemData(FolderData data) {
    return Places._(
      Collection.fromFolderData(
        data,
        Id.fromFilename,
        (json) => Place.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }
}

extension type Actors._(Collection<Id, Actor> _places)
    implements Collection<Id, Actor> {
  FolderData toArchiveItemData() {
    return _places.toFolderData(Id.toFilename, Actor.staticToJson);
  }

  static Actors fromArchiveItemData(FolderData data) {
    return Actors._(
      Collection.fromFolderData(
        data,
        Id.fromFilename,
        (json) => Actor.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }
}

extension type Scenes._(Collection<Id, Scene> _places)
    implements Collection<Id, Scene> {
  FolderData toArchiveItemData() {
    return _places.toFolderData(Id.toFilename, Scene.staticToJson);
  }

  static Scenes fromArchiveItemData(FolderData data) {
    return Scenes._(
      Collection.fromFolderData(
        data,
        Id.fromFilename,
        (json) => Scene.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }
}

class SceneGroup {
  final Selections selections;
  final Places places;
  final Actors actors;
  final Scenes scenes;

  SceneGroup({
    required this.selections,
    required this.places,
    required this.actors,
    required this.scenes,
  });

  /// Why are the names defined here instead of their respective types?
  /// Well, think about how you would deserialize them.
  /// You would have to pass in the whole scene group folder to the child so that
  /// it could look for its own name and deserialize itself!
  /// That's why the file names are defined here in [SceneGroup].
  static ArchiveItemName selectionsName = ArchiveItemName.create(
    "selections.json",
  ).unwrap();
  static ArchiveItemName placesName = ArchiveItemName.create("places").unwrap();
  static ArchiveItemName actorsName = ArchiveItemName.create("actors").unwrap();
  static ArchiveItemName scenesName = ArchiveItemName.create("scenes").unwrap();

  FolderData toArchiveItemData() {
    return FolderData(
      children: FolderChildren({
        selectionsName: selections.toArchiveItemData(),
        placesName: places.toArchiveItemData(),
        actorsName: actors.toArchiveItemData(),
        scenesName: scenes.toArchiveItemData(),
      }),
    );
  }

  static SceneGroup fromArchiveItemData(FolderData folder) {
    return SceneGroup(
      selections: Selections.fromArchiveItemData(
        folder.find(selectionsName)! as FileData,
      ),
      places: Places.fromArchiveItemData(
        folder.find(placesName)! as FolderData,
      ),
      actors: Actors.fromArchiveItemData(
        folder.find(actorsName)! as FolderData,
      ),
      scenes: Scenes.fromArchiveItemData(
        folder.find(scenesName)! as FolderData,
      ),
    );
  }
}
