// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Resource<Metadata,Value> {

 Metadata get metadata; Value get value;
/// Create a copy of Resource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResourceCopyWith<Metadata, Value, Resource<Metadata, Value>> get copyWith => _$ResourceCopyWithImpl<Metadata, Value, Resource<Metadata, Value>>(this as Resource<Metadata, Value>, _$identity);

  /// Serializes this Resource to a JSON map.
  Map<String, dynamic> toJson(Object? Function(Metadata) toJsonMetadata,Object? Function(Value) toJsonValue);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Resource<Metadata, Value>&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'Resource<$Metadata, $Value>(metadata: $metadata, value: $value)';
}


}

/// @nodoc
abstract mixin class $ResourceCopyWith<Metadata,Value,$Res>  {
  factory $ResourceCopyWith(Resource<Metadata, Value> value, $Res Function(Resource<Metadata, Value>) _then) = _$ResourceCopyWithImpl;
@useResult
$Res call({
 Metadata metadata, Value value
});




}
/// @nodoc
class _$ResourceCopyWithImpl<Metadata,Value,$Res>
    implements $ResourceCopyWith<Metadata, Value, $Res> {
  _$ResourceCopyWithImpl(this._self, this._then);

  final Resource<Metadata, Value> _self;
  final $Res Function(Resource<Metadata, Value>) _then;

/// Create a copy of Resource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = freezed,Object? value = freezed,}) {
  return _then(_self.copyWith(
metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Metadata,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as Value,
  ));
}

}


/// Adds pattern-matching-related methods to [Resource].
extension ResourcePatterns<Metadata,Value> on Resource<Metadata, Value> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Resource<Metadata, Value> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Resource() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Resource<Metadata, Value> value)  $default,){
final _that = this;
switch (_that) {
case _Resource():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Resource<Metadata, Value> value)?  $default,){
final _that = this;
switch (_that) {
case _Resource() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Metadata metadata,  Value value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Resource() when $default != null:
return $default(_that.metadata,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Metadata metadata,  Value value)  $default,) {final _that = this;
switch (_that) {
case _Resource():
return $default(_that.metadata,_that.value);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Metadata metadata,  Value value)?  $default,) {final _that = this;
switch (_that) {
case _Resource() when $default != null:
return $default(_that.metadata,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _Resource<Metadata,Value> implements Resource<Metadata, Value> {
  const _Resource({required this.metadata, required this.value});
  factory _Resource.fromJson(Map<String, dynamic> json,Metadata Function(Object?) fromJsonMetadata,Value Function(Object?) fromJsonValue) => _$ResourceFromJson(json,fromJsonMetadata,fromJsonValue);

@override final  Metadata metadata;
@override final  Value value;

/// Create a copy of Resource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResourceCopyWith<Metadata, Value, _Resource<Metadata, Value>> get copyWith => __$ResourceCopyWithImpl<Metadata, Value, _Resource<Metadata, Value>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(Metadata) toJsonMetadata,Object? Function(Value) toJsonValue) {
  return _$ResourceToJson<Metadata, Value>(this, toJsonMetadata,toJsonValue);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Resource<Metadata, Value>&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'Resource<$Metadata, $Value>(metadata: $metadata, value: $value)';
}


}

/// @nodoc
abstract mixin class _$ResourceCopyWith<Metadata,Value,$Res> implements $ResourceCopyWith<Metadata, Value, $Res> {
  factory _$ResourceCopyWith(_Resource<Metadata, Value> value, $Res Function(_Resource<Metadata, Value>) _then) = __$ResourceCopyWithImpl;
@override @useResult
$Res call({
 Metadata metadata, Value value
});




}
/// @nodoc
class __$ResourceCopyWithImpl<Metadata,Value,$Res>
    implements _$ResourceCopyWith<Metadata, Value, $Res> {
  __$ResourceCopyWithImpl(this._self, this._then);

  final _Resource<Metadata, Value> _self;
  final $Res Function(_Resource<Metadata, Value>) _then;

/// Create a copy of Resource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metadata = freezed,Object? value = freezed,}) {
  return _then(_Resource<Metadata, Value>(
metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Metadata,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as Value,
  ));
}


}


/// @nodoc
mixin _$Selection {

 Set<Option> get options; Option? get selected;
/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectionCopyWith<Selection> get copyWith => _$SelectionCopyWithImpl<Selection>(this as Selection, _$identity);

  /// Serializes this Selection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Selection&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.selected, selected) || other.selected == selected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(options),selected);

@override
String toString() {
  return 'Selection(options: $options, selected: $selected)';
}


}

/// @nodoc
abstract mixin class $SelectionCopyWith<$Res>  {
  factory $SelectionCopyWith(Selection value, $Res Function(Selection) _then) = _$SelectionCopyWithImpl;
@useResult
$Res call({
 Set<Option> options, Option? selected
});




}
/// @nodoc
class _$SelectionCopyWithImpl<$Res>
    implements $SelectionCopyWith<$Res> {
  _$SelectionCopyWithImpl(this._self, this._then);

  final Selection _self;
  final $Res Function(Selection) _then;

/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? options = null,Object? selected = freezed,}) {
  return _then(_self.copyWith(
options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as Set<Option>,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as Option?,
  ));
}

}


/// Adds pattern-matching-related methods to [Selection].
extension SelectionPatterns on Selection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Selection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Selection() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Selection value)  $default,){
final _that = this;
switch (_that) {
case _Selection():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Selection value)?  $default,){
final _that = this;
switch (_that) {
case _Selection() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<Option> options,  Option? selected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Selection() when $default != null:
return $default(_that.options,_that.selected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<Option> options,  Option? selected)  $default,) {final _that = this;
switch (_that) {
case _Selection():
return $default(_that.options,_that.selected);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<Option> options,  Option? selected)?  $default,) {final _that = this;
switch (_that) {
case _Selection() when $default != null:
return $default(_that.options,_that.selected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Selection extends Selection {
   _Selection({required final  Set<Option> options, required this.selected}): assert(selected == null || options.contains(selected), '[selected] has to be either [null] or contained in the set of [options]!'),_options = options,super._();
  factory _Selection.fromJson(Map<String, dynamic> json) => _$SelectionFromJson(json);

 final  Set<Option> _options;
@override Set<Option> get options {
  if (_options is EqualUnmodifiableSetView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_options);
}

@override final  Option? selected;

/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectionCopyWith<_Selection> get copyWith => __$SelectionCopyWithImpl<_Selection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Selection&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.selected, selected) || other.selected == selected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_options),selected);

@override
String toString() {
  return 'Selection(options: $options, selected: $selected)';
}


}

/// @nodoc
abstract mixin class _$SelectionCopyWith<$Res> implements $SelectionCopyWith<$Res> {
  factory _$SelectionCopyWith(_Selection value, $Res Function(_Selection) _then) = __$SelectionCopyWithImpl;
@override @useResult
$Res call({
 Set<Option> options, Option? selected
});




}
/// @nodoc
class __$SelectionCopyWithImpl<$Res>
    implements _$SelectionCopyWith<$Res> {
  __$SelectionCopyWithImpl(this._self, this._then);

  final _Selection _self;
  final $Res Function(_Selection) _then;

/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? options = null,Object? selected = freezed,}) {
  return _then(_Selection(
options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as Set<Option>,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as Option?,
  ));
}


}


/// @nodoc
mixin _$DialogueBox {

 String? get name; String get dialogue;
/// Create a copy of DialogueBox
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DialogueBoxCopyWith<DialogueBox> get copyWith => _$DialogueBoxCopyWithImpl<DialogueBox>(this as DialogueBox, _$identity);

  /// Serializes this DialogueBox to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DialogueBox&&(identical(other.name, name) || other.name == name)&&(identical(other.dialogue, dialogue) || other.dialogue == dialogue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,dialogue);

@override
String toString() {
  return 'DialogueBox(name: $name, dialogue: $dialogue)';
}


}

/// @nodoc
abstract mixin class $DialogueBoxCopyWith<$Res>  {
  factory $DialogueBoxCopyWith(DialogueBox value, $Res Function(DialogueBox) _then) = _$DialogueBoxCopyWithImpl;
@useResult
$Res call({
 String? name, String dialogue
});




}
/// @nodoc
class _$DialogueBoxCopyWithImpl<$Res>
    implements $DialogueBoxCopyWith<$Res> {
  _$DialogueBoxCopyWithImpl(this._self, this._then);

  final DialogueBox _self;
  final $Res Function(DialogueBox) _then;

/// Create a copy of DialogueBox
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? dialogue = null,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,dialogue: null == dialogue ? _self.dialogue : dialogue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DialogueBox].
extension DialogueBoxPatterns on DialogueBox {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DialogueBox value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DialogueBox() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DialogueBox value)  $default,){
final _that = this;
switch (_that) {
case _DialogueBox():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DialogueBox value)?  $default,){
final _that = this;
switch (_that) {
case _DialogueBox() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String dialogue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DialogueBox() when $default != null:
return $default(_that.name,_that.dialogue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String dialogue)  $default,) {final _that = this;
switch (_that) {
case _DialogueBox():
return $default(_that.name,_that.dialogue);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String dialogue)?  $default,) {final _that = this;
switch (_that) {
case _DialogueBox() when $default != null:
return $default(_that.name,_that.dialogue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DialogueBox implements DialogueBox {
  const _DialogueBox({required this.name, required this.dialogue});
  factory _DialogueBox.fromJson(Map<String, dynamic> json) => _$DialogueBoxFromJson(json);

@override final  String? name;
@override final  String dialogue;

/// Create a copy of DialogueBox
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DialogueBoxCopyWith<_DialogueBox> get copyWith => __$DialogueBoxCopyWithImpl<_DialogueBox>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DialogueBoxToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DialogueBox&&(identical(other.name, name) || other.name == name)&&(identical(other.dialogue, dialogue) || other.dialogue == dialogue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,dialogue);

@override
String toString() {
  return 'DialogueBox(name: $name, dialogue: $dialogue)';
}


}

/// @nodoc
abstract mixin class _$DialogueBoxCopyWith<$Res> implements $DialogueBoxCopyWith<$Res> {
  factory _$DialogueBoxCopyWith(_DialogueBox value, $Res Function(_DialogueBox) _then) = __$DialogueBoxCopyWithImpl;
@override @useResult
$Res call({
 String? name, String dialogue
});




}
/// @nodoc
class __$DialogueBoxCopyWithImpl<$Res>
    implements _$DialogueBoxCopyWith<$Res> {
  __$DialogueBoxCopyWithImpl(this._self, this._then);

  final _DialogueBox _self;
  final $Res Function(_DialogueBox) _then;

/// Create a copy of DialogueBox
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? dialogue = null,}) {
  return _then(_DialogueBox(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,dialogue: null == dialogue ? _self.dialogue : dialogue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

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


$DialogueBoxCopyWith<$Res>? get dialogueBox;

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

/// Create a copy of ScenePart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DialogueBoxCopyWith<$Res>? get dialogueBox {
    if (_self.dialogueBox == null) {
    return null;
  }

  return $DialogueBoxCopyWith<$Res>(_self.dialogueBox!, (value) {
    return _then(_self.copyWith(dialogueBox: value));
  });
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





/// @nodoc
mixin _$OrderedScenePart {

 double get order; ScenePart get part;
/// Create a copy of OrderedScenePart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderedScenePartCopyWith<OrderedScenePart> get copyWith => _$OrderedScenePartCopyWithImpl<OrderedScenePart>(this as OrderedScenePart, _$identity);

  /// Serializes this OrderedScenePart to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderedScenePart&&(identical(other.order, order) || other.order == order)&&(identical(other.part, part) || other.part == part));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order,part);

@override
String toString() {
  return 'OrderedScenePart(order: $order, part: $part)';
}


}

/// @nodoc
abstract mixin class $OrderedScenePartCopyWith<$Res>  {
  factory $OrderedScenePartCopyWith(OrderedScenePart value, $Res Function(OrderedScenePart) _then) = _$OrderedScenePartCopyWithImpl;
@useResult
$Res call({
 double order, ScenePart part
});


$ScenePartCopyWith<$Res> get part;

}
/// @nodoc
class _$OrderedScenePartCopyWithImpl<$Res>
    implements $OrderedScenePartCopyWith<$Res> {
  _$OrderedScenePartCopyWithImpl(this._self, this._then);

  final OrderedScenePart _self;
  final $Res Function(OrderedScenePart) _then;

/// Create a copy of OrderedScenePart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = null,Object? part = null,}) {
  return _then(_self.copyWith(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as double,part: null == part ? _self.part : part // ignore: cast_nullable_to_non_nullable
as ScenePart,
  ));
}
/// Create a copy of OrderedScenePart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScenePartCopyWith<$Res> get part {
  
  return $ScenePartCopyWith<$Res>(_self.part, (value) {
    return _then(_self.copyWith(part: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderedScenePart].
extension OrderedScenePartPatterns on OrderedScenePart {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderedScenePart value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderedScenePart() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderedScenePart value)  $default,){
final _that = this;
switch (_that) {
case _OrderedScenePart():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderedScenePart value)?  $default,){
final _that = this;
switch (_that) {
case _OrderedScenePart() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double order,  ScenePart part)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderedScenePart() when $default != null:
return $default(_that.order,_that.part);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double order,  ScenePart part)  $default,) {final _that = this;
switch (_that) {
case _OrderedScenePart():
return $default(_that.order,_that.part);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double order,  ScenePart part)?  $default,) {final _that = this;
switch (_that) {
case _OrderedScenePart() when $default != null:
return $default(_that.order,_that.part);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderedScenePart implements OrderedScenePart {
  const _OrderedScenePart({required this.order, required this.part});
  factory _OrderedScenePart.fromJson(Map<String, dynamic> json) => _$OrderedScenePartFromJson(json);

@override final  double order;
@override final  ScenePart part;

/// Create a copy of OrderedScenePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderedScenePartCopyWith<_OrderedScenePart> get copyWith => __$OrderedScenePartCopyWithImpl<_OrderedScenePart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderedScenePartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderedScenePart&&(identical(other.order, order) || other.order == order)&&(identical(other.part, part) || other.part == part));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order,part);

@override
String toString() {
  return 'OrderedScenePart(order: $order, part: $part)';
}


}

/// @nodoc
abstract mixin class _$OrderedScenePartCopyWith<$Res> implements $OrderedScenePartCopyWith<$Res> {
  factory _$OrderedScenePartCopyWith(_OrderedScenePart value, $Res Function(_OrderedScenePart) _then) = __$OrderedScenePartCopyWithImpl;
@override @useResult
$Res call({
 double order, ScenePart part
});


@override $ScenePartCopyWith<$Res> get part;

}
/// @nodoc
class __$OrderedScenePartCopyWithImpl<$Res>
    implements _$OrderedScenePartCopyWith<$Res> {
  __$OrderedScenePartCopyWithImpl(this._self, this._then);

  final _OrderedScenePart _self;
  final $Res Function(_OrderedScenePart) _then;

/// Create a copy of OrderedScenePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = null,Object? part = null,}) {
  return _then(_OrderedScenePart(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as double,part: null == part ? _self.part : part // ignore: cast_nullable_to_non_nullable
as ScenePart,
  ));
}

/// Create a copy of OrderedScenePart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScenePartCopyWith<$Res> get part {
  
  return $ScenePartCopyWith<$Res>(_self.part, (value) {
    return _then(_self.copyWith(part: value));
  });
}
}

/// @nodoc
mixin _$SceneGroup {

 Selections get selections; Places get places; Actors get actors; Scenes get scenes;
/// Create a copy of SceneGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SceneGroupCopyWith<SceneGroup> get copyWith => _$SceneGroupCopyWithImpl<SceneGroup>(this as SceneGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SceneGroup&&const DeepCollectionEquality().equals(other.selections, selections)&&const DeepCollectionEquality().equals(other.places, places)&&const DeepCollectionEquality().equals(other.actors, actors)&&const DeepCollectionEquality().equals(other.scenes, scenes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(selections),const DeepCollectionEquality().hash(places),const DeepCollectionEquality().hash(actors),const DeepCollectionEquality().hash(scenes));

@override
String toString() {
  return 'SceneGroup(selections: $selections, places: $places, actors: $actors, scenes: $scenes)';
}


}

/// @nodoc
abstract mixin class $SceneGroupCopyWith<$Res>  {
  factory $SceneGroupCopyWith(SceneGroup value, $Res Function(SceneGroup) _then) = _$SceneGroupCopyWithImpl;
@useResult
$Res call({
 Selections selections, Places places, Actors actors, Scenes scenes
});




}
/// @nodoc
class _$SceneGroupCopyWithImpl<$Res>
    implements $SceneGroupCopyWith<$Res> {
  _$SceneGroupCopyWithImpl(this._self, this._then);

  final SceneGroup _self;
  final $Res Function(SceneGroup) _then;

/// Create a copy of SceneGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selections = null,Object? places = null,Object? actors = null,Object? scenes = null,}) {
  return _then(_self.copyWith(
selections: null == selections ? _self.selections : selections // ignore: cast_nullable_to_non_nullable
as Selections,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as Places,actors: null == actors ? _self.actors : actors // ignore: cast_nullable_to_non_nullable
as Actors,scenes: null == scenes ? _self.scenes : scenes // ignore: cast_nullable_to_non_nullable
as Scenes,
  ));
}

}


/// Adds pattern-matching-related methods to [SceneGroup].
extension SceneGroupPatterns on SceneGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SceneGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SceneGroup() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SceneGroup value)  $default,){
final _that = this;
switch (_that) {
case _SceneGroup():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SceneGroup value)?  $default,){
final _that = this;
switch (_that) {
case _SceneGroup() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Selections selections,  Places places,  Actors actors,  Scenes scenes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SceneGroup() when $default != null:
return $default(_that.selections,_that.places,_that.actors,_that.scenes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Selections selections,  Places places,  Actors actors,  Scenes scenes)  $default,) {final _that = this;
switch (_that) {
case _SceneGroup():
return $default(_that.selections,_that.places,_that.actors,_that.scenes);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Selections selections,  Places places,  Actors actors,  Scenes scenes)?  $default,) {final _that = this;
switch (_that) {
case _SceneGroup() when $default != null:
return $default(_that.selections,_that.places,_that.actors,_that.scenes);case _:
  return null;

}
}

}

/// @nodoc


class _SceneGroup extends SceneGroup {
  const _SceneGroup({required this.selections, required this.places, required this.actors, required this.scenes}): super._();
  

@override final  Selections selections;
@override final  Places places;
@override final  Actors actors;
@override final  Scenes scenes;

/// Create a copy of SceneGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SceneGroupCopyWith<_SceneGroup> get copyWith => __$SceneGroupCopyWithImpl<_SceneGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SceneGroup&&const DeepCollectionEquality().equals(other.selections, selections)&&const DeepCollectionEquality().equals(other.places, places)&&const DeepCollectionEquality().equals(other.actors, actors)&&const DeepCollectionEquality().equals(other.scenes, scenes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(selections),const DeepCollectionEquality().hash(places),const DeepCollectionEquality().hash(actors),const DeepCollectionEquality().hash(scenes));

@override
String toString() {
  return 'SceneGroup(selections: $selections, places: $places, actors: $actors, scenes: $scenes)';
}


}

/// @nodoc
abstract mixin class _$SceneGroupCopyWith<$Res> implements $SceneGroupCopyWith<$Res> {
  factory _$SceneGroupCopyWith(_SceneGroup value, $Res Function(_SceneGroup) _then) = __$SceneGroupCopyWithImpl;
@override @useResult
$Res call({
 Selections selections, Places places, Actors actors, Scenes scenes
});




}
/// @nodoc
class __$SceneGroupCopyWithImpl<$Res>
    implements _$SceneGroupCopyWith<$Res> {
  __$SceneGroupCopyWithImpl(this._self, this._then);

  final _SceneGroup _self;
  final $Res Function(_SceneGroup) _then;

/// Create a copy of SceneGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selections = null,Object? places = null,Object? actors = null,Object? scenes = null,}) {
  return _then(_SceneGroup(
selections: null == selections ? _self.selections : selections // ignore: cast_nullable_to_non_nullable
as Selections,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as Places,actors: null == actors ? _self.actors : actors // ignore: cast_nullable_to_non_nullable
as Actors,scenes: null == scenes ? _self.scenes : scenes // ignore: cast_nullable_to_non_nullable
as Scenes,
  ));
}


}

// dart format on
