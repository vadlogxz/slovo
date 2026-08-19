// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Collection {

 String get id; String get ownerId; String get title; String? get description; CollectionColor get color; bool get isPublic; int get wordCount; int get wordsLearned; String get language; List<String> get tags; DateTime? get lastStudiedAt; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Collection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionCopyWith<Collection> get copyWith => _$CollectionCopyWithImpl<Collection>(this as Collection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Collection&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.color, color) || other.color == color)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.wordsLearned, wordsLearned) || other.wordsLearned == wordsLearned)&&(identical(other.language, language) || other.language == language)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.lastStudiedAt, lastStudiedAt) || other.lastStudiedAt == lastStudiedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,ownerId,title,description,color,isPublic,wordCount,wordsLearned,language,const DeepCollectionEquality().hash(tags),lastStudiedAt,createdAt,updatedAt);

@override
String toString() {
  return 'Collection(id: $id, ownerId: $ownerId, title: $title, description: $description, color: $color, isPublic: $isPublic, wordCount: $wordCount, wordsLearned: $wordsLearned, language: $language, tags: $tags, lastStudiedAt: $lastStudiedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CollectionCopyWith<$Res>  {
  factory $CollectionCopyWith(Collection value, $Res Function(Collection) _then) = _$CollectionCopyWithImpl;
@useResult
$Res call({
 String id, String ownerId, String title, String? description, CollectionColor color, bool isPublic, int wordCount, int wordsLearned, String language, List<String> tags, DateTime? lastStudiedAt, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$CollectionCopyWithImpl<$Res>
    implements $CollectionCopyWith<$Res> {
  _$CollectionCopyWithImpl(this._self, this._then);

  final Collection _self;
  final $Res Function(Collection) _then;

/// Create a copy of Collection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ownerId = null,Object? title = null,Object? description = freezed,Object? color = null,Object? isPublic = null,Object? wordCount = null,Object? wordsLearned = null,Object? language = null,Object? tags = null,Object? lastStudiedAt = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as CollectionColor,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,wordsLearned: null == wordsLearned ? _self.wordsLearned : wordsLearned // ignore: cast_nullable_to_non_nullable
as int,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,lastStudiedAt: freezed == lastStudiedAt ? _self.lastStudiedAt : lastStudiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Collection].
extension CollectionPatterns on Collection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Collection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Collection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Collection value)  $default,){
final _that = this;
switch (_that) {
case _Collection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Collection value)?  $default,){
final _that = this;
switch (_that) {
case _Collection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ownerId,  String title,  String? description,  CollectionColor color,  bool isPublic,  int wordCount,  int wordsLearned,  String language,  List<String> tags,  DateTime? lastStudiedAt,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Collection() when $default != null:
return $default(_that.id,_that.ownerId,_that.title,_that.description,_that.color,_that.isPublic,_that.wordCount,_that.wordsLearned,_that.language,_that.tags,_that.lastStudiedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ownerId,  String title,  String? description,  CollectionColor color,  bool isPublic,  int wordCount,  int wordsLearned,  String language,  List<String> tags,  DateTime? lastStudiedAt,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Collection():
return $default(_that.id,_that.ownerId,_that.title,_that.description,_that.color,_that.isPublic,_that.wordCount,_that.wordsLearned,_that.language,_that.tags,_that.lastStudiedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ownerId,  String title,  String? description,  CollectionColor color,  bool isPublic,  int wordCount,  int wordsLearned,  String language,  List<String> tags,  DateTime? lastStudiedAt,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Collection() when $default != null:
return $default(_that.id,_that.ownerId,_that.title,_that.description,_that.color,_that.isPublic,_that.wordCount,_that.wordsLearned,_that.language,_that.tags,_that.lastStudiedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Collection extends Collection {
  const _Collection({required this.id, required this.ownerId, required this.title, this.description, this.color = CollectionColor.violet, this.isPublic = false, this.wordCount = 0, this.wordsLearned = 0, this.language = 'de', final  List<String> tags = const <String>[], this.lastStudiedAt, required this.createdAt, required this.updatedAt}): _tags = tags,super._();
  

@override final  String id;
@override final  String ownerId;
@override final  String title;
@override final  String? description;
@override@JsonKey() final  CollectionColor color;
@override@JsonKey() final  bool isPublic;
@override@JsonKey() final  int wordCount;
@override@JsonKey() final  int wordsLearned;
@override@JsonKey() final  String language;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  DateTime? lastStudiedAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Collection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionCopyWith<_Collection> get copyWith => __$CollectionCopyWithImpl<_Collection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Collection&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.color, color) || other.color == color)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.wordsLearned, wordsLearned) || other.wordsLearned == wordsLearned)&&(identical(other.language, language) || other.language == language)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.lastStudiedAt, lastStudiedAt) || other.lastStudiedAt == lastStudiedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,ownerId,title,description,color,isPublic,wordCount,wordsLearned,language,const DeepCollectionEquality().hash(_tags),lastStudiedAt,createdAt,updatedAt);

@override
String toString() {
  return 'Collection(id: $id, ownerId: $ownerId, title: $title, description: $description, color: $color, isPublic: $isPublic, wordCount: $wordCount, wordsLearned: $wordsLearned, language: $language, tags: $tags, lastStudiedAt: $lastStudiedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CollectionCopyWith<$Res> implements $CollectionCopyWith<$Res> {
  factory _$CollectionCopyWith(_Collection value, $Res Function(_Collection) _then) = __$CollectionCopyWithImpl;
@override @useResult
$Res call({
 String id, String ownerId, String title, String? description, CollectionColor color, bool isPublic, int wordCount, int wordsLearned, String language, List<String> tags, DateTime? lastStudiedAt, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$CollectionCopyWithImpl<$Res>
    implements _$CollectionCopyWith<$Res> {
  __$CollectionCopyWithImpl(this._self, this._then);

  final _Collection _self;
  final $Res Function(_Collection) _then;

/// Create a copy of Collection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ownerId = null,Object? title = null,Object? description = freezed,Object? color = null,Object? isPublic = null,Object? wordCount = null,Object? wordsLearned = null,Object? language = null,Object? tags = null,Object? lastStudiedAt = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Collection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as CollectionColor,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,wordsLearned: null == wordsLearned ? _self.wordsLearned : wordsLearned // ignore: cast_nullable_to_non_nullable
as int,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,lastStudiedAt: freezed == lastStudiedAt ? _self.lastStudiedAt : lastStudiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
