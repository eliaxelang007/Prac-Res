import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part "new.data.g.dart";

@JsonSerializable(genericArgumentFactories: true, constructor: "_")
class Resource<Metadata, Value> {
  final Metadata metadata;
  final Value value;

  Resource._({required this.metadata, required this.value});

  factory Resource.fromJson(
    Map<String, dynamic> json,
    Metadata Function(Object? json) fromJsonMetadata,
    Value Function(Object? json) fromJsonValue,
  ) => _$ResourceFromJson(json, fromJsonMetadata, fromJsonValue);

  Map<String, dynamic> toJson(
    Object? Function(Metadata value) toJsonMetadata,
    Object? Function(Value value) toJsonValue,
  ) => _$ResourceToJson(this, toJsonMetadata, toJsonValue);
}

// class BinaryConverter implements JsonConverter<Uint8List, String> {
//   const BinaryConverter();

//   static Uint8List staticFromJson(String json) => base64Decode(json);
//   static String staticToJson(Uint8List bytes) => base64Encode(bytes);

//   @override
//   Uint8List fromJson(String json) => staticFromJson(json);

//   @override
//   String toJson(Uint8List bytes) => staticToJson(bytes);
// }

extension type Name._(String _value) implements String {
  static Name fromJson(Object? json) => Name._(json! as String);
  static String toJson(Name name) => name._value;
}
extension type Image._(Uint8List _bytes) implements Uint8List {
  static Image fromJson(Object? json) => Image._(base64Decode(json! as String));
  static String toJson(Image image) => base64Encode(image);
}

extension type ImageResource._(Resource<Name, Image> _resource)
    implements Resource<Name, Image> {
  factory ImageResource.fromJson(Map<String, dynamic> json) =>
      ImageResource._(Resource.fromJson(json, Name.fromJson, Image.fromJson));

  Map<String, dynamic> toJson() => _resource.toJson(Name.toJson, Image.toJson);
}

extension type Id._(String _id) implements String {}

extension type ImageResourceCollection._(
  Resource<Name, Map<Id, ImageResource>> _collection
)
    implements Resource<Name, Map<Id, ImageResource>> {
  factory ImageResourceCollection.fromJson(Map<String, dynamic> json) {
    return ImageResourceCollection._(
      Resource.fromJson(
        json,
        Name.fromJson,
        (json) => ((json!) as Map<String, dynamic>).map(
          (key, value) => MapEntry(Id._(key), ImageResource.fromJson(value)),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => _collection.toJson(
    Name.toJson,
    (map) => map.map((key, value) => MapEntry(key as String, value.toJson())),
  );
}

extension type PoseId(Id id) implements Id {} // TODO: Use in accessor.
extension type Pose._(ImageResource _pose) implements ImageResource {}

extension type Actor._(ImageResourceCollection _actor)
    implements ImageResourceCollection {
  factory Actor.fromJson(Map<String, dynamic> json) =>
      Actor._(ImageResourceCollection.fromJson(json));
}

extension type BackgroundId(Id id) implements Id {} // TODO: Use in accessor.
extension type Background._(ImageResource _background)
    implements ImageResource {}

extension type Place._(ImageResourceCollection _place)
    implements ImageResourceCollection {
  factory Place.fromJson(Map<String, dynamic> json) =>
      Place._(ImageResourceCollection.fromJson(json));
}

@JsonSerializable(genericArgumentFactories: true, constructor: "_")
class FullId<CollectionId extends Id, ItemId extends Id> {
  final CollectionId collectionId;
  final ItemId itemId;

  FullId._({required this.collectionId, required this.itemId});

  factory FullId.fromJson(
    Map<String, dynamic> json,
    CollectionId Function(Object? json) fromJsonMetadata,
    ItemId Function(Object? json) fromJsonValue,
  ) => _$FullIdFromJson(json, fromJsonMetadata, fromJsonValue);

  Map<String, dynamic> toJson(
    Object? Function(CollectionId value) toJsonMetadata,
    Object? Function(ItemId value) toJsonValue,
  ) => _$FullIdToJson(this, toJsonMetadata, toJsonValue);
}
