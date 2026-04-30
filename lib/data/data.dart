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

class Selector<Edited, InnerProperty> {
  final InnerProperty Function(Edited) get;
  final Edited Function(Edited, InnerProperty) set;

  Selector(this.get, this.set);

  Edited update(Edited current, InnerProperty Function(InnerProperty) updater) {
    return set(current, updater(get(current)));
  }

  Selector<Edited, InnerInnerProperty> select<InnerInnerProperty>(
    InnerInnerProperty Function(InnerProperty) getInnerInner,
    InnerProperty Function(InnerProperty, InnerInnerProperty) setInner,
  ) {
    return compose(Selector(getInnerInner, setInner));
  }

  Selector<Edited, InnerInnerProperty> compose<InnerInnerProperty>(
    Selector<InnerProperty, InnerInnerProperty> composeWith,
  ) {
    return Selector(
      (edited) => composeWith.get(get(edited)),
      (edited, innerInnerProperty) =>
          set(edited, composeWith.set(get(edited), innerInnerProperty)),
    );
  }
}

extension NullableSelectorExt<Edited, InnerProperty>
    on Selector<Edited, InnerProperty?> {
  Selector<Edited, InnerInnerProperty?> composeNullable<
    InnerInnerProperty,
    SuperProperty
  >(Selector<SuperProperty, InnerInnerProperty?> composeWith) {
    return Selector(
      (edited) {
        final inner = get(edited);

        if (inner == null) return null;

        return composeWith.get(inner as SuperProperty);
      },
      (edited, innerInner) {
        final inner = get(edited);

        if (inner == null) return edited;

        final updatedInner =
            composeWith.set(inner as SuperProperty, innerInner)
                as InnerProperty;

        return set(edited, updatedInner);
      },
    );
  }
}

typedef ValueEditor<T> = Selector<T, T>;

@freezed
abstract class SceneGroup with _$SceneGroup {
  /// We need a private constructor so we can define custom methods inside a class annotated with [freezed].
  const SceneGroup._();

  const factory SceneGroup({
    required Choices choices,
    required Scenes scenes,
    required Places places,
    required Actors actors,
  }) = _SceneGroup;

  static final empty = SceneGroup(
    choices: Choices.empty(),
    scenes: Scenes.empty(),
    places: Places.empty(),
    actors: Actors.empty(),
  );

  ValueEditor<SceneGroup> edit() {
    return Selector((_) => this, (_, newThis) => newThis);
  }

  /// Why are the names defined here instead of their respective types?
  /// Well, think about how you would deserialize them.
  /// You would have to pass in the whole scene group folder to the child so that
  /// it could look for its own name and deserialize itself!
  /// That's why the file names are defined here in [SceneGroup].
  static final choicesName = CrossFilesystemName("choices.json");
  static final scenesName = CrossFilesystemName("scenes");
  static final placesName = CrossFilesystemName("places");
  static final actorsName = CrossFilesystemName("actors");

  static final Selector<SceneGroup, Choices> choicesSelector = Selector(
    (sceneGroup) => sceneGroup.choices,
    (sceneGroup, choices) => sceneGroup.copyWith(choices: choices),
  );

  static final Selector<SceneGroup, Scenes> scenesSelector = Selector(
    (sceneGroup) => sceneGroup.scenes,
    (sceneGroup, scenes) => sceneGroup.copyWith(scenes: scenes),
  );

  static final Selector<SceneGroup, Places> placesSelector = Selector(
    (sceneGroup) => sceneGroup.places,
    (sceneGroup, places) => sceneGroup.copyWith(places: places),
  );

  static final Selector<SceneGroup, Actors> actorsSelector = Selector(
    (sceneGroup) => sceneGroup.actors,
    (sceneGroup, actors) => sceneGroup.copyWith(actors: actors),
  );

  CrossFolderData toFilesystemData() {
    return CrossFolderData(
      children: CrossFolderChildren({
        choicesName: choices.toFilesystemData(),
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
      choices: Choices.fromFilesystemData(
        folderChildren.find(choicesName)! as CrossFileData,
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

extension type Choices.from(Collection<ChoiceResource> choiceCollection)
    implements Collection<ChoiceResource> {
  Choices.empty() : this.from(Collection.empty());

  Choices(IMap<Id<ChoiceResource>, ChoiceResource> choices)
    : this.from(Collection(choices));

  factory Choices.fromJson(Map<String, dynamic> json) {
    return Choices.from(
      Collection.fromJson(
        json,
        (json) => ChoiceResource.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      choiceCollection.toJson(ChoiceResource.staticToJson);

  CrossFileData toFilesystemData() {
    return CrossFileData.fromJson(toJson());
  }

  static Choices fromFilesystemData(CrossFileData data) {
    return Choices.fromJson(data.toJson()! as Map<String, dynamic>);
  }
}

extension type Scenes.from(Collection<Scene> scenes)
    implements Collection<Scene> {
  Scenes.empty() : this.from(Collection.empty());

  Scenes(IMap<Id<Scene>, Scene> scenes) : this.from(Collection(scenes));

  CrossFolderData toFilesystemData() {
    return scenes.toFolderData(Scene.staticToJson);
  }

  static Scenes fromFilesystemData(CrossFolderData data) {
    return Scenes(
      Collection.fromFolderData(
        data,
        (json) => Scene.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }
}

extension type Places.from(Collection<Place> places)
    implements Collection<Place> {
  Places.empty() : this.from(Collection.empty());

  Places(IMap<Id<Place>, Place> places) : this.from(Collection(places));

  CrossFolderData toFilesystemData() {
    return places.toFolderData(Place.staticToJson);
  }

  static Places fromFilesystemData(CrossFolderData data) {
    return Places.from(
      Collection.fromFolderData(
        data,
        (json) => Place.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }
}

extension type Actors.from(Collection<Actor> actors)
    implements Collection<Actor> {
  Actors.empty() : this.from(Collection.empty());

  Actors(IMap<Id<Actor>, Actor> actors) : this.from(Collection(actors));

  CrossFolderData toFilesystemData() {
    return actors.toFolderData(Actor.staticToJson);
  }

  static Actors fromFilesystemData(CrossFolderData data) {
    return Actors(
      Collection.fromFolderData(
        data,
        (json) => Actor.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }
}

/* -- Resource Collections -- */

/* ++ Collection Resources ++ */

extension type ChoiceResource.from(Resource<Name, Choice> resource)
    implements Resource<Name, Choice> {
  ChoiceResource({
    required String name,
    required ISet<Option> options,
    required Option? selected,
  }) : this.fromChoice(
         name: name,
         choice: Choice(options: options, selected: selected),
       );

  ChoiceResource.fromChoice({required String name, required Choice choice})
    : this.from(Resource(metadata: Name(name), value: choice));

  factory ChoiceResource.fromJson(Map<String, dynamic> json) =>
      ChoiceResource.from(
        Resource.fromJson(
          json,
          Name.fromJson,
          (json) => Choice.fromJson(json! as Map<String, dynamic>),
        ),
      );

  Map<String, dynamic> toJson() =>
      resource.toJson(Name.toJson, Choice.staticToJson);

  static Map<String, dynamic> staticToJson(ChoiceResource choice) =>
      choice.toJson();
}

extension type Scene.from(CollectionResource<OrderedScenePart> scene)
    implements CollectionResource<OrderedScenePart> {
  Scene({
    required Name name,
    required IMap<Id<OrderedScenePart>, OrderedScenePart> parts,
  }) : this.fromParts(name: name, parts: Collection(parts));

  Scene.fromParts({
    required Name name,
    required Collection<OrderedScenePart> parts,
  }) : this.from(CollectionResource(metadata: name, value: parts));

  factory Scene.fromJson(Map<String, dynamic> json) {
    return Scene.from(
      CollectionResource.fromJson(
        json,
        (json) => OrderedScenePart.fromJson(json! as Map<String, dynamic>),
      ),
    );
  }

  Map<String, dynamic> toJson() => scene.toJson(OrderedScenePart.staticToJson);

  static Map<String, dynamic> staticToJson(Scene scene) => scene.toJson();
}

extension type Place.from(ImageCollectionResource<Background> place)
    implements ImageCollectionResource<Background> {
  Place({
    required Name name,
    required IMap<Id<Background>, Background> backgrounds,
  }) : this.fromBackgrounds(name: name, backgrounds: Collection(backgrounds));

  Place.fromBackgrounds({
    required Name name,
    required Collection<Background> backgrounds,
  }) : this.from(ImageCollectionResource(name: name, images: backgrounds));

  factory Place.fromJson(Map<String, dynamic> json) =>
      Place.from(ImageCollectionResource.fromJson(json, Background.fromJson));

  static Map<String, dynamic> staticToJson(Place place) => place.toJson();
}

extension type Actor.from(ImageCollectionResource<Pose> actor)
    implements ImageCollectionResource<Pose> {
  Actor({required Name name, required IMap<Id<Pose>, Pose> poses})
    : this.fromPoses(name: name, poses: Collection(poses));

  Actor.fromPoses({required Name name, required Collection<Pose> poses})
    : this.from(ImageCollectionResource(name: name, images: poses));

  factory Actor.fromJson(Map<String, dynamic> json) =>
      Actor.from(ImageCollectionResource.fromJson(json, Pose.fromJson));

  static Map<String, dynamic> staticToJson(Actor actor) => actor.toJson();
}

/* -- Collection Resources -- */

/* ++ Single Resources ++ */

@freezed
abstract class Choice with _$Choice {
  /// We need a private constructor so we can define custom methods inside a class annotated with [freezed].
  const Choice._();

  @Assert(
    'selected == null || options.contains(selected)',
    '[selected] has to be either [null] or contained in the set of [options]!',
  )
  factory Choice({required ISet<Option> options, required Option? selected}) =
      _Choice;

  static final Selector<Choice, ISet<Option>> optionsSelector = Selector(
    (choice) => choice.options,
    (choice, options) => choice.copyWith(options: options),
  );

  static final Selector<Choice, Option?> choiceSelector = Selector(
    (choice) => choice.selected,
    (choice, selected) => choice.copyWith(selected: selected),
  );

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

  static Map<String, dynamic> staticToJson(Choice choice) => choice.toJson();
}

@Freezed(unionKey: 'type')
sealed class ScenePart with _$ScenePart {
  const factory ScenePart.frame({
    required FullId<Background>? background,
    required IList<FullId<Pose>> poses,
    required DialogueBox? dialogueBox,
  }) = Frame;

  // TODO: Unimplemented!
  const factory ScenePart.frameResolver() = FrameResolver;

  factory ScenePart.fromJson(Map<String, dynamic> json) =>
      _$ScenePartFromJson(json);
}

extension type Background.from(ImageResource _background)
    implements ImageResource {
  Background({required Name name, required ImageData image})
    : this.from(ImageResource(name: name, image: image));

  static Background fromJson(Object? json) =>
      Background.from(ImageResource.fromJson(json as Map<String, dynamic>));
}

extension type Pose.from(ImageResource _pose) implements ImageResource {
  Pose({required Name name, required ImageData image})
    : this.from(ImageResource(name: name, image: image));

  static Pose fromJson(Object? json) =>
      Pose.from(ImageResource.fromJson(json as Map<String, dynamic>));
}

/* -- Single Resources -- */

/* ++ Choice Parts ++ */

extension type Option(String _option) implements String {}

enum ChoiceError implements Exception {
  invalidOption(
    "[selected] has to be either [null] or contained in the set of [options]!",
  );

  final String message;

  const ChoiceError(this.message);

  @override
  String toString() => message;
}

/* -- Choices Parts -- */

/* ++ ScenePart Parts ++ */

@freezed
abstract class DialogueBox with _$DialogueBox {
  const DialogueBox._();

  const factory DialogueBox({required String? name, required String dialogue}) =
      _DialogueBox;

  static final Selector<DialogueBox, String?> nameSelector = Selector(
    (dialogueBox) => dialogueBox.name,
    (dialogueBox, name) => dialogueBox.copyWith(name: name),
  );

  static final Selector<DialogueBox, String> dialogueSelector = Selector(
    (dialogueBox) => dialogueBox.dialogue,
    (dialogueBox, dialogue) => dialogueBox.copyWith(dialogue: dialogue),
  );

  factory DialogueBox.fromJson(Map<String, dynamic> json) =>
      _$DialogueBoxFromJson(json);
}

@freezed
abstract class OrderedScenePart with _$OrderedScenePart {
  const OrderedScenePart._();

  const factory OrderedScenePart({
    required double order,
    required ScenePart part,
  }) = _OrderedScenePart;

  Selector<OrderedScenePart, double> get orderSelector => Selector(
    (orderedPart) => orderedPart.order,
    (orderedPart, order) => orderedPart.copyWith(order: order),
  );

  Selector<OrderedScenePart, ScenePart> get partSelector => Selector(
    (orderedPart) => orderedPart.part,
    (orderedPart, part) => orderedPart.copyWith(part: part),
  );

  factory OrderedScenePart.fromJson(Map<String, dynamic> json) =>
      _$OrderedScenePartFromJson(json);

  static Map<String, dynamic> staticToJson(OrderedScenePart part) =>
      part.toJson();
}

/* -- ScenePart Parts -- */

/* ++ Resources ++ */

/* ++ Ids ++ */

extension type Name(String name) implements String {
  static Name fromJson(Object? json) => Name(json! as String);
  static String toJson(Name name) => name.name;
}

extension type Id<T>(String id) implements String {
  static final uuid = Uuid();

  static Id<T> create<T>() {
    return Id(uuid.v4());
  }

  static Id<T> fromJson<T>(Object? json) => Id(json! as String);
  static String toJson<T>(Id<T> id) => id;

  static const String jsonExtension = ".json";

  static CrossFilesystemName toFilename<T>(Id<T> id) =>
      CrossFilesystemName("$id$jsonExtension");
  static Id<T> fromFilename<T>(CrossFilesystemName filename) {
    if (!filename.endsWith(jsonExtension)) {
      throw FormatException(
        "Expected a $jsonExtension file, but got: $filename",
      );
    }

    return Id(filename.substring(0, filename.length - jsonExtension.length));
  }
}

/// Why is this an extension type of [Resource<Id, Id>] you ask?
/// Well, it's really just because I was lazy and I saw that they have the same struct shape anyways.
/// And as a bonus, you can think of the [metadata] as the collection id, and the [value] inside it as the item id,
/// And that makes sense because [metadata] is data about [value].
extension type FullId<Child>.from(
  Resource<Id<CollectionResource<Child>>, Id<Child>> fullId
)
    implements Resource<Id<CollectionResource<Child>>, Id<Child>> {
  FullId({
    required Id<CollectionResource<Child>> parentId,
    required Id<Child> childId,
  }) : this.from(Resource(metadata: parentId, value: childId));

  Id<CollectionResource<Child>> get parentId => metadata;
  Id<Child> get childId => value;

  factory FullId.fromJson(Map<String, dynamic> json) => FullId.from(
    Resource.fromJson(
      json,
      Id.fromJson<CollectionResource<Child>>,
      Id.fromJson<Child>,
    ),
  );

  Map<String, dynamic> toJson() => fullId.toJson(Id.toJson, Id.toJson);

  Selector<Collection<CollectionResource<Child>>, Child?> childSelector() {
    return Collection.childSelector<CollectionResource<Child>>(
      parentId,
    ).composeNullable(CollectionResource.childSelector<Child>(childId));
  }

  Child? findIn(Collection<CollectionResource<Child>> resourceCollection) {
    return resourceCollection.find(parentId)?.find(childId);
  }
}

/* -- Ids -- */

@Freezed(genericArgumentFactories: true)
abstract class Resource<Metadata, Value> with _$Resource<Metadata, Value> {
  const Resource._();

  const factory Resource({required Metadata metadata, required Value value}) =
      _Resource<Metadata, Value>;

  static Selector<Resource<Metadata, Value>, Metadata>
  metadataSelector<Metadata, Value>() => Selector(
    (resource) => resource.metadata,
    (resource, metadata) => resource.copyWith(metadata: metadata),
  );

  static Selector<Resource<Metadata, Value>, Value>
  valueSelector<Metadata, Value>() => Selector(
    (resource) => resource.value,
    (resource, value) => resource.copyWith(value: value),
  );

  factory Resource.fromJson(
    Map<String, dynamic> json,
    Metadata Function(Object? json) metadataFromJson,
    Value Function(Object? json) valueFromJson,
  ) => _$ResourceFromJson(json, metadataFromJson, valueFromJson);
}

extension type Collection<Item>(IMap<Id<Item>, Item> collection)
    implements IMap<Id<Item>, Item> {
  static Selector<Collection<Item>, Item?> childSelector<Item>(Id<Item>? id) {
    return Selector((collection) => collection.find(id), (collection, item) {
      if (id == null) return collection;

      return Collection(
        item == null ? collection.remove(id) : collection.add(id, item),
      );
    });
  }

  Item? find(Id<Item>? id) {
    if (id == null) return null;
    return collection[id];
  }

  Collection.empty() : this(IMap());

  factory Collection.fromJson(
    Map<String, dynamic> json,
    Item Function(Object? json) itemFromJson,
  ) {
    return Collection(
      json
          .map(
            (idJson, itemJson) =>
                MapEntry(Id.fromJson<Item>(idJson), itemFromJson(itemJson)),
          )
          .toIMap(),
    );
  }

  Map<String, dynamic> toJson(Object? Function(Item item) itemToJson) =>
      collection.unlock.map(
        (id, item) => MapEntry(Id.toJson(id), itemToJson(item)),
      );

  CrossFolderData toFolderData(Object? Function(Item item) itemToJson) {
    return CrossFolderData(
      children: CrossFolderChildren(
        collection.unlock.map(
          (itemId, item) => CrossInMemoryFile(
            name: Id.toFilename(itemId),
            data: CrossFileData.fromJson(itemToJson(item)),
          ),
        ),
      ),
    );
  }

  static Collection<Item> fromFolderData<Item>(
    CrossFolderData data,
    Item Function(Object? json) itemFromJson,
  ) {
    return Collection(
      data.children
          .map(
            (itemId, item) => MapEntry(
              Id.fromFilename<Item>(itemId),
              itemFromJson((item as CrossFileData).toJson()),
            ),
          )
          .toIMap(),
    );
  }
}

extension type CollectionResource<Item>.from(
  Resource<Name, Collection<Item>> collectionResource
)
    implements Resource<Name, Collection<Item>> {
  CollectionResource({required Name metadata, required Collection<Item> value})
    : this.from(Resource(metadata: metadata, value: value));

  CollectionResource.fromMap({
    required Name metadata,
    required IMap<Id<Item>, Item> value,
  }) : this(metadata: metadata, value: Collection(value));

  static Selector<CollectionResource<Item>, Item?> childSelector<Item>(
    Id<Item>? id,
  ) {
    return Selector((collection) => collection.find(id), (
      collectionResource,
      item,
    ) {
      if (id == null) return collectionResource;

      return collectionResource.copyWith(
            value: Collection(
              (item == null)
                  ? collectionResource.value.remove(id)
                  : collectionResource.value.add(id, item),
            ),
          )
          as CollectionResource<Item>;
    });
  }

  Item? find(Id<Item>? id) {
    return collectionResource.value.find(id);
  }

  factory CollectionResource.fromJson(
    Map<String, dynamic> json,
    Item Function(Object? json) itemFromJson,
  ) {
    return CollectionResource.from(
      Resource.fromJson(
        json,
        Name.fromJson,
        (json) => Collection.fromJson(
          json! as Map<String, dynamic>,
          // itemIdFromJson,
          itemFromJson,
        ),
      ),
    );
  }

  Map<String, dynamic> toJson(Object? Function(Item item) itemToJson) =>
      collectionResource.toJson(
        Name.toJson,
        (collection) => collection.toJson(itemToJson),
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

extension type ImageResource.from(Resource<Name, ImageData> resource)
    implements Resource<Name, ImageData> {
  ImageResource({required Name name, required ImageData image})
    : this.from(Resource(metadata: name, value: image));

  factory ImageResource.fromJson(Map<String, dynamic> json) =>
      ImageResource.from(
        Resource.fromJson(json, Name.fromJson, ImageData.fromJson),
      );

  Map<String, dynamic> toJson() =>
      resource.toJson(Name.toJson, ImageData.toJson);

  static Map<String, dynamic> staticToJson(ImageResource resource) =>
      resource.toJson();
}

extension type ImageCollectionResource<ImageItem extends ImageResource>.from(
  CollectionResource<ImageItem> imageCollection
)
    implements CollectionResource<ImageItem> {
  ImageCollectionResource({
    required Name name,
    required Collection<ImageItem> images,
  }) : this.from(CollectionResource(metadata: name, value: images));

  factory ImageCollectionResource.fromJson(
    Map<String, dynamic> json,
    ImageItem Function(Object? json) itemFromJson,
  ) {
    return ImageCollectionResource.from(
      CollectionResource.fromJson(json, itemFromJson),
    );
  }

  Map<String, dynamic> toJson() =>
      imageCollection.toJson(ImageResource.staticToJson);
}

/* -- Image Resources -- */

/* -- Resources -- */
