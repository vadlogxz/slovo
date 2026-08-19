// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learn_session_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LearnSessionState {

 List<(Word, CardProgress)> get queue; int get currentIndex; bool get revealed;
/// Create a copy of LearnSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearnSessionStateCopyWith<LearnSessionState> get copyWith => _$LearnSessionStateCopyWithImpl<LearnSessionState>(this as LearnSessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearnSessionState&&const DeepCollectionEquality().equals(other.queue, queue)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.revealed, revealed) || other.revealed == revealed));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(queue),currentIndex,revealed);

@override
String toString() {
  return 'LearnSessionState(queue: $queue, currentIndex: $currentIndex, revealed: $revealed)';
}


}

/// @nodoc
abstract mixin class $LearnSessionStateCopyWith<$Res>  {
  factory $LearnSessionStateCopyWith(LearnSessionState value, $Res Function(LearnSessionState) _then) = _$LearnSessionStateCopyWithImpl;
@useResult
$Res call({
 List<(Word, CardProgress)> queue, int currentIndex, bool revealed
});




}
/// @nodoc
class _$LearnSessionStateCopyWithImpl<$Res>
    implements $LearnSessionStateCopyWith<$Res> {
  _$LearnSessionStateCopyWithImpl(this._self, this._then);

  final LearnSessionState _self;
  final $Res Function(LearnSessionState) _then;

/// Create a copy of LearnSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? queue = null,Object? currentIndex = null,Object? revealed = null,}) {
  return _then(_self.copyWith(
queue: null == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as List<(Word, CardProgress)>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,revealed: null == revealed ? _self.revealed : revealed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LearnSessionState].
extension LearnSessionStatePatterns on LearnSessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearnSessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearnSessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearnSessionState value)  $default,){
final _that = this;
switch (_that) {
case _LearnSessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearnSessionState value)?  $default,){
final _that = this;
switch (_that) {
case _LearnSessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<(Word, CardProgress)> queue,  int currentIndex,  bool revealed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearnSessionState() when $default != null:
return $default(_that.queue,_that.currentIndex,_that.revealed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<(Word, CardProgress)> queue,  int currentIndex,  bool revealed)  $default,) {final _that = this;
switch (_that) {
case _LearnSessionState():
return $default(_that.queue,_that.currentIndex,_that.revealed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<(Word, CardProgress)> queue,  int currentIndex,  bool revealed)?  $default,) {final _that = this;
switch (_that) {
case _LearnSessionState() when $default != null:
return $default(_that.queue,_that.currentIndex,_that.revealed);case _:
  return null;

}
}

}

/// @nodoc


class _LearnSessionState extends LearnSessionState {
  const _LearnSessionState({required final  List<(Word, CardProgress)> queue, required this.currentIndex, required this.revealed}): _queue = queue,super._();
  

 final  List<(Word, CardProgress)> _queue;
@override List<(Word, CardProgress)> get queue {
  if (_queue is EqualUnmodifiableListView) return _queue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_queue);
}

@override final  int currentIndex;
@override final  bool revealed;

/// Create a copy of LearnSessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearnSessionStateCopyWith<_LearnSessionState> get copyWith => __$LearnSessionStateCopyWithImpl<_LearnSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearnSessionState&&const DeepCollectionEquality().equals(other._queue, _queue)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.revealed, revealed) || other.revealed == revealed));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_queue),currentIndex,revealed);

@override
String toString() {
  return 'LearnSessionState(queue: $queue, currentIndex: $currentIndex, revealed: $revealed)';
}


}

/// @nodoc
abstract mixin class _$LearnSessionStateCopyWith<$Res> implements $LearnSessionStateCopyWith<$Res> {
  factory _$LearnSessionStateCopyWith(_LearnSessionState value, $Res Function(_LearnSessionState) _then) = __$LearnSessionStateCopyWithImpl;
@override @useResult
$Res call({
 List<(Word, CardProgress)> queue, int currentIndex, bool revealed
});




}
/// @nodoc
class __$LearnSessionStateCopyWithImpl<$Res>
    implements _$LearnSessionStateCopyWith<$Res> {
  __$LearnSessionStateCopyWithImpl(this._self, this._then);

  final _LearnSessionState _self;
  final $Res Function(_LearnSessionState) _then;

/// Create a copy of LearnSessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? queue = null,Object? currentIndex = null,Object? revealed = null,}) {
  return _then(_LearnSessionState(
queue: null == queue ? _self._queue : queue // ignore: cast_nullable_to_non_nullable
as List<(Word, CardProgress)>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,revealed: null == revealed ? _self.revealed : revealed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
