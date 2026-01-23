import 'dart:convert';
import "dart:typed_data";

import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prac_res/archive.dart';
import 'package:result_type/result_type.dart';

part 'data.freezed.dart';
part "data.g.dart";

/* ++ Resources ++ */

abstract interface class IntoJson {
  Map<String, dynamic> toJson();
}

class BinaryConverter implements JsonConverter<Uint8List, String> {
  const BinaryConverter();

  static Uint8List staticFromJson(String json) => base64Decode(json);
  static String staticToJson(Uint8List bytes) => base64Encode(bytes);

  @override
  Uint8List fromJson(String json) => staticFromJson(json);

  @override
  String toJson(Uint8List bytes) => staticToJson(bytes);
}

class PoseImageConverter implements JsonConverter<PoseImage, String> {
  const PoseImageConverter();

  @override
  PoseImage fromJson(String json) =>
      PoseImage._(Image._(BinaryConverter.staticFromJson(json)));

  @override
  String toJson(PoseImage bytes) => base64Encode(bytes);
}

class BackgroundImageConverter
    implements JsonConverter<BackgroundImage, String> {
  const BackgroundImageConverter();

  @override
  BackgroundImage fromJson(String json) =>
      BackgroundImage._(Image._(BinaryConverter.staticFromJson(json)));

  @override
  String toJson(BackgroundImage bytes) => base64Encode(bytes);
}

extension type Image._(Uint8List bytes) implements Uint8List {}

extension type PoseImage._(Image image) implements Image {}
extension type PoseId._(String id) implements String {}

@JsonSerializable(constructor: "_")
class Pose implements IntoJson {
  final String name;

  @PoseImageConverter()
  final PoseImage image;

  Pose._({required this.name, required this.image});

  factory Pose.fromJson(Map<String, dynamic> json) => _$PoseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PoseToJson(this);
}

Map<PoseId, Pose> _posesFromJson(Map<String, dynamic> json) {
  return json.map(
    (key, value) =>
        MapEntry(PoseId._(key), Pose.fromJson(value as Map<String, dynamic>)),
  );
}

Map<String, dynamic> _posesToJson(Map<PoseId, Pose> poses) {
  return poses.map((key, value) => MapEntry(key, value.toJson()));
}

extension type ActorId._(String id) implements String {}

/// Json files of these will be stored in a subfolder called [/actors],
/// and the names of the json files will be the [Actor]'s id.
///
/// This way, we don't have to load all the actors at the same time.
@JsonSerializable(constructor: "_")
class Actor implements IntoJson {
  final String name;

  @JsonKey(toJson: _posesToJson, fromJson: _posesFromJson)
  final Map<PoseId, Pose> poses;

  Actor._({required this.name, required this.poses});

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ActorToJson(this);
}

extension type BackgroundImage._(Image image) implements Image {}

extension type BackgroundId._(String id) implements String {}

@JsonSerializable(constructor: "_")
class Background implements IntoJson {
  final String name;

  @BackgroundImageConverter()
  final BackgroundImage image;

  Background._({required this.name, required this.image});

  factory Background.fromJson(Map<String, dynamic> json) =>
      _$BackgroundFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BackgroundToJson(this);
}

Map<BackgroundId, Background> _backgroundsFromJson(Map<String, dynamic> json) {
  return json.map(
    (key, value) => MapEntry(
      BackgroundId._(key),
      Background.fromJson(value as Map<String, dynamic>),
    ),
  );
}

Map<String, dynamic> _backgroundsToJson(
  Map<BackgroundId, Background> background,
) {
  return background.map((key, value) => MapEntry(key, value.toJson()));
}

extension type PlaceId._(String id) implements String {}

/// Json files of these will be stored in a subfolder called [/places],
/// and the names of the json files will be the [Place]'s id.
///
/// This way, we won't have to load all the places at the same time.
@JsonSerializable(constructor: "_")
class Place implements IntoJson {
  final String name;

  @JsonKey(toJson: _backgroundsToJson, fromJson: _backgroundsFromJson)
  final Map<BackgroundId, Background> backgrounds;

  Place._({required this.name, required this.backgrounds});

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}

/* -- Resources -- */

@JsonSerializable(constructor: "_")
class FullBackgroundId implements IntoJson {
  final PlaceId place;
  final BackgroundId background;

  FullBackgroundId._({required this.place, required this.background});

  factory FullBackgroundId.fromJson(Map<String, dynamic> json) =>
      _$FullBackgroundIdFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FullBackgroundIdToJson(this);
}

@JsonSerializable(constructor: "_")
class FullPoseId implements IntoJson {
  final ActorId actor;
  final PoseId pose;

  FullPoseId._({required this.actor, required this.pose});

  factory FullPoseId.fromJson(Map<String, dynamic> json) =>
      _$FullPoseIdFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FullPoseIdToJson(this);
}

extension type Option._(String option) implements String {}

extension type SelectionId._(String id) implements String {}

enum SelectionError implements Exception {
  invalidOption(
    "[selected] has to be either [null] or contained in the set of [options]!",
  );

  final String errorMessage;

  const SelectionError(this.errorMessage);
}

@JsonSerializable(constructor: "_")
class Selection implements IntoJson {
  final String name;
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
    required String name,
    required Set<Option> options,
    required Option? selected,
  }) {
    return _validate(
      options,
      selected,
    ).map((_) => Selection._(name: name, options: options, selected: selected));
  }

  factory Selection({
    required String name,
    required Set<Option> options,
    required Option? selected,
  }) {
    return create(name: name, options: options, selected: selected).unwrap();
  }

  Selection._({
    required this.name,
    required this.options,
    required this.selected,
  });

  factory Selection.fromJson(Map<String, dynamic> json) =>
      _$SelectionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SelectionToJson(this);
}

Map<SelectionId, Selection> _choicesFromJson(Map<String, dynamic> json) {
  return json.map(
    (key, value) => MapEntry(
      SelectionId._(key),
      Selection.fromJson(value as Map<String, dynamic>),
    ),
  );
}

Map<String, dynamic> _choicesToJson(Map<SelectionId, Selection> poses) {
  return poses.map((key, value) => MapEntry(key, value.toJson()));
}

@JsonSerializable(constructor: "_")
class SaveData implements IntoJson {
  @JsonKey(toJson: _choicesToJson, fromJson: _choicesFromJson)
  final Map<SelectionId, Selection> selections;

  SaveData._({required this.selections});

  factory SaveData.fromJson(Map<String, dynamic> json) =>
      _$SaveDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SaveDataToJson(this);
}

@JsonSerializable(constructor: "_")
class DialogueBox implements IntoJson {
  final String? name;
  final String dialogue;

  DialogueBox._({required this.name, required this.dialogue});

  factory DialogueBox.fromJson(Map<String, dynamic> json) =>
      _$DialogueBoxFromJson(json);

  @override
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
class OrderedScenePart implements IntoJson {
  /// Scene parts are ordered like how Google Docs orders inputs from multiple users with each other.
  /// It's similar to operational transform but simplified!
  final double order;
  final ScenePart part;

  OrderedScenePart._({required this.order, required this.part});

  factory OrderedScenePart.fromJson(Map<String, dynamic> json) =>
      _$OrderedScenePartFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrderedScenePartToJson(this);
}

extension type FrameId._(String id) implements String {}

Map<FrameId, OrderedScenePart> _framesFromJson(Map<String, dynamic> json) {
  return json.map(
    (key, value) => MapEntry(
      FrameId._(key),
      OrderedScenePart.fromJson(value as Map<String, dynamic>),
    ),
  );
}

Map<String, dynamic> _framesToJson(Map<FrameId, OrderedScenePart> poses) {
  return poses.map((key, value) => MapEntry(key, value.toJson()));
}

extension type SceneId._(String id) implements String {}

/// Json files of these will be stored in a subfolder called [/scenes],
/// and the names of the json files will be the [Scene]'s id.
///
/// Scenes can jump to each other with frame resolvers, but that hasn't been implemented yet!
@JsonSerializable(constructor: "_")
class Scene implements IntoJson {
  final String name;
  @JsonKey(toJson: _framesToJson, fromJson: _framesFromJson)
  final Map<FrameId, OrderedScenePart> sceneParts;

  Scene._({required this.name, required this.sceneParts});

  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SceneToJson(this);
}

abstract interface class IntoArchiveItem {
  ArchiveItem toArchiveItem();
}

class Backgrounds {}

// Folder archiveCollection<CollectionItem extends IntoJson>(
//   ArchiveItemName name,
//   Map<String, CollectionItem> children,
// ) {
//   return Folder(
//     name: name,
//     children: [
//       for (final MapEntry(:key, :value) in children.entries)
//         File(name: key, bytes: jsonEncode(object)),
//     ],
//   );
// }

// typedef Backgrounds = Map<BackgroundId, Background>;
// typedef Actors = Map<ActorId, Actor>;
// typedef Scenes = Map<SceneId, Scene>;

// class SceneGroup {
//   final SaveData saveData;
//   final Backgrounds backgrounds;
//   final Actors actors;
//   final Scenes scenes;

//   SceneGroup({
//     required this.saveData,
//     required this.backgrounds,
//     required this.actors,
//     required this.scenes,
//   });

//   Archive toArchiveItem() {
//     return Archive.directory([
//       saveData.toArchiveItem(), // This is a single file
//       backgrounds
//           .toArchiveItem(), // This is a folder of all the background jsons
//       actors.toArchiveItem(), // This is a folder of all the actor jsons
//       scenes.toArchiveItem(), // This is a folder of all the scene jsons
//     ]);
//   }
// }
