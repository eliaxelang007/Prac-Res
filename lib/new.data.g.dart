// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new.data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resource<Metadata, Value> _$ResourceFromJson<Metadata, Value>(
  Map<String, dynamic> json,
  Metadata Function(Object? json) fromJsonMetadata,
  Value Function(Object? json) fromJsonValue,
) => Resource<Metadata, Value>._(
  metadata: fromJsonMetadata(json['metadata']),
  value: fromJsonValue(json['value']),
);

Map<String, dynamic> _$ResourceToJson<Metadata, Value>(
  Resource<Metadata, Value> instance,
  Object? Function(Metadata value) toJsonMetadata,
  Object? Function(Value value) toJsonValue,
) => <String, dynamic>{
  'metadata': toJsonMetadata(instance.metadata),
  'value': toJsonValue(instance.value),
};

FullId<CollectionId, ItemId>
_$FullIdFromJson<CollectionId extends Id, ItemId extends Id>(
  Map<String, dynamic> json,
  CollectionId Function(Object? json) fromJsonCollectionId,
  ItemId Function(Object? json) fromJsonItemId,
) => FullId<CollectionId, ItemId>._(
  collectionId: fromJsonCollectionId(json['collectionId']),
  itemId: fromJsonItemId(json['itemId']),
);

Map<String, dynamic> _$FullIdToJson<CollectionId extends Id, ItemId extends Id>(
  FullId<CollectionId, ItemId> instance,
  Object? Function(CollectionId value) toJsonCollectionId,
  Object? Function(ItemId value) toJsonItemId,
) => <String, dynamic>{
  'collectionId': toJsonCollectionId(instance.collectionId),
  'itemId': toJsonItemId(instance.itemId),
};
