// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Selection _$SelectionFromJson(Map<String, dynamic> json) => _Selection(
  options: ISet<Option>.fromJson(json['options'], (value) => value as Option),
  selected: json['selected'] as Option?,
);

Map<String, dynamic> _$SelectionToJson(_Selection instance) =>
    <String, dynamic>{
      'options': instance.options.toJson((value) => value),
      'selected': instance.selected,
    };

Frame _$FrameFromJson(Map<String, dynamic> json) => Frame(
  background: FullBackgroundId.fromJson(
    json['background'] as Map<String, dynamic>,
  ),
  poses: IList<FullPoseId>.fromJson(
    json['poses'],
    (value) => FullPoseId.fromJson(value as Map<String, dynamic>),
  ),
  dialogueBox: json['dialogueBox'] == null
      ? null
      : DialogueBox.fromJson(json['dialogueBox'] as Map<String, dynamic>),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$FrameToJson(Frame instance) => <String, dynamic>{
  'background': instance.background,
  'poses': instance.poses.toJson((value) => value),
  'dialogueBox': instance.dialogueBox,
  'type': instance.$type,
};

FrameResolver _$FrameResolverFromJson(Map<String, dynamic> json) =>
    FrameResolver($type: json['type'] as String?);

Map<String, dynamic> _$FrameResolverToJson(FrameResolver instance) =>
    <String, dynamic>{'type': instance.$type};

_DialogueBox _$DialogueBoxFromJson(Map<String, dynamic> json) => _DialogueBox(
  name: json['name'] as String?,
  dialogue: json['dialogue'] as String,
);

Map<String, dynamic> _$DialogueBoxToJson(_DialogueBox instance) =>
    <String, dynamic>{'name': instance.name, 'dialogue': instance.dialogue};

_OrderedScenePart _$OrderedScenePartFromJson(Map<String, dynamic> json) =>
    _OrderedScenePart(
      order: (json['order'] as num).toDouble(),
      part: ScenePart.fromJson(json['part'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderedScenePartToJson(_OrderedScenePart instance) =>
    <String, dynamic>{'order': instance.order, 'part': instance.part};

_Resource<Metadata, Value> _$ResourceFromJson<Metadata, Value>(
  Map<String, dynamic> json,
  Metadata Function(Object? json) fromJsonMetadata,
  Value Function(Object? json) fromJsonValue,
) => _Resource<Metadata, Value>(
  metadata: fromJsonMetadata(json['metadata']),
  value: fromJsonValue(json['value']),
);

Map<String, dynamic> _$ResourceToJson<Metadata, Value>(
  _Resource<Metadata, Value> instance,
  Object? Function(Metadata value) toJsonMetadata,
  Object? Function(Value value) toJsonValue,
) => <String, dynamic>{
  'metadata': toJsonMetadata(instance.metadata),
  'value': toJsonValue(instance.value),
};
