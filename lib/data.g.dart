// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pose _$PoseFromJson(Map<String, dynamic> json) => Pose._(
  name: json['name'] as String,
  image: const PoseImageConverter().fromJson(json['image'] as String),
);

Map<String, dynamic> _$PoseToJson(Pose instance) => <String, dynamic>{
  'name': instance.name,
  'image': const PoseImageConverter().toJson(instance.image),
};

Actor _$ActorFromJson(Map<String, dynamic> json) => Actor._(
  name: json['name'] as String,
  poses: _posesFromJson(json['poses'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ActorToJson(Actor instance) => <String, dynamic>{
  'name': instance.name,
  'poses': _posesToJson(instance.poses),
};

Background _$BackgroundFromJson(Map<String, dynamic> json) => Background._(
  name: json['name'] as String,
  image: const BackgroundImageConverter().fromJson(json['image'] as String),
);

Map<String, dynamic> _$BackgroundToJson(Background instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': const BackgroundImageConverter().toJson(instance.image),
    };

Place _$PlaceFromJson(Map<String, dynamic> json) => Place._(
  name: json['name'] as String,
  backgrounds: _backgroundsFromJson(
    json['backgrounds'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
  'name': instance.name,
  'backgrounds': _backgroundsToJson(instance.backgrounds),
};

FullBackgroundId _$FullBackgroundIdFromJson(Map<String, dynamic> json) =>
    FullBackgroundId._(
      place: json['place'] as PlaceId,
      background: json['background'] as BackgroundId,
    );

Map<String, dynamic> _$FullBackgroundIdToJson(FullBackgroundId instance) =>
    <String, dynamic>{
      'place': instance.place,
      'background': instance.background,
    };

FullPoseId _$FullPoseIdFromJson(Map<String, dynamic> json) =>
    FullPoseId._(actor: json['actor'] as ActorId, pose: json['pose'] as PoseId);

Map<String, dynamic> _$FullPoseIdToJson(FullPoseId instance) =>
    <String, dynamic>{'actor': instance.actor, 'pose': instance.pose};

Selection _$SelectionFromJson(Map<String, dynamic> json) => Selection._(
  name: json['name'] as String,
  options: (json['options'] as List<dynamic>).map((e) => e as Option).toSet(),
  selected: json['selected'] as Option?,
);

Map<String, dynamic> _$SelectionToJson(Selection instance) => <String, dynamic>{
  'name': instance.name,
  'options': instance.options.toList(),
  'selected': instance.selected,
};

SaveData _$SaveDataFromJson(Map<String, dynamic> json) => SaveData._(
  selections: _choicesFromJson(json['selections'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SaveDataToJson(SaveData instance) => <String, dynamic>{
  'selections': _choicesToJson(instance.selections),
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

Scene _$SceneFromJson(Map<String, dynamic> json) => Scene._(
  name: json['name'] as String,
  sceneParts: _framesFromJson(json['sceneParts'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SceneToJson(Scene instance) => <String, dynamic>{
  'name': instance.name,
  'sceneParts': _framesToJson(instance.sceneParts),
};

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
