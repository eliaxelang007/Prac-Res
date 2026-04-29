import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import "package:junction/junction.dart";
import 'package:prac_res/data/archive.dart';
import 'package:uuid/uuid.dart';

part 'data.freezed.dart';
part "data.g.dart";

class Lens<Selected, InnerProperty> {
  final InnerProperty Function(Selected) get;
  final Selected Function(Selected, InnerProperty) set;

  Lens(this.get, this.set);

  Lens<Selected, InnerInnerProperty> compose<InnerInnerProperty>(
    Lens<InnerProperty, InnerInnerProperty> toComposeWith,
  ) {
    return Lens(
      (selected) => toComposeWith.get(get(selected)),
      (selected, innerInnerProperty) =>
          set(selected, toComposeWith.set(get(selected), innerInnerProperty)),
    );
  }
}

// class Editor<Edited, InnerProperty> {
//   final InnerProperty property;

//   final Edited Function(InnerProperty) editor;

//   static Editor<T, T> from<T>(T value) {
//     return Editor._(value, (newValue) => newValue);
//   }

//   Editor._(this.property, this.editor);

//   Editor<Edited, InnerInnerProperty> select<InnerInnerProperty>(
//     InnerInnerProperty Function(InnerProperty) getInnerInner,

//     InnerProperty Function(InnerProperty, InnerInnerProperty) updateInner,
//   ) {
//     return Editor._(getInnerInner(property), (newInnerInner) {
//       return editor(updateInner(property, newInnerInner));
//     });
//   }

//   Editor<Edited, InnerInnerProperty> compose<InnerInnerProperty>(
//     Editor<InnerProperty, InnerInnerProperty> toComposeWith,
//   ) {
//     return Editor._(toComposeWith.property, (newInnerInner) {
//       return editor(toComposeWith.set(newInnerInner));
//     });
//   }

//   Edited set(InnerProperty newInner) => editor(newInner);

//   Edited update(InnerProperty Function(InnerProperty) updater) =>
//       editor(updater(property));
// }

@freezed
abstract class SceneGroup with _$SceneGroup {
  /// We need a private constructor so we can define custom methods inside a class annotated with [freezed].
  const SceneGroup._();

  const factory SceneGroup({
    required Selections selections,
    required Scenes scenes,
    required Places places,
    required Actors actors,
  }) = _SceneGroup;

  static final empty = SceneGroup(
    selections: Selections(Collection(IMap())),
    scenes: Scenes(Collection(IMap())),
    places: Places(Collection(IMap())),
    actors: Actors(Collection(IMap())),
  );

  /// Why are the names defined here instead of their respective types?
  /// Well, think about how you would deserialize them.
  /// You would have to pass in the whole scene group folder to the child so that
  /// it could look for its own name and deserialize itself!
  /// That's why the file names are defined here in [SceneGroup].
  static final selectionsName = CrossFilesystemName("selections.json");
  static final scenesName = CrossFilesystemName("scenes");
  static final placesName = CrossFilesystemName("places");
  static final actorsName = CrossFilesystemName("actors");

  CrossFolderData toFilesystemData() {
    return CrossFolderData(
      children: CrossFolderChildren({
        selectionsName: selections.toFilesystemData(),
        scenesName: scenes.toFilesystemData(),
        placesName: places.toFilesystemData(),
        actorsName: actors.toFilesystemData(),
      }),
    );
  }

  Archive toArchiveData() {
    return ArchiveExtension.fromFolder(toFilesystemData());
  }

  static SceneGroup fromArchiveData(Archive archive) {
    return SceneGroup.fromFilesystemData(
      CrossFolderDataExtension.fromArchive(archive),
    );
  }

  static SceneGroup fromFilesystemData(CrossFolderData folder) {
    final folderChildren = folder.children;

    return SceneGroup(
      selections: Selections.fromFilesystemData(
        folderChildren.find(selectionsName)! as CrossFileData,
      ),
      scenes: Scenes.fromFilesystemData(
        folderChildren.find(scenesName)! as CrossFolderData,
      ),
      places: Places.fromFilesystemData(
        folderChildren.find(placesName)! as CrossFolderData,
      ),
      actors: Actors.fromFilesystemData(
        folderChildren.find(actorsName)! as CrossFolderData,
      ),
    );
  }
}

/* ++ Resource Collections ++ */

extension type Selections(
  Collection<SelectionId, SelectionResource> _selectionCollection
)
    implements Collection<SelectionId, SelectionResource> {
  factory Selections.fromJson(Map<String, dynamic> json) {
    return Selections(
      Collection.fromJson(
        json,
        SelectionId.fromJson,
        (json) => SelectionResource.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      _selectionCollection.toJson(Id.toJson, SelectionResource.staticToJson);

  CrossFileData toFilesystemData() {
    return CrossFileData.fromJson(toJson());
  }

  static Selections fromFilesystemData(CrossFileData data) {
    return Selections.fromJson(data.toJson()! as Map<String, dynamic>);
  }
}

extension type Scenes(Collection<SceneId, Scene> _scenes)
    implements Collection<SceneId, Scene> {
  CrossFolderData toFilesystemData() {
    return _scenes.toFolderData(Id.toFilename, Scene.staticToJson);
  }

  static Scenes fromFilesystemData(CrossFolderData data) {
    return Scenes(
      Collection.fromFolderData(
        data,
        SceneId.fromFilename,
        (json) => Scene.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }
}

extension type Places(Collection<PlaceId, Place> _places)
    implements Collection<PlaceId, Place> {
  CrossFolderData toFilesystemData() {
    return _places.toFolderData(Id.toFilename, Place.staticToJson);
  }

  static Places fromFilesystemData(CrossFolderData data) {
    return Places(
      Collection.fromFolderData(
        data,
        PlaceId.fromFilename,
        (json) => Place.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }
}

extension type Actors(Collection<ActorId, Actor> _actors)
    implements Collection<ActorId, Actor> {
  CrossFolderData toFilesystemData() {
    return _actors.toFolderData(Id.toFilename, Actor.staticToJson);
  }

  static Actors fromFilesystemData(CrossFolderData data) {
    return Actors(
      Collection.fromFolderData(
        data,
        ActorId.fromFilename,
        (json) => Actor.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }
}

/* -- Resource Collections -- */

/* ++ Collection Resources ++ */

extension type SelectionResource(Resource<Name, Selection> _resource)
    implements Resource<Name, Selection> {
  factory SelectionResource.fromJson(Map<String, dynamic> json) =>
      SelectionResource(
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

extension type Scene(
  CollectionResource<Name, ScenePartId, OrderedScenePart> _scene
)
    implements CollectionResource<Name, ScenePartId, OrderedScenePart> {
  factory Scene.fromJson(Map<String, dynamic> json) {
    return Scene(
      CollectionResource.fromJson(
        json,
        Name.fromJson,
        ScenePartId.fromJson,
        (json) => OrderedScenePart.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      _scene.toJson(Name.toJson, Id.toJson, OrderedScenePart.staticToJson);

  static Map<String, dynamic> staticToJson(Scene scene) => scene.toJson();
}

extension type Place(ImageCollectionResource<BackgroundId, Background> _place)
    implements ImageCollectionResource<BackgroundId, Background> {
  factory Place.fromJson(Map<String, dynamic> json) => Place(
    ImageCollectionResource.fromJson(
      json,
      BackgroundId.fromJson,
      Background.fromJson,
    ),
  );

  static Map<String, dynamic> staticToJson(Place place) => place.toJson();
}

extension type Actor(ImageCollectionResource<PoseId, Pose> _actor)
    implements ImageCollectionResource<PoseId, Pose> {
  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    ImageCollectionResource.fromJson(json, PoseId.fromJson, Pose.fromJson),
  );

  static Map<String, dynamic> staticToJson(Actor actor) => actor.toJson();
}

/* -- Collection Resources -- */

/* ++ Single Resources ++ */

@freezed
abstract class Selection with _$Selection {
  /// We need a private constructor so we can define custom methods inside a class annotated with [freezed].
  const Selection._();

  @Assert(
    'selected == null || options.contains(selected)',
    '[selected] has to be either [null] or contained in the set of [options]!',
  )
  factory Selection({
    required ISet<Option> options,
    required Option? selected,
  }) = _Selection;

  factory Selection.fromJson(Map<String, dynamic> json) =>
      _$SelectionFromJson(json);

  static Map<String, dynamic> staticToJson(Selection selection) =>
      selection.toJson();
}

@Freezed(unionKey: 'type')
sealed class ScenePart with _$ScenePart {
  const factory ScenePart.frame({
    required FullBackgroundId background,
    required IList<FullPoseId> poses,
    required DialogueBox? dialogueBox,
  }) = Frame;

  // TODO: Unimplemented!
  const factory ScenePart.frameResolver() = FrameResolver;

  factory ScenePart.fromJson(Map<String, dynamic> json) =>
      _$ScenePartFromJson(json);
}

extension type Background(ImageResource _background) implements ImageResource {
  static Background fromJson(Object? json) =>
      Background(ImageResource.fromJson(json as Map<String, dynamic>));
}

extension type Pose(ImageResource _pose) implements ImageResource {
  static Pose fromJson(Object? json) =>
      Pose(ImageResource.fromJson(json as Map<String, dynamic>));
}

/* -- Single Resources -- */

/* ++ Selection Parts ++ */

extension type Option(String _option) implements String {}

enum SelectionError implements Exception {
  invalidOption(
    "[selected] has to be either [null] or contained in the set of [options]!",
  );

  final String message;

  const SelectionError(this.message);

  @override
  String toString() => message;
}

/* -- Selection Parts -- */

/* ++ ScenePart Parts ++ */

@freezed
abstract class DialogueBox with _$DialogueBox {
  const factory DialogueBox({required String? name, required String dialogue}) =
      _DialogueBox;

  factory DialogueBox.fromJson(Map<String, dynamic> json) =>
      _$DialogueBoxFromJson(json);
}

@freezed
abstract class OrderedScenePart with _$OrderedScenePart {
  const factory OrderedScenePart({
    required double order,
    required ScenePart part,
  }) = _OrderedScenePart;

  factory OrderedScenePart.fromJson(Map<String, dynamic> json) =>
      _$OrderedScenePartFromJson(json);

  static Map<String, dynamic> staticToJson(OrderedScenePart part) =>
      part.toJson();
}

/* -- ScenePart Parts -- */

/* ++ Resources ++ */

/* ++ Ids ++ */

extension type Name(String _name) implements String {
  static Name fromJson(Object? json) => Name(json! as String);
  static String toJson(Name name) => name._name;
}

extension type Id(String _id) implements String {
  static final uuid = Uuid();

  static Id create() {
    return Id(uuid.v4());
  }

  static Id fromJson(Object? json) => Id(json! as String);
  static String toJson(Id id) => id;

  static const String jsonExtension = ".json";

  static CrossFilesystemName toFilename(Id id) =>
      CrossFilesystemName("$id$jsonExtension");
  static Id fromFilename(CrossFilesystemName filename) {
    if (!filename.endsWith(jsonExtension)) {
      throw FormatException(
        "Expected a $jsonExtension file, but got: $filename",
      );
    }

    return Id(filename.substring(0, filename.length - jsonExtension.length));
  }
}

extension type SelectionId(Id _id) implements Id {
  static SelectionId fromJson(Object? json) => SelectionId(Id.fromJson(json));
}

extension type SceneId(Id _id) implements Id {
  static SceneId fromJson(Object? json) => SceneId(Id.fromJson(json));

  static SceneId fromFilename(CrossFilesystemName filename) =>
      SceneId(Id.fromFilename(filename));
}

extension type PlaceId(Id _id) implements Id {
  static PlaceId fromJson(Object? json) => PlaceId(Id.fromJson(json));

  static PlaceId fromFilename(CrossFilesystemName filename) =>
      PlaceId(Id.fromFilename(filename));
}

extension type ActorId(Id _id) implements Id {
  static ActorId fromJson(Object? json) => ActorId(Id.fromJson(json));

  static ActorId fromFilename(CrossFilesystemName filename) =>
      ActorId(Id.fromFilename(filename));
}

extension type ScenePartId(Id _id) implements Id {
  static ScenePartId fromJson(Object? json) => ScenePartId(Id.fromJson(json));
}

extension type BackgroundId(Id _id) implements Id {
  static BackgroundId fromJson(Object? json) => BackgroundId(Id.fromJson(json));
}

extension type PoseId(Id _id) implements Id {
  static PoseId fromJson(Object? json) => PoseId(Id.fromJson(json));
}

/// Why is this an extension type of [Resource<Id, Id>] you ask?
/// Well, it's really just because I was lazy and I saw that they have the same struct shape anyways.
/// And as a bonus, you can think of the [metadata] as the collection id, and the [value] inside it as the item id,
/// And that makes sense because [metadata] is data about [value].
extension type FullId<ParentId extends Id, ChildId extends Id, Child>(
  Resource<ParentId, ChildId> _fullId
)
    implements Resource<ParentId, ChildId> {
  ParentId get parentId => metadata;
  ChildId get childId => value;

  factory FullId.fromJson(
    Map<String, dynamic> json,
    ParentId Function(Object? json) parentIdFromJson,
    ChildId Function(Object? json) childIdFromJson,
  ) => FullId(Resource.fromJson(json, parentIdFromJson, childIdFromJson));

  Map<String, dynamic> toJson() => _fullId.toJson(Id.toJson, Id.toJson);

  Child? findIn(
    Collection<ParentId, CollectionResource<Name, ChildId, Child>>
    resourceCollection,
  ) {
    return resourceCollection.find(parentId)?.find(childId);
  }
}

extension type FullScenePartId(FullId<SceneId, ScenePartId, ScenePart> _fullId)
    implements FullId<SceneId, ScenePartId, ScenePart> {
  factory FullScenePartId.fromJson(Map<String, dynamic> json) =>
      FullScenePartId(
        FullId.fromJson(json, SceneId.fromJson, ScenePartId.fromJson),
      );
}

extension type FullBackgroundId(
  FullId<PlaceId, BackgroundId, Background> _fullId
)
    implements FullId<PlaceId, BackgroundId, Background> {
  factory FullBackgroundId.fromJson(Map<String, dynamic> json) =>
      FullBackgroundId(
        FullId.fromJson(json, PlaceId.fromJson, BackgroundId.fromJson),
      );
}

extension type FullPoseId(FullId<ActorId, PoseId, Pose> _fullId)
    implements FullId<ActorId, PoseId, Pose> {
  factory FullPoseId.fromJson(Map<String, dynamic> json) =>
      FullPoseId(FullId.fromJson(json, ActorId.fromJson, PoseId.fromJson));
}

/* -- Ids -- */

@Freezed(genericArgumentFactories: true)
abstract class Resource<Metadata, Value> with _$Resource<Metadata, Value> {
  const factory Resource({required Metadata metadata, required Value value}) =
      _Resource<Metadata, Value>;

  factory Resource.fromJson(
    Map<String, dynamic> json,
    Metadata Function(Object? json) metadataFromJson,
    Value Function(Object? json) valueFromJson,
  ) => _$ResourceFromJson(json, metadataFromJson, valueFromJson);
}

extension type Collection<ItemId extends Id, Item>(
  IMap<ItemId, Item> _collection
)
    implements IMap<ItemId, Item> {
  Item? find(ItemId? id) {
    if (id == null) return null;

    return _collection[id];
  }

  factory Collection.fromJson(
    Map<String, dynamic> json,
    ItemId Function(Object? json) itemIdFromJson,
    Item Function(Object? json) itemFromJson,
  ) {
    return Collection(
      json
          .map(
            (idJson, itemJson) =>
                MapEntry(itemIdFromJson(idJson), itemFromJson(itemJson)),
          )
          .toIMap(),
    );
  }

  Map<String, dynamic> toJson(
    String Function(ItemId id) itemIdToJson,
    Object? Function(Item item) itemToJson,
  ) => _collection.unlock.map(
    (id, item) => MapEntry(itemIdToJson(id), itemToJson(item)),
  );

  CrossFolderData toFolderData(
    CrossFilesystemName Function(ItemId id) itemIdToFilename,
    Object? Function(Item item) itemToJson,
  ) {
    return CrossFolderData(
      children: CrossFolderChildren(
        _collection.unlock.map(
          (itemId, item) => CrossInMemoryFile(
            name: itemIdToFilename(itemId),
            data: CrossFileData.fromJson(itemToJson(item)),
          ),
        ),
      ),
    );
  }

  static Collection<ItemId, Item> fromFolderData<ItemId extends Id, Item>(
    CrossFolderData data,
    ItemId Function(CrossFilesystemName json) itemIdFromFilename,
    Item Function(Object? json) itemFromJson,
  ) {
    return Collection(
      data.children
          .map(
            (itemId, item) => MapEntry(
              itemIdFromFilename(itemId),
              itemFromJson((item as CrossFileData).toJson()),
            ),
          )
          .toIMap(),
    );
  }
}

extension type CollectionResource<Metadata, ItemId extends Id, Item>(
  Resource<Metadata, Collection<ItemId, Item>> _resourceCollection
)
    implements Resource<Metadata, IMap<ItemId, Item>> {
  Item? find(ItemId? id) {
    if (id == null) {
      return null;
    }

    return _resourceCollection.value[id];
  }

  factory CollectionResource.fromJson(
    Map<String, dynamic> json,
    Metadata Function(Object? json) metadataFromJson,
    ItemId Function(Object? json) itemIdFromJson,
    Item Function(Object? json) itemFromJson,
  ) {
    return CollectionResource(
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

/// This isn't an extension type because I needed to override its [toString] implementation!
/// Without the override, it tries to print all the image's bytes in the terminal, which slows everything down.
class ImageData {
  final Uint8List image;

  ImageData({required this.image});

  static ImageData fromJson(Object? json) =>
      ImageData(image: base64Decode(json! as String));
  static String toJson(ImageData image) => base64Encode(image.image);

  @override
  String toString() {
    return "[Image]";
  }
}

extension type ImageResource(Resource<Name, ImageData> _resource)
    implements Resource<Name, ImageData> {
  factory ImageResource.fromJson(Map<String, dynamic> json) =>
      ImageResource(Resource.fromJson(json, Name.fromJson, ImageData.fromJson));

  Map<String, dynamic> toJson() =>
      _resource.toJson(Name.toJson, ImageData.toJson);

  static Map<String, dynamic> staticToJson(ImageResource resource) =>
      resource.toJson();
}

extension type ImageCollectionResource<
  ImageId extends Id,
  ImageItem extends ImageResource
>(CollectionResource<Name, ImageId, ImageItem> _imageCollection)
    implements CollectionResource<Name, ImageId, ImageItem> {
  factory ImageCollectionResource.fromJson(
    Map<String, dynamic> json,
    ImageId Function(Object? json) idFromJson,
    ImageItem Function(Object? json) itemFromJson,
  ) {
    return ImageCollectionResource(
      CollectionResource.fromJson(
        json,
        Name.fromJson,
        idFromJson,
        itemFromJson,
      ),
    );
  }

  Map<String, dynamic> toJson() => _imageCollection.toJson(
    Name.toJson,
    Id.toJson,
    ImageResource.staticToJson,
  );
}

/* -- Image Resources -- */

/* -- Resources -- */
