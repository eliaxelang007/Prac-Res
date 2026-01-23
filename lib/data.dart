import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
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
    Metadata Function(Object? metadataJson) metadataFromJson,
    Value Function(Object? valueJson) valueFromJson,
  ) => _$ResourceFromJson(json, metadataFromJson, valueFromJson);

  Map<String, dynamic> toJson(
    Object? Function(Metadata metadata) metadataToJson,
    Object? Function(Value value) valueToJson,
  ) => _$ResourceToJson(this, metadataToJson, valueToJson);
}

extension type Id._(String _id) implements String {
  static Id fromJson(Object? json) => Id._(json! as String);
  static String toJson(Id id) => id;
}

extension type ResourceCollection<Metadata, ItemId, Item>._(
  Resource<Metadata, Map<ItemId, Item>> _resourceCollection
)
    implements Resource<Metadata, Map<ItemId, Item>> {
  factory ResourceCollection.fromJson(
    Map<String, dynamic> json,
    Metadata Function(Object? json) metadataFromJson,
    ItemId Function(Object? json) itemIdFromJson,
    Item Function(Object? json) itemFromJson,
  ) {
    return ResourceCollection._(
      Resource.fromJson(
        json,
        metadataFromJson,
        (json) => ((json!) as Map<String, dynamic>).map(
          (idJson, itemJson) =>
              MapEntry(itemIdFromJson(idJson), itemFromJson(itemJson)),
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
    (map) =>
        map.map((id, item) => MapEntry(itemIdToJson(id), itemToJson(item))),
  );

  Folder toArchiveItem(
    ArchiveItemName name,
    Object? Function(Metadata metadata) metadataToJson,
    String Function(ItemId id) itemIdToJson,
    Object? Function(Item item) itemToJson,
  ) {
    return Folder(
      name: name,
      children: _resourceCollection.value.entries
          .map(
            (entry) => File.fromJson(
              ArchiveItemName.create(
                "${itemIdToJson(entry.key)}.json",
              ).unwrap(),
              itemToJson(entry.value),
            ),
          )
          .toList(),
    );
  }
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

extension type ImageResourceCollection._(
  ResourceCollection<Name, Id, ImageResource> _imageCollection
)
    implements ResourceCollection<Name, Id, ImageResource> {
  factory ImageResourceCollection.fromJson(Map<String, dynamic> json) {
    return ImageResourceCollection._(
      ResourceCollection.fromJson(
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
extension type Actor._(ImageResourceCollection _actor)
    implements ImageResourceCollection {
  factory Actor.fromJson(Map<String, dynamic> json) =>
      Actor._(ImageResourceCollection.fromJson(json));

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
extension type Place._(ImageResourceCollection _place)
    implements ImageResourceCollection {
  factory Place.fromJson(Map<String, dynamic> json) =>
      Place._(ImageResourceCollection.fromJson(json));

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
  String toString() {
    return message;
  }
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

extension type Selections._(
  ResourceCollection<Name, Id, SelectionResource> _imageCollection
)
    implements ResourceCollection<Name, Id, SelectionResource> {
  factory Selections.fromJson(Map<String, dynamic> json) {
    return Selections._(
      ResourceCollection.fromJson(
        json,
        Name.fromJson,
        Id.fromJson,
        (json) => SelectionResource.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }

  Map<String, dynamic> toJson() => _imageCollection.toJson(
    Name.toJson,
    Id.toJson,
    SelectionResource.staticToJson,
  );

  File toArchiveItem() {
    return File.fromJson(
      ArchiveItemName.create("selections.json").unwrap(),
      toJson(),
    );
  }
}

/* -- Save Data Resource -- */

/* -- Resources -- */

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
extension type Scene._(ResourceCollection<Name, Id, OrderedScenePart> _scene)
    implements ResourceCollection<Name, Id, OrderedScenePart> {
  factory Scene.fromJson(Map<String, dynamic> json) {
    return Scene._(
      ResourceCollection.fromJson(
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

extension type Places._(ResourceCollection<Name, Id, Place> _places)
    implements ResourceCollection<Name, Id, Place> {
  Folder toArchiveItem() {
    return _places.toArchiveItem(
      ArchiveItemName.create("places").unwrap(),
      Name.toJson,
      Id.toJson,
      Place.staticToJson,
    );
  }
}

extension type Actors._(ResourceCollection<Name, Id, Actor> _places)
    implements ResourceCollection<Name, Id, Actor> {
  Folder toArchiveItem() {
    return _places.toArchiveItem(
      ArchiveItemName.create("actors").unwrap(),
      Name.toJson,
      Id.toJson,
      Actor.staticToJson,
    );
  }
}

extension type Scenes._(ResourceCollection<Name, Id, Scene> _places)
    implements ResourceCollection<Name, Id, Scene> {
  Folder toArchiveItem() {
    return _places.toArchiveItem(
      ArchiveItemName.create("scenes").unwrap(),
      Name.toJson,
      Id.toJson,
      Scene.staticToJson,
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

  Folder toArchiveItem() {
    return Folder(
      name: ArchiveItemName.create("scene_group").unwrap(),
      children: [
        selections.toArchiveItem(),
        places.toArchiveItem(),
        actors.toArchiveItem(),
        scenes.toArchiveItem(),
      ],
    );
  }
}
