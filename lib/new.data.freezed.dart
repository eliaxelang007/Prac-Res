// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new.data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ScenePart _$ScenePartFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'frame':
          return Frame.fromJson(
            json
          );
                case 'frameResolver':
          return FrameResolver.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'ScenePart',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$ScenePart {



  /// Serializes this ScenePart to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScenePart);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScenePart()';
}


}

/// @nodoc
class $ScenePartCopyWith<$Res>  {
$ScenePartCopyWith(ScenePart _, $Res Function(ScenePart) __);
}


/// Adds pattern-matching-related methods to [ScenePart].
extension ScenePartPatterns on ScenePart {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Frame value)?  frame,TResult Function( FrameResolver value)?  frameResolver,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Frame() when frame != null:
return frame(_that);case FrameResolver() when frameResolver != null:
return frameResolver(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Frame value)  frame,required TResult Function( FrameResolver value)  frameResolver,}){
final _that = this;
switch (_that) {
case Frame():
return frame(_that);case FrameResolver():
return frameResolver(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Frame value)?  frame,TResult? Function( FrameResolver value)?  frameResolver,}){
final _that = this;
switch (_that) {
case Frame() when frame != null:
return frame(_that);case FrameResolver() when frameResolver != null:
return frameResolver(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( FullBackgroundId background,  List<FullPoseId> poses,  DialogueBox? dialogueBox)?  frame,TResult Function()?  frameResolver,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Frame() when frame != null:
return frame(_that.background,_that.poses,_that.dialogueBox);case FrameResolver() when frameResolver != null:
return frameResolver();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( FullBackgroundId background,  List<FullPoseId> poses,  DialogueBox? dialogueBox)  frame,required TResult Function()  frameResolver,}) {final _that = this;
switch (_that) {
case Frame():
return frame(_that.background,_that.poses,_that.dialogueBox);case FrameResolver():
return frameResolver();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( FullBackgroundId background,  List<FullPoseId> poses,  DialogueBox? dialogueBox)?  frame,TResult? Function()?  frameResolver,}) {final _that = this;
switch (_that) {
case Frame() when frame != null:
return frame(_that.background,_that.poses,_that.dialogueBox);case FrameResolver() when frameResolver != null:
return frameResolver();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class Frame implements ScenePart {
  const Frame({required this.background, required final  List<FullPoseId> poses, required this.dialogueBox, final  String? $type}): _poses = poses,$type = $type ?? 'frame';
  factory Frame.fromJson(Map<String, dynamic> json) => _$FrameFromJson(json);

 final  FullBackgroundId background;
 final  List<FullPoseId> _poses;
 List<FullPoseId> get poses {
  if (_poses is EqualUnmodifiableListView) return _poses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_poses);
}

 final  DialogueBox? dialogueBox;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ScenePart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FrameCopyWith<Frame> get copyWith => _$FrameCopyWithImpl<Frame>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FrameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Frame&&(identical(other.background, background) || other.background == background)&&const DeepCollectionEquality().equals(other._poses, _poses)&&(identical(other.dialogueBox, dialogueBox) || other.dialogueBox == dialogueBox));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,background,const DeepCollectionEquality().hash(_poses),dialogueBox);

@override
String toString() {
  return 'ScenePart.frame(background: $background, poses: $poses, dialogueBox: $dialogueBox)';
}


}

/// @nodoc
abstract mixin class $FrameCopyWith<$Res> implements $ScenePartCopyWith<$Res> {
  factory $FrameCopyWith(Frame value, $Res Function(Frame) _then) = _$FrameCopyWithImpl;
@useResult
$Res call({
 FullBackgroundId background, List<FullPoseId> poses, DialogueBox? dialogueBox
});




}
/// @nodoc
class _$FrameCopyWithImpl<$Res>
    implements $FrameCopyWith<$Res> {
  _$FrameCopyWithImpl(this._self, this._then);

  final Frame _self;
  final $Res Function(Frame) _then;

/// Create a copy of ScenePart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? background = null,Object? poses = null,Object? dialogueBox = freezed,}) {
  return _then(Frame(
background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as FullBackgroundId,poses: null == poses ? _self._poses : poses // ignore: cast_nullable_to_non_nullable
as List<FullPoseId>,dialogueBox: freezed == dialogueBox ? _self.dialogueBox : dialogueBox // ignore: cast_nullable_to_non_nullable
as DialogueBox?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FrameResolver implements ScenePart {
  const FrameResolver({final  String? $type}): $type = $type ?? 'frameResolver';
  factory FrameResolver.fromJson(Map<String, dynamic> json) => _$FrameResolverFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$FrameResolverToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FrameResolver);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScenePart.frameResolver()';
}


}




// dart format on
