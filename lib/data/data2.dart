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

@freezed
class SceneGroup with _$SceneGroup {
  const SceneGroup._();

  const factory SceneGroup({
    required Selections selections,
    required Scenes scenes,
    required Places places,
    required Actors actors,
  }) = _SceneGroup;

  static final empty = SceneGroup(
    selections: Selections(items: Collection(IMap())),
    scenes: Scenes(items: Collection(IMap())),
    places: Places(items: Collection(IMap())),
    actors: Actors(items: Collection(IMap())),
  );

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

  Archive toArchiveData() => ArchiveExtension.fromFolder(toFilesystemData());

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

@freezed
class Scenes with _$Scenes {
  const Scenes._();
  const factory Scenes({required Collection<SceneId, Scene> items}) = _Scenes;

  CrossFolderData toFilesystemData() =>
      items.toFolderData(Id.toFilename, (s) => s.toJson());

  static Scenes fromFilesystemData(CrossFolderData data) => Scenes(
    items: Collection.fromFolderData(
      data,
      SceneId.fromFilename,
      (json) => Scene.fromJson(json! as Map<String, dynamic>),
    ),
  );
}

@freezed
class Places with _$Places {
  const Places._();
  const factory Places({required Collection<PlaceId, Place> items}) = _Places;

  CrossFolderData toFilesystemData() =>
      items.toFolderData(Id.toFilename, (p) => p.toJson());

  static Places fromFilesystemData(CrossFolderData data) => Places(
    items: Collection.fromFolderData(
      data,
      PlaceId.fromFilename,
      (json) => Place.fromJson(json! as Map<String, dynamic>),
    ),
  );
}

@freezed
class Actors with _$Actors {
  const Actors._();
  const factory Actors({required Collection<ActorId, Actor> items}) = _Actors;

  CrossFolderData toFilesystemData() =>
      items.toFolderData(Id.toFilename, (a) => a.toJson());

  static Actors fromFilesystemData(CrossFolderData data) => Actors(
    items: Collection.fromFolderData(
      data,
      ActorId.fromFilename,
      (json) => Actor.fromJson(json! as Map<String, dynamic>),
    ),
  );
}

/* -- Resource Collections -- */

/* ++ Collection Resources ++ */

@freezed
class SelectionResource with _$SelectionResource {
  const SelectionResource._();
  const factory SelectionResource({
    required Resource<Name, Selection> resource,
  }) = _SelectionResource;

  factory SelectionResource.fromJson(Map<String, dynamic> json) =>
      SelectionResource(
        resource: Resource.fromJson(
          json,
          Name.fromJson,
          (json) => Selection.fromJson(json! as Map<String, dynamic>),
        ),
      );

  Map<String, dynamic> toJson() =>
      resource.toJson(Name.toJson, (s) => s.toJson());
}

@freezed
class Scene with _$Scene {
  const Scene._();
  const factory Scene({
    required CollectionResource<Name, ScenePartId, OrderedScenePart> data,
  }) = _Scene;

  factory Scene.fromJson(Map<String, dynamic> json) => Scene(
    data: CollectionResource.fromJson(
      json,
      Name.fromJson,
      ScenePartId.fromJson,
      (json) => OrderedScenePart.fromJson(json! as Map<String, dynamic>),
    ),
  );

  Map<String, dynamic> toJson() =>
      data.toJson(Name.toJson, Id.toJson, (p) => p.toJson());
}

@freezed
class Place with _$Place {
  const Place._();
  const factory Place({
    required ImageCollectionResource<BackgroundId, Background> data,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    data: ImageCollectionResource.fromJson(
      json,
      BackgroundId.fromJson,
      Background.fromJson,
    ),
  );

  Map<String, dynamic> toJson() => data.toJson();
}

@freezed
class Actor with _$Actor {
  const Actor._();
  const factory Actor({required ImageCollectionResource<PoseId, Pose> data}) =
      _Actor;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    data: ImageCollectionResource.fromJson(
      json,
      PoseId.fromJson,
      Pose.fromJson,
    ),
  );

  Map<String, dynamic> toJson() => data.toJson();
}

/* -- Collection Resources -- */

/* ++ Single Resources ++ */

@freezed
class Selection with _$Selection {
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
}

@Freezed(unionKey: 'type')
sealed class ScenePart with _$ScenePart {
  const factory ScenePart.frame({
    required FullBackgroundId background,
    required IList<FullPoseId> poses,
    required DialogueBox? dialogueBox,
  }) = Frame;

  const factory ScenePart.frameResolver() = FrameResolver;

  factory ScenePart.fromJson(Map<String, dynamic> json) =>
      _$ScenePartFromJson(json);
}

@freezed
class Background with _$Background {
  const factory Background({required ImageResource resource}) = _Background;

  static Background fromJson(Object? json) => Background(
    resource: ImageResource.fromJson(json as Map<String, dynamic>),
  );
}

@freezed
class Pose with _$Pose {
  const factory Pose({required ImageResource resource}) = _Pose;

  static Pose fromJson(Object? json) =>
      Pose(resource: ImageResource.fromJson(json as Map<String, dynamic>));
}

/* -- Single Resources -- */

/* ++ Selection Parts ++ */

extension type Option(String _option) implements String {}

/* ++ ScenePart Parts ++ */

@freezed
class DialogueBox with _$DialogueBox {
  const factory DialogueBox({required String? name, required String dialogue}) =
      _DialogueBox;

  factory DialogueBox.fromJson(Map<String, dynamic> json) =>
      _$DialogueBoxFromJson(json);
}

@freezed
class OrderedScenePart with _$OrderedScenePart {
  const factory OrderedScenePart({
    required double order,
    required ScenePart part,
  }) = _OrderedScenePart;

  factory OrderedScenePart.fromJson(Map<String, dynamic> json) =>
      _$OrderedScenePartFromJson(json);
}

/* -- ScenePart Parts -- */

/* ++ IDs (Stay as Extension Types) ++ */

extension type Name(String _name) implements String {
  static Name fromJson(Object? json) => Name(json! as String);
  static String toJson(Name name) => name._name;
}

extension type Id(String _id) implements String {
  static final uuid = Uuid();
  static Id create() => Id(uuid.v4());
  static Id fromJson(Object? json) => Id(json! as String);
  static String toJson(Id id) => id;

  static const String jsonExtension = ".json";
  static CrossFilesystemName toFilename(Id id) =>
      CrossFilesystemName("$id$jsonExtension");
  static Id fromFilename(CrossFilesystemName filename) {
    if (!filename.endsWith(jsonExtension)) {
      throw FormatException("Expected a $jsonExtension file: $filename");
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

/* ++ Full IDs ++ */

@Freezed(genericArgumentFactories: true)
class FullId<ParentId extends Id, ChildId extends Id, Child>
    with _$FullId<ParentId, ChildId, Child> {
  const FullId._();
  const factory FullId({required Resource<ParentId, ChildId> resource}) =
      _FullId<ParentId, ChildId, Child>;

  ParentId get parentId => resource.metadata;
  ChildId get childId => resource.value;

  factory FullId.fromJson(
    Map<String, dynamic> json,
    ParentId Function(Object? json) parentIdFromJson,
    ChildId Function(Object? json) childIdFromJson,
  ) => FullId(
    resource: Resource.fromJson(json, parentIdFromJson, childIdFromJson),
  );

  Map<String, dynamic> toJson() => resource.toJson(Id.toJson, Id.toJson);
}

// Specializations of FullId
typedef FullScenePartId = FullId<SceneId, ScenePartId, ScenePart>;
typedef FullBackgroundId = FullId<PlaceId, BackgroundId, Background>;
typedef FullPoseId = FullId<ActorId, PoseId, Pose>;

/* -- Ids -- */

@Freezed(genericArgumentFactories: true)
class Resource<Metadata, Value> with _$Resource<Metadata, Value> {
  const factory Resource({required Metadata metadata, required Value value}) =
      _Resource<Metadata, Value>;

  factory Resource.fromJson(
    Map<String, dynamic> json,
    Metadata Function(Object? json) metadataFromJson,
    Value Function(Object? json) valueFromJson,
  ) => _$ResourceFromJson(json, metadataFromJson, valueFromJson);
}

@Freezed(genericArgumentFactories: true)
class Collection<ItemId extends Id, Item> with _$Collection<ItemId, Item> {
  const Collection._();
  const factory Collection({required IMap<ItemId, Item> items}) =
      _Collection<ItemId, Item>;

  Item? find(ItemId? id) => id == null ? null : items[id];

  factory Collection.fromJson(
    Map<String, dynamic> json,
    ItemId Function(Object? json) itemIdFromJson,
    Item Function(Object? json) itemFromJson,
  ) {
    return Collection(
      items: json
          .map((k, v) => MapEntry(itemIdFromJson(k), itemFromJson(v)))
          .toIMap(),
    );
  }

  Map<String, dynamic> toJson(
    String Function(ItemId id) itemIdToJson,
    Object? Function(Item item) itemToJson,
  ) => items.unlock.map((k, v) => MapEntry(itemIdToJson(k), itemToJson(v)));

  CrossFolderData toFolderData(
    CrossFilesystemName Function(ItemId id) itemIdToFilename,
    Object? Function(Item item) itemToJson,
  ) {
    return CrossFolderData(
      children: CrossFolderChildren(
        items.unlock.map(
          (id, item) => CrossInMemoryFile(
            name: itemIdToFilename(id),
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
      items: data.children
          .map(
            (k, v) => MapEntry(
              itemIdFromFilename(k),
              itemFromJson((v as CrossFileData).toJson()),
            ),
          )
          .toIMap(),
    );
  }
}

@Freezed(genericArgumentFactories: true)
class CollectionResource<Metadata, ItemId extends Id, Item>
    with _$CollectionResource<Metadata, ItemId, Item> {
  const CollectionResource._();
  const factory CollectionResource({
    required Resource<Metadata, Collection<ItemId, Item>> resourceCollection,
  }) = _CollectionResource<Metadata, ItemId, Item>;

  Item? find(ItemId? id) =>
      id == null ? null : resourceCollection.value.find(id);

  factory CollectionResource.fromJson(
    Map<String, dynamic> json,
    Metadata Function(Object? json) metadataFromJson,
    ItemId Function(Object? json) itemIdFromJson,
    Item Function(Object? json) itemFromJson,
  ) {
    return CollectionResource(
      resourceCollection: Resource.fromJson(
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
  ) => resourceCollection.toJson(
    metadataToJson,
    (col) => col.toJson(itemIdToJson, itemToJson),
  );
}

/* ++ Image Resources ++ */

class ImageData {
  final Uint8List image;
  ImageData({required this.image});

  static ImageData fromJson(Object? json) =>
      ImageData(image: base64Decode(json! as String));
  static String toJson(ImageData image) => base64Encode(image.image);

  @override
  String toString() => "[Image]";
}

@freezed
class ImageResource with _$ImageResource {
  const ImageResource._();
  const factory ImageResource({required Resource<Name, ImageData> resource}) =
      _ImageResource;

  factory ImageResource.fromJson(Map<String, dynamic> json) => ImageResource(
    resource: Resource.fromJson(json, Name.fromJson, ImageData.fromJson),
  );

  Map<String, dynamic> toJson() =>
      resource.toJson(Name.toJson, ImageData.toJson);
}

@freezed
class ImageCollectionResource<ImageId extends Id, ImageItem>
    with _$ImageCollectionResource<ImageId, ImageItem> {
  const ImageCollectionResource._();
  const factory ImageCollectionResource({
    required CollectionResource<Name, ImageId, ImageItem> collection,
  }) = _ImageCollectionResource<ImageId, ImageItem>;

  factory ImageCollectionResource.fromJson(
    Map<String, dynamic> json,
    ImageId Function(Object? json) idFromJson,
    ImageItem Function(Object? json) itemFromJson,
  ) => ImageCollectionResource(
    collection: CollectionResource.fromJson(
      json,
      Name.fromJson,
      idFromJson,
      itemFromJson,
    ),
  );

  Map<String, dynamic> toJson() =>
      collection.toJson(Name.toJson, Id.toJson, (item) {
        // Dynamic check for nested toJson if needed, or cast to expected type
        if (item is Background) return item.resource.toJson();
        if (item is Pose) return item.resource.toJson();
        return (item as dynamic).toJson();
      });
}
