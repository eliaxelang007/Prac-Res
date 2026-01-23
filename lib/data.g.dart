// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

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

Selection _$SelectionFromJson(Map<String, dynamic> json) => Selection(
  options: (json['options'] as List<dynamic>).map((e) => e as Option).toSet(),
  selected: json['selected'] as Option?,
);

Map<String, dynamic> _$SelectionToJson(Selection instance) => <String, dynamic>{
  'options': instance.options.toList(),
  'selected': instance.selected,
};

DialogueBox _$DialogueBoxFromJson(Map<String, dynamic> json) => DialogueBox._(
  name: json['name'] as String?,
  dialogue: json['dialogue'] as String,
);

Map<String, dynamic> _$DialogueBoxToJson(DialogueBox instance) =>
    <String, dynamic>{'name': instance.name, 'dialogue': instance.dialogue};

OrderedScenePart _$OrderedScenePartFromJson(Map<String, dynamic> json) =>
    OrderedScenePart._(
      order: (json['order'] as num).toDouble(),
      part: ScenePart.fromJson(json['part'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderedScenePartToJson(OrderedScenePart instance) =>
    <String, dynamic>{'order': instance.order, 'part': instance.part};

Frame _$FrameFromJson(Map<String, dynamic> json) => Frame(
  background: FullBackgroundId.fromJson(
    json['background'] as Map<String, dynamic>,
  ),
  poses: (json['poses'] as List<dynamic>)
      .map((e) => FullPoseId.fromJson(e as Map<String, dynamic>))
      .toList(),
  dialogueBox: json['dialogueBox'] == null
      ? null
      : DialogueBox.fromJson(json['dialogueBox'] as Map<String, dynamic>),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$FrameToJson(Frame instance) => <String, dynamic>{
  'background': instance.background,
  'poses': instance.poses,
  'dialogueBox': instance.dialogueBox,
  'type': instance.$type,
};

FrameResolver _$FrameResolverFromJson(Map<String, dynamic> json) =>
    FrameResolver($type: json['type'] as String?);

Map<String, dynamic> _$FrameResolverToJson(FrameResolver instance) =>
    <String, dynamic>{'type': instance.$type};
