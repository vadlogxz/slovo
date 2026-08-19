// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NounData {

 NounGender get gender;// e.g. "Cafés", "Männer"
 String? get plural;// e.g. "des Cafés", "des Mannes"
 String? get genitive;
/// Create a copy of NounData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NounDataCopyWith<NounData> get copyWith => _$NounDataCopyWithImpl<NounData>(this as NounData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NounData&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.plural, plural) || other.plural == plural)&&(identical(other.genitive, genitive) || other.genitive == genitive));
}


@override
int get hashCode => Object.hash(runtimeType,gender,plural,genitive);

@override
String toString() {
  return 'NounData(gender: $gender, plural: $plural, genitive: $genitive)';
}


}

/// @nodoc
abstract mixin class $NounDataCopyWith<$Res>  {
  factory $NounDataCopyWith(NounData value, $Res Function(NounData) _then) = _$NounDataCopyWithImpl;
@useResult
$Res call({
 NounGender gender, String? plural, String? genitive
});




}
/// @nodoc
class _$NounDataCopyWithImpl<$Res>
    implements $NounDataCopyWith<$Res> {
  _$NounDataCopyWithImpl(this._self, this._then);

  final NounData _self;
  final $Res Function(NounData) _then;

/// Create a copy of NounData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gender = null,Object? plural = freezed,Object? genitive = freezed,}) {
  return _then(_self.copyWith(
gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as NounGender,plural: freezed == plural ? _self.plural : plural // ignore: cast_nullable_to_non_nullable
as String?,genitive: freezed == genitive ? _self.genitive : genitive // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NounData].
extension NounDataPatterns on NounData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NounData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NounData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NounData value)  $default,){
final _that = this;
switch (_that) {
case _NounData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NounData value)?  $default,){
final _that = this;
switch (_that) {
case _NounData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NounGender gender,  String? plural,  String? genitive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NounData() when $default != null:
return $default(_that.gender,_that.plural,_that.genitive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NounGender gender,  String? plural,  String? genitive)  $default,) {final _that = this;
switch (_that) {
case _NounData():
return $default(_that.gender,_that.plural,_that.genitive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NounGender gender,  String? plural,  String? genitive)?  $default,) {final _that = this;
switch (_that) {
case _NounData() when $default != null:
return $default(_that.gender,_that.plural,_that.genitive);case _:
  return null;

}
}

}

/// @nodoc


class _NounData extends NounData {
  const _NounData({required this.gender, this.plural, this.genitive}): super._();
  

@override final  NounGender gender;
// e.g. "Cafés", "Männer"
@override final  String? plural;
// e.g. "des Cafés", "des Mannes"
@override final  String? genitive;

/// Create a copy of NounData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NounDataCopyWith<_NounData> get copyWith => __$NounDataCopyWithImpl<_NounData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NounData&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.plural, plural) || other.plural == plural)&&(identical(other.genitive, genitive) || other.genitive == genitive));
}


@override
int get hashCode => Object.hash(runtimeType,gender,plural,genitive);

@override
String toString() {
  return 'NounData(gender: $gender, plural: $plural, genitive: $genitive)';
}


}

/// @nodoc
abstract mixin class _$NounDataCopyWith<$Res> implements $NounDataCopyWith<$Res> {
  factory _$NounDataCopyWith(_NounData value, $Res Function(_NounData) _then) = __$NounDataCopyWithImpl;
@override @useResult
$Res call({
 NounGender gender, String? plural, String? genitive
});




}
/// @nodoc
class __$NounDataCopyWithImpl<$Res>
    implements _$NounDataCopyWith<$Res> {
  __$NounDataCopyWithImpl(this._self, this._then);

  final _NounData _self;
  final $Res Function(_NounData) _then;

/// Create a copy of NounData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gender = null,Object? plural = freezed,Object? genitive = freezed,}) {
  return _then(_NounData(
gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as NounGender,plural: freezed == plural ? _self.plural : plural // ignore: cast_nullable_to_non_nullable
as String?,genitive: freezed == genitive ? _self.genitive : genitive // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$VerbConjugation {

 String get ich; String get du; String get erSieEs; String get wir; String get ihr; String get sieSie;
/// Create a copy of VerbConjugation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerbConjugationCopyWith<VerbConjugation> get copyWith => _$VerbConjugationCopyWithImpl<VerbConjugation>(this as VerbConjugation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerbConjugation&&(identical(other.ich, ich) || other.ich == ich)&&(identical(other.du, du) || other.du == du)&&(identical(other.erSieEs, erSieEs) || other.erSieEs == erSieEs)&&(identical(other.wir, wir) || other.wir == wir)&&(identical(other.ihr, ihr) || other.ihr == ihr)&&(identical(other.sieSie, sieSie) || other.sieSie == sieSie));
}


@override
int get hashCode => Object.hash(runtimeType,ich,du,erSieEs,wir,ihr,sieSie);

@override
String toString() {
  return 'VerbConjugation(ich: $ich, du: $du, erSieEs: $erSieEs, wir: $wir, ihr: $ihr, sieSie: $sieSie)';
}


}

/// @nodoc
abstract mixin class $VerbConjugationCopyWith<$Res>  {
  factory $VerbConjugationCopyWith(VerbConjugation value, $Res Function(VerbConjugation) _then) = _$VerbConjugationCopyWithImpl;
@useResult
$Res call({
 String ich, String du, String erSieEs, String wir, String ihr, String sieSie
});




}
/// @nodoc
class _$VerbConjugationCopyWithImpl<$Res>
    implements $VerbConjugationCopyWith<$Res> {
  _$VerbConjugationCopyWithImpl(this._self, this._then);

  final VerbConjugation _self;
  final $Res Function(VerbConjugation) _then;

/// Create a copy of VerbConjugation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ich = null,Object? du = null,Object? erSieEs = null,Object? wir = null,Object? ihr = null,Object? sieSie = null,}) {
  return _then(_self.copyWith(
ich: null == ich ? _self.ich : ich // ignore: cast_nullable_to_non_nullable
as String,du: null == du ? _self.du : du // ignore: cast_nullable_to_non_nullable
as String,erSieEs: null == erSieEs ? _self.erSieEs : erSieEs // ignore: cast_nullable_to_non_nullable
as String,wir: null == wir ? _self.wir : wir // ignore: cast_nullable_to_non_nullable
as String,ihr: null == ihr ? _self.ihr : ihr // ignore: cast_nullable_to_non_nullable
as String,sieSie: null == sieSie ? _self.sieSie : sieSie // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerbConjugation].
extension VerbConjugationPatterns on VerbConjugation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerbConjugation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerbConjugation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerbConjugation value)  $default,){
final _that = this;
switch (_that) {
case _VerbConjugation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerbConjugation value)?  $default,){
final _that = this;
switch (_that) {
case _VerbConjugation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ich,  String du,  String erSieEs,  String wir,  String ihr,  String sieSie)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerbConjugation() when $default != null:
return $default(_that.ich,_that.du,_that.erSieEs,_that.wir,_that.ihr,_that.sieSie);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ich,  String du,  String erSieEs,  String wir,  String ihr,  String sieSie)  $default,) {final _that = this;
switch (_that) {
case _VerbConjugation():
return $default(_that.ich,_that.du,_that.erSieEs,_that.wir,_that.ihr,_that.sieSie);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ich,  String du,  String erSieEs,  String wir,  String ihr,  String sieSie)?  $default,) {final _that = this;
switch (_that) {
case _VerbConjugation() when $default != null:
return $default(_that.ich,_that.du,_that.erSieEs,_that.wir,_that.ihr,_that.sieSie);case _:
  return null;

}
}

}

/// @nodoc


class _VerbConjugation extends VerbConjugation {
  const _VerbConjugation({required this.ich, required this.du, required this.erSieEs, required this.wir, required this.ihr, required this.sieSie}): super._();
  

@override final  String ich;
@override final  String du;
@override final  String erSieEs;
@override final  String wir;
@override final  String ihr;
@override final  String sieSie;

/// Create a copy of VerbConjugation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerbConjugationCopyWith<_VerbConjugation> get copyWith => __$VerbConjugationCopyWithImpl<_VerbConjugation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerbConjugation&&(identical(other.ich, ich) || other.ich == ich)&&(identical(other.du, du) || other.du == du)&&(identical(other.erSieEs, erSieEs) || other.erSieEs == erSieEs)&&(identical(other.wir, wir) || other.wir == wir)&&(identical(other.ihr, ihr) || other.ihr == ihr)&&(identical(other.sieSie, sieSie) || other.sieSie == sieSie));
}


@override
int get hashCode => Object.hash(runtimeType,ich,du,erSieEs,wir,ihr,sieSie);

@override
String toString() {
  return 'VerbConjugation(ich: $ich, du: $du, erSieEs: $erSieEs, wir: $wir, ihr: $ihr, sieSie: $sieSie)';
}


}

/// @nodoc
abstract mixin class _$VerbConjugationCopyWith<$Res> implements $VerbConjugationCopyWith<$Res> {
  factory _$VerbConjugationCopyWith(_VerbConjugation value, $Res Function(_VerbConjugation) _then) = __$VerbConjugationCopyWithImpl;
@override @useResult
$Res call({
 String ich, String du, String erSieEs, String wir, String ihr, String sieSie
});




}
/// @nodoc
class __$VerbConjugationCopyWithImpl<$Res>
    implements _$VerbConjugationCopyWith<$Res> {
  __$VerbConjugationCopyWithImpl(this._self, this._then);

  final _VerbConjugation _self;
  final $Res Function(_VerbConjugation) _then;

/// Create a copy of VerbConjugation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ich = null,Object? du = null,Object? erSieEs = null,Object? wir = null,Object? ihr = null,Object? sieSie = null,}) {
  return _then(_VerbConjugation(
ich: null == ich ? _self.ich : ich // ignore: cast_nullable_to_non_nullable
as String,du: null == du ? _self.du : du // ignore: cast_nullable_to_non_nullable
as String,erSieEs: null == erSieEs ? _self.erSieEs : erSieEs // ignore: cast_nullable_to_non_nullable
as String,wir: null == wir ? _self.wir : wir // ignore: cast_nullable_to_non_nullable
as String,ihr: null == ihr ? _self.ihr : ihr // ignore: cast_nullable_to_non_nullable
as String,sieSie: null == sieSie ? _self.sieSie : sieSie // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$VerbData {

// e.g. "aufgemacht", "gegangen"
 String get partizip2;// Perfekt: "habe aufgemacht" vs "bin gegangen"
 HilfsVerb get hilfsVerb;// "aufmachen" → isTrennbar: true, trennbarPrefix: "auf"
 bool get isTrennbar; String? get trennbarPrefix;// Strong verb with vowel change (fahren, laufen, etc.)
 bool get isIrregular;// Präteritum er/sie-form: "fuhr", "lief", "machte auf"
 String? get praeteritum;// Only store conjugation for irregular verbs (du fährst, er fährt).
// Regular verbs follow standard rules and don't need this.
 VerbConjugation? get conjugation;
/// Create a copy of VerbData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerbDataCopyWith<VerbData> get copyWith => _$VerbDataCopyWithImpl<VerbData>(this as VerbData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerbData&&(identical(other.partizip2, partizip2) || other.partizip2 == partizip2)&&(identical(other.hilfsVerb, hilfsVerb) || other.hilfsVerb == hilfsVerb)&&(identical(other.isTrennbar, isTrennbar) || other.isTrennbar == isTrennbar)&&(identical(other.trennbarPrefix, trennbarPrefix) || other.trennbarPrefix == trennbarPrefix)&&(identical(other.isIrregular, isIrregular) || other.isIrregular == isIrregular)&&(identical(other.praeteritum, praeteritum) || other.praeteritum == praeteritum)&&(identical(other.conjugation, conjugation) || other.conjugation == conjugation));
}


@override
int get hashCode => Object.hash(runtimeType,partizip2,hilfsVerb,isTrennbar,trennbarPrefix,isIrregular,praeteritum,conjugation);

@override
String toString() {
  return 'VerbData(partizip2: $partizip2, hilfsVerb: $hilfsVerb, isTrennbar: $isTrennbar, trennbarPrefix: $trennbarPrefix, isIrregular: $isIrregular, praeteritum: $praeteritum, conjugation: $conjugation)';
}


}

/// @nodoc
abstract mixin class $VerbDataCopyWith<$Res>  {
  factory $VerbDataCopyWith(VerbData value, $Res Function(VerbData) _then) = _$VerbDataCopyWithImpl;
@useResult
$Res call({
 String partizip2, HilfsVerb hilfsVerb, bool isTrennbar, String? trennbarPrefix, bool isIrregular, String? praeteritum, VerbConjugation? conjugation
});


$VerbConjugationCopyWith<$Res>? get conjugation;

}
/// @nodoc
class _$VerbDataCopyWithImpl<$Res>
    implements $VerbDataCopyWith<$Res> {
  _$VerbDataCopyWithImpl(this._self, this._then);

  final VerbData _self;
  final $Res Function(VerbData) _then;

/// Create a copy of VerbData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? partizip2 = null,Object? hilfsVerb = null,Object? isTrennbar = null,Object? trennbarPrefix = freezed,Object? isIrregular = null,Object? praeteritum = freezed,Object? conjugation = freezed,}) {
  return _then(_self.copyWith(
partizip2: null == partizip2 ? _self.partizip2 : partizip2 // ignore: cast_nullable_to_non_nullable
as String,hilfsVerb: null == hilfsVerb ? _self.hilfsVerb : hilfsVerb // ignore: cast_nullable_to_non_nullable
as HilfsVerb,isTrennbar: null == isTrennbar ? _self.isTrennbar : isTrennbar // ignore: cast_nullable_to_non_nullable
as bool,trennbarPrefix: freezed == trennbarPrefix ? _self.trennbarPrefix : trennbarPrefix // ignore: cast_nullable_to_non_nullable
as String?,isIrregular: null == isIrregular ? _self.isIrregular : isIrregular // ignore: cast_nullable_to_non_nullable
as bool,praeteritum: freezed == praeteritum ? _self.praeteritum : praeteritum // ignore: cast_nullable_to_non_nullable
as String?,conjugation: freezed == conjugation ? _self.conjugation : conjugation // ignore: cast_nullable_to_non_nullable
as VerbConjugation?,
  ));
}
/// Create a copy of VerbData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerbConjugationCopyWith<$Res>? get conjugation {
    if (_self.conjugation == null) {
    return null;
  }

  return $VerbConjugationCopyWith<$Res>(_self.conjugation!, (value) {
    return _then(_self.copyWith(conjugation: value));
  });
}
}


/// Adds pattern-matching-related methods to [VerbData].
extension VerbDataPatterns on VerbData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerbData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerbData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerbData value)  $default,){
final _that = this;
switch (_that) {
case _VerbData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerbData value)?  $default,){
final _that = this;
switch (_that) {
case _VerbData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String partizip2,  HilfsVerb hilfsVerb,  bool isTrennbar,  String? trennbarPrefix,  bool isIrregular,  String? praeteritum,  VerbConjugation? conjugation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerbData() when $default != null:
return $default(_that.partizip2,_that.hilfsVerb,_that.isTrennbar,_that.trennbarPrefix,_that.isIrregular,_that.praeteritum,_that.conjugation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String partizip2,  HilfsVerb hilfsVerb,  bool isTrennbar,  String? trennbarPrefix,  bool isIrregular,  String? praeteritum,  VerbConjugation? conjugation)  $default,) {final _that = this;
switch (_that) {
case _VerbData():
return $default(_that.partizip2,_that.hilfsVerb,_that.isTrennbar,_that.trennbarPrefix,_that.isIrregular,_that.praeteritum,_that.conjugation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String partizip2,  HilfsVerb hilfsVerb,  bool isTrennbar,  String? trennbarPrefix,  bool isIrregular,  String? praeteritum,  VerbConjugation? conjugation)?  $default,) {final _that = this;
switch (_that) {
case _VerbData() when $default != null:
return $default(_that.partizip2,_that.hilfsVerb,_that.isTrennbar,_that.trennbarPrefix,_that.isIrregular,_that.praeteritum,_that.conjugation);case _:
  return null;

}
}

}

/// @nodoc


class _VerbData extends VerbData {
  const _VerbData({required this.partizip2, required this.hilfsVerb, this.isTrennbar = false, this.trennbarPrefix, this.isIrregular = false, this.praeteritum, this.conjugation}): super._();
  

// e.g. "aufgemacht", "gegangen"
@override final  String partizip2;
// Perfekt: "habe aufgemacht" vs "bin gegangen"
@override final  HilfsVerb hilfsVerb;
// "aufmachen" → isTrennbar: true, trennbarPrefix: "auf"
@override@JsonKey() final  bool isTrennbar;
@override final  String? trennbarPrefix;
// Strong verb with vowel change (fahren, laufen, etc.)
@override@JsonKey() final  bool isIrregular;
// Präteritum er/sie-form: "fuhr", "lief", "machte auf"
@override final  String? praeteritum;
// Only store conjugation for irregular verbs (du fährst, er fährt).
// Regular verbs follow standard rules and don't need this.
@override final  VerbConjugation? conjugation;

/// Create a copy of VerbData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerbDataCopyWith<_VerbData> get copyWith => __$VerbDataCopyWithImpl<_VerbData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerbData&&(identical(other.partizip2, partizip2) || other.partizip2 == partizip2)&&(identical(other.hilfsVerb, hilfsVerb) || other.hilfsVerb == hilfsVerb)&&(identical(other.isTrennbar, isTrennbar) || other.isTrennbar == isTrennbar)&&(identical(other.trennbarPrefix, trennbarPrefix) || other.trennbarPrefix == trennbarPrefix)&&(identical(other.isIrregular, isIrregular) || other.isIrregular == isIrregular)&&(identical(other.praeteritum, praeteritum) || other.praeteritum == praeteritum)&&(identical(other.conjugation, conjugation) || other.conjugation == conjugation));
}


@override
int get hashCode => Object.hash(runtimeType,partizip2,hilfsVerb,isTrennbar,trennbarPrefix,isIrregular,praeteritum,conjugation);

@override
String toString() {
  return 'VerbData(partizip2: $partizip2, hilfsVerb: $hilfsVerb, isTrennbar: $isTrennbar, trennbarPrefix: $trennbarPrefix, isIrregular: $isIrregular, praeteritum: $praeteritum, conjugation: $conjugation)';
}


}

/// @nodoc
abstract mixin class _$VerbDataCopyWith<$Res> implements $VerbDataCopyWith<$Res> {
  factory _$VerbDataCopyWith(_VerbData value, $Res Function(_VerbData) _then) = __$VerbDataCopyWithImpl;
@override @useResult
$Res call({
 String partizip2, HilfsVerb hilfsVerb, bool isTrennbar, String? trennbarPrefix, bool isIrregular, String? praeteritum, VerbConjugation? conjugation
});


@override $VerbConjugationCopyWith<$Res>? get conjugation;

}
/// @nodoc
class __$VerbDataCopyWithImpl<$Res>
    implements _$VerbDataCopyWith<$Res> {
  __$VerbDataCopyWithImpl(this._self, this._then);

  final _VerbData _self;
  final $Res Function(_VerbData) _then;

/// Create a copy of VerbData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? partizip2 = null,Object? hilfsVerb = null,Object? isTrennbar = null,Object? trennbarPrefix = freezed,Object? isIrregular = null,Object? praeteritum = freezed,Object? conjugation = freezed,}) {
  return _then(_VerbData(
partizip2: null == partizip2 ? _self.partizip2 : partizip2 // ignore: cast_nullable_to_non_nullable
as String,hilfsVerb: null == hilfsVerb ? _self.hilfsVerb : hilfsVerb // ignore: cast_nullable_to_non_nullable
as HilfsVerb,isTrennbar: null == isTrennbar ? _self.isTrennbar : isTrennbar // ignore: cast_nullable_to_non_nullable
as bool,trennbarPrefix: freezed == trennbarPrefix ? _self.trennbarPrefix : trennbarPrefix // ignore: cast_nullable_to_non_nullable
as String?,isIrregular: null == isIrregular ? _self.isIrregular : isIrregular // ignore: cast_nullable_to_non_nullable
as bool,praeteritum: freezed == praeteritum ? _self.praeteritum : praeteritum // ignore: cast_nullable_to_non_nullable
as String?,conjugation: freezed == conjugation ? _self.conjugation : conjugation // ignore: cast_nullable_to_non_nullable
as VerbConjugation?,
  ));
}

/// Create a copy of VerbData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerbConjugationCopyWith<$Res>? get conjugation {
    if (_self.conjugation == null) {
    return null;
  }

  return $VerbConjugationCopyWith<$Res>(_self.conjugation!, (value) {
    return _then(_self.copyWith(conjugation: value));
  });
}
}

/// @nodoc
mixin _$AdjectiveData {

// e.g. "schneller"
 String? get komparativ;// e.g. "am schnellsten"
 String? get superlativ;
/// Create a copy of AdjectiveData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdjectiveDataCopyWith<AdjectiveData> get copyWith => _$AdjectiveDataCopyWithImpl<AdjectiveData>(this as AdjectiveData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdjectiveData&&(identical(other.komparativ, komparativ) || other.komparativ == komparativ)&&(identical(other.superlativ, superlativ) || other.superlativ == superlativ));
}


@override
int get hashCode => Object.hash(runtimeType,komparativ,superlativ);

@override
String toString() {
  return 'AdjectiveData(komparativ: $komparativ, superlativ: $superlativ)';
}


}

/// @nodoc
abstract mixin class $AdjectiveDataCopyWith<$Res>  {
  factory $AdjectiveDataCopyWith(AdjectiveData value, $Res Function(AdjectiveData) _then) = _$AdjectiveDataCopyWithImpl;
@useResult
$Res call({
 String? komparativ, String? superlativ
});




}
/// @nodoc
class _$AdjectiveDataCopyWithImpl<$Res>
    implements $AdjectiveDataCopyWith<$Res> {
  _$AdjectiveDataCopyWithImpl(this._self, this._then);

  final AdjectiveData _self;
  final $Res Function(AdjectiveData) _then;

/// Create a copy of AdjectiveData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? komparativ = freezed,Object? superlativ = freezed,}) {
  return _then(_self.copyWith(
komparativ: freezed == komparativ ? _self.komparativ : komparativ // ignore: cast_nullable_to_non_nullable
as String?,superlativ: freezed == superlativ ? _self.superlativ : superlativ // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdjectiveData].
extension AdjectiveDataPatterns on AdjectiveData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdjectiveData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdjectiveData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdjectiveData value)  $default,){
final _that = this;
switch (_that) {
case _AdjectiveData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdjectiveData value)?  $default,){
final _that = this;
switch (_that) {
case _AdjectiveData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? komparativ,  String? superlativ)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdjectiveData() when $default != null:
return $default(_that.komparativ,_that.superlativ);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? komparativ,  String? superlativ)  $default,) {final _that = this;
switch (_that) {
case _AdjectiveData():
return $default(_that.komparativ,_that.superlativ);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? komparativ,  String? superlativ)?  $default,) {final _that = this;
switch (_that) {
case _AdjectiveData() when $default != null:
return $default(_that.komparativ,_that.superlativ);case _:
  return null;

}
}

}

/// @nodoc


class _AdjectiveData extends AdjectiveData {
  const _AdjectiveData({this.komparativ, this.superlativ}): super._();
  

// e.g. "schneller"
@override final  String? komparativ;
// e.g. "am schnellsten"
@override final  String? superlativ;

/// Create a copy of AdjectiveData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdjectiveDataCopyWith<_AdjectiveData> get copyWith => __$AdjectiveDataCopyWithImpl<_AdjectiveData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdjectiveData&&(identical(other.komparativ, komparativ) || other.komparativ == komparativ)&&(identical(other.superlativ, superlativ) || other.superlativ == superlativ));
}


@override
int get hashCode => Object.hash(runtimeType,komparativ,superlativ);

@override
String toString() {
  return 'AdjectiveData(komparativ: $komparativ, superlativ: $superlativ)';
}


}

/// @nodoc
abstract mixin class _$AdjectiveDataCopyWith<$Res> implements $AdjectiveDataCopyWith<$Res> {
  factory _$AdjectiveDataCopyWith(_AdjectiveData value, $Res Function(_AdjectiveData) _then) = __$AdjectiveDataCopyWithImpl;
@override @useResult
$Res call({
 String? komparativ, String? superlativ
});




}
/// @nodoc
class __$AdjectiveDataCopyWithImpl<$Res>
    implements _$AdjectiveDataCopyWith<$Res> {
  __$AdjectiveDataCopyWithImpl(this._self, this._then);

  final _AdjectiveData _self;
  final $Res Function(_AdjectiveData) _then;

/// Create a copy of AdjectiveData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? komparativ = freezed,Object? superlativ = freezed,}) {
  return _then(_AdjectiveData(
komparativ: freezed == komparativ ? _self.komparativ : komparativ // ignore: cast_nullable_to_non_nullable
as String?,superlativ: freezed == superlativ ? _self.superlativ : superlativ // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$WordLinguistics {

// Primary translation or explanation.
 String get definition;// Example sentence in German.
 String? get example;// English translation of [example]. Only present on entries generated
// after this field was added — older entries leave it null.
 String? get exampleTranslation; WordType? get wordType; CefrLevel? get level;// Exactly one of these is non-null, matching wordType.
 NounData? get nounData; VerbData? get verbData; AdjectiveData? get adjectiveData;
/// Create a copy of WordLinguistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordLinguisticsCopyWith<WordLinguistics> get copyWith => _$WordLinguisticsCopyWithImpl<WordLinguistics>(this as WordLinguistics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordLinguistics&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.example, example) || other.example == example)&&(identical(other.exampleTranslation, exampleTranslation) || other.exampleTranslation == exampleTranslation)&&(identical(other.wordType, wordType) || other.wordType == wordType)&&(identical(other.level, level) || other.level == level)&&(identical(other.nounData, nounData) || other.nounData == nounData)&&(identical(other.verbData, verbData) || other.verbData == verbData)&&(identical(other.adjectiveData, adjectiveData) || other.adjectiveData == adjectiveData));
}


@override
int get hashCode => Object.hash(runtimeType,definition,example,exampleTranslation,wordType,level,nounData,verbData,adjectiveData);

@override
String toString() {
  return 'WordLinguistics(definition: $definition, example: $example, exampleTranslation: $exampleTranslation, wordType: $wordType, level: $level, nounData: $nounData, verbData: $verbData, adjectiveData: $adjectiveData)';
}


}

/// @nodoc
abstract mixin class $WordLinguisticsCopyWith<$Res>  {
  factory $WordLinguisticsCopyWith(WordLinguistics value, $Res Function(WordLinguistics) _then) = _$WordLinguisticsCopyWithImpl;
@useResult
$Res call({
 String definition, String? example, String? exampleTranslation, WordType? wordType, CefrLevel? level, NounData? nounData, VerbData? verbData, AdjectiveData? adjectiveData
});


$NounDataCopyWith<$Res>? get nounData;$VerbDataCopyWith<$Res>? get verbData;$AdjectiveDataCopyWith<$Res>? get adjectiveData;

}
/// @nodoc
class _$WordLinguisticsCopyWithImpl<$Res>
    implements $WordLinguisticsCopyWith<$Res> {
  _$WordLinguisticsCopyWithImpl(this._self, this._then);

  final WordLinguistics _self;
  final $Res Function(WordLinguistics) _then;

/// Create a copy of WordLinguistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? definition = null,Object? example = freezed,Object? exampleTranslation = freezed,Object? wordType = freezed,Object? level = freezed,Object? nounData = freezed,Object? verbData = freezed,Object? adjectiveData = freezed,}) {
  return _then(_self.copyWith(
definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String,example: freezed == example ? _self.example : example // ignore: cast_nullable_to_non_nullable
as String?,exampleTranslation: freezed == exampleTranslation ? _self.exampleTranslation : exampleTranslation // ignore: cast_nullable_to_non_nullable
as String?,wordType: freezed == wordType ? _self.wordType : wordType // ignore: cast_nullable_to_non_nullable
as WordType?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as CefrLevel?,nounData: freezed == nounData ? _self.nounData : nounData // ignore: cast_nullable_to_non_nullable
as NounData?,verbData: freezed == verbData ? _self.verbData : verbData // ignore: cast_nullable_to_non_nullable
as VerbData?,adjectiveData: freezed == adjectiveData ? _self.adjectiveData : adjectiveData // ignore: cast_nullable_to_non_nullable
as AdjectiveData?,
  ));
}
/// Create a copy of WordLinguistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NounDataCopyWith<$Res>? get nounData {
    if (_self.nounData == null) {
    return null;
  }

  return $NounDataCopyWith<$Res>(_self.nounData!, (value) {
    return _then(_self.copyWith(nounData: value));
  });
}/// Create a copy of WordLinguistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerbDataCopyWith<$Res>? get verbData {
    if (_self.verbData == null) {
    return null;
  }

  return $VerbDataCopyWith<$Res>(_self.verbData!, (value) {
    return _then(_self.copyWith(verbData: value));
  });
}/// Create a copy of WordLinguistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdjectiveDataCopyWith<$Res>? get adjectiveData {
    if (_self.adjectiveData == null) {
    return null;
  }

  return $AdjectiveDataCopyWith<$Res>(_self.adjectiveData!, (value) {
    return _then(_self.copyWith(adjectiveData: value));
  });
}
}


/// Adds pattern-matching-related methods to [WordLinguistics].
extension WordLinguisticsPatterns on WordLinguistics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordLinguistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordLinguistics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordLinguistics value)  $default,){
final _that = this;
switch (_that) {
case _WordLinguistics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordLinguistics value)?  $default,){
final _that = this;
switch (_that) {
case _WordLinguistics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String definition,  String? example,  String? exampleTranslation,  WordType? wordType,  CefrLevel? level,  NounData? nounData,  VerbData? verbData,  AdjectiveData? adjectiveData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordLinguistics() when $default != null:
return $default(_that.definition,_that.example,_that.exampleTranslation,_that.wordType,_that.level,_that.nounData,_that.verbData,_that.adjectiveData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String definition,  String? example,  String? exampleTranslation,  WordType? wordType,  CefrLevel? level,  NounData? nounData,  VerbData? verbData,  AdjectiveData? adjectiveData)  $default,) {final _that = this;
switch (_that) {
case _WordLinguistics():
return $default(_that.definition,_that.example,_that.exampleTranslation,_that.wordType,_that.level,_that.nounData,_that.verbData,_that.adjectiveData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String definition,  String? example,  String? exampleTranslation,  WordType? wordType,  CefrLevel? level,  NounData? nounData,  VerbData? verbData,  AdjectiveData? adjectiveData)?  $default,) {final _that = this;
switch (_that) {
case _WordLinguistics() when $default != null:
return $default(_that.definition,_that.example,_that.exampleTranslation,_that.wordType,_that.level,_that.nounData,_that.verbData,_that.adjectiveData);case _:
  return null;

}
}

}

/// @nodoc


class _WordLinguistics extends WordLinguistics {
  const _WordLinguistics({required this.definition, this.example, this.exampleTranslation, this.wordType, this.level, this.nounData, this.verbData, this.adjectiveData}): super._();
  

// Primary translation or explanation.
@override final  String definition;
// Example sentence in German.
@override final  String? example;
// English translation of [example]. Only present on entries generated
// after this field was added — older entries leave it null.
@override final  String? exampleTranslation;
@override final  WordType? wordType;
@override final  CefrLevel? level;
// Exactly one of these is non-null, matching wordType.
@override final  NounData? nounData;
@override final  VerbData? verbData;
@override final  AdjectiveData? adjectiveData;

/// Create a copy of WordLinguistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordLinguisticsCopyWith<_WordLinguistics> get copyWith => __$WordLinguisticsCopyWithImpl<_WordLinguistics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordLinguistics&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.example, example) || other.example == example)&&(identical(other.exampleTranslation, exampleTranslation) || other.exampleTranslation == exampleTranslation)&&(identical(other.wordType, wordType) || other.wordType == wordType)&&(identical(other.level, level) || other.level == level)&&(identical(other.nounData, nounData) || other.nounData == nounData)&&(identical(other.verbData, verbData) || other.verbData == verbData)&&(identical(other.adjectiveData, adjectiveData) || other.adjectiveData == adjectiveData));
}


@override
int get hashCode => Object.hash(runtimeType,definition,example,exampleTranslation,wordType,level,nounData,verbData,adjectiveData);

@override
String toString() {
  return 'WordLinguistics(definition: $definition, example: $example, exampleTranslation: $exampleTranslation, wordType: $wordType, level: $level, nounData: $nounData, verbData: $verbData, adjectiveData: $adjectiveData)';
}


}

/// @nodoc
abstract mixin class _$WordLinguisticsCopyWith<$Res> implements $WordLinguisticsCopyWith<$Res> {
  factory _$WordLinguisticsCopyWith(_WordLinguistics value, $Res Function(_WordLinguistics) _then) = __$WordLinguisticsCopyWithImpl;
@override @useResult
$Res call({
 String definition, String? example, String? exampleTranslation, WordType? wordType, CefrLevel? level, NounData? nounData, VerbData? verbData, AdjectiveData? adjectiveData
});


@override $NounDataCopyWith<$Res>? get nounData;@override $VerbDataCopyWith<$Res>? get verbData;@override $AdjectiveDataCopyWith<$Res>? get adjectiveData;

}
/// @nodoc
class __$WordLinguisticsCopyWithImpl<$Res>
    implements _$WordLinguisticsCopyWith<$Res> {
  __$WordLinguisticsCopyWithImpl(this._self, this._then);

  final _WordLinguistics _self;
  final $Res Function(_WordLinguistics) _then;

/// Create a copy of WordLinguistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? definition = null,Object? example = freezed,Object? exampleTranslation = freezed,Object? wordType = freezed,Object? level = freezed,Object? nounData = freezed,Object? verbData = freezed,Object? adjectiveData = freezed,}) {
  return _then(_WordLinguistics(
definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String,example: freezed == example ? _self.example : example // ignore: cast_nullable_to_non_nullable
as String?,exampleTranslation: freezed == exampleTranslation ? _self.exampleTranslation : exampleTranslation // ignore: cast_nullable_to_non_nullable
as String?,wordType: freezed == wordType ? _self.wordType : wordType // ignore: cast_nullable_to_non_nullable
as WordType?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as CefrLevel?,nounData: freezed == nounData ? _self.nounData : nounData // ignore: cast_nullable_to_non_nullable
as NounData?,verbData: freezed == verbData ? _self.verbData : verbData // ignore: cast_nullable_to_non_nullable
as VerbData?,adjectiveData: freezed == adjectiveData ? _self.adjectiveData : adjectiveData // ignore: cast_nullable_to_non_nullable
as AdjectiveData?,
  ));
}

/// Create a copy of WordLinguistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NounDataCopyWith<$Res>? get nounData {
    if (_self.nounData == null) {
    return null;
  }

  return $NounDataCopyWith<$Res>(_self.nounData!, (value) {
    return _then(_self.copyWith(nounData: value));
  });
}/// Create a copy of WordLinguistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerbDataCopyWith<$Res>? get verbData {
    if (_self.verbData == null) {
    return null;
  }

  return $VerbDataCopyWith<$Res>(_self.verbData!, (value) {
    return _then(_self.copyWith(verbData: value));
  });
}/// Create a copy of WordLinguistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdjectiveDataCopyWith<$Res>? get adjectiveData {
    if (_self.adjectiveData == null) {
    return null;
  }

  return $AdjectiveDataCopyWith<$Res>(_self.adjectiveData!, (value) {
    return _then(_self.copyWith(adjectiveData: value));
  });
}
}

/// @nodoc
mixin _$Word {

 String get id; String get collectionId;// The German word or phrase as it appears in a dictionary.
 String get term; WordLinguistics get linguistics; DateTime get createdAt;// Links back to the global dictionary entry this word was sourced from.
 String? get dictionaryEntryId;
/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordCopyWith<Word> get copyWith => _$WordCopyWithImpl<Word>(this as Word, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Word&&(identical(other.id, id) || other.id == id)&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId)&&(identical(other.term, term) || other.term == term)&&(identical(other.linguistics, linguistics) || other.linguistics == linguistics)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.dictionaryEntryId, dictionaryEntryId) || other.dictionaryEntryId == dictionaryEntryId));
}


@override
int get hashCode => Object.hash(runtimeType,id,collectionId,term,linguistics,createdAt,dictionaryEntryId);

@override
String toString() {
  return 'Word(id: $id, collectionId: $collectionId, term: $term, linguistics: $linguistics, createdAt: $createdAt, dictionaryEntryId: $dictionaryEntryId)';
}


}

/// @nodoc
abstract mixin class $WordCopyWith<$Res>  {
  factory $WordCopyWith(Word value, $Res Function(Word) _then) = _$WordCopyWithImpl;
@useResult
$Res call({
 String id, String collectionId, String term, WordLinguistics linguistics, DateTime createdAt, String? dictionaryEntryId
});


$WordLinguisticsCopyWith<$Res> get linguistics;

}
/// @nodoc
class _$WordCopyWithImpl<$Res>
    implements $WordCopyWith<$Res> {
  _$WordCopyWithImpl(this._self, this._then);

  final Word _self;
  final $Res Function(Word) _then;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? collectionId = null,Object? term = null,Object? linguistics = null,Object? createdAt = null,Object? dictionaryEntryId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,collectionId: null == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as String,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,linguistics: null == linguistics ? _self.linguistics : linguistics // ignore: cast_nullable_to_non_nullable
as WordLinguistics,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,dictionaryEntryId: freezed == dictionaryEntryId ? _self.dictionaryEntryId : dictionaryEntryId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordLinguisticsCopyWith<$Res> get linguistics {
  
  return $WordLinguisticsCopyWith<$Res>(_self.linguistics, (value) {
    return _then(_self.copyWith(linguistics: value));
  });
}
}


/// Adds pattern-matching-related methods to [Word].
extension WordPatterns on Word {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Word value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Word() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Word value)  $default,){
final _that = this;
switch (_that) {
case _Word():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Word value)?  $default,){
final _that = this;
switch (_that) {
case _Word() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String collectionId,  String term,  WordLinguistics linguistics,  DateTime createdAt,  String? dictionaryEntryId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Word() when $default != null:
return $default(_that.id,_that.collectionId,_that.term,_that.linguistics,_that.createdAt,_that.dictionaryEntryId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String collectionId,  String term,  WordLinguistics linguistics,  DateTime createdAt,  String? dictionaryEntryId)  $default,) {final _that = this;
switch (_that) {
case _Word():
return $default(_that.id,_that.collectionId,_that.term,_that.linguistics,_that.createdAt,_that.dictionaryEntryId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String collectionId,  String term,  WordLinguistics linguistics,  DateTime createdAt,  String? dictionaryEntryId)?  $default,) {final _that = this;
switch (_that) {
case _Word() when $default != null:
return $default(_that.id,_that.collectionId,_that.term,_that.linguistics,_that.createdAt,_that.dictionaryEntryId);case _:
  return null;

}
}

}

/// @nodoc


class _Word extends Word {
  const _Word({required this.id, required this.collectionId, required this.term, required this.linguistics, required this.createdAt, this.dictionaryEntryId}): super._();
  

@override final  String id;
@override final  String collectionId;
// The German word or phrase as it appears in a dictionary.
@override final  String term;
@override final  WordLinguistics linguistics;
@override final  DateTime createdAt;
// Links back to the global dictionary entry this word was sourced from.
@override final  String? dictionaryEntryId;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordCopyWith<_Word> get copyWith => __$WordCopyWithImpl<_Word>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Word&&(identical(other.id, id) || other.id == id)&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId)&&(identical(other.term, term) || other.term == term)&&(identical(other.linguistics, linguistics) || other.linguistics == linguistics)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.dictionaryEntryId, dictionaryEntryId) || other.dictionaryEntryId == dictionaryEntryId));
}


@override
int get hashCode => Object.hash(runtimeType,id,collectionId,term,linguistics,createdAt,dictionaryEntryId);

@override
String toString() {
  return 'Word(id: $id, collectionId: $collectionId, term: $term, linguistics: $linguistics, createdAt: $createdAt, dictionaryEntryId: $dictionaryEntryId)';
}


}

/// @nodoc
abstract mixin class _$WordCopyWith<$Res> implements $WordCopyWith<$Res> {
  factory _$WordCopyWith(_Word value, $Res Function(_Word) _then) = __$WordCopyWithImpl;
@override @useResult
$Res call({
 String id, String collectionId, String term, WordLinguistics linguistics, DateTime createdAt, String? dictionaryEntryId
});


@override $WordLinguisticsCopyWith<$Res> get linguistics;

}
/// @nodoc
class __$WordCopyWithImpl<$Res>
    implements _$WordCopyWith<$Res> {
  __$WordCopyWithImpl(this._self, this._then);

  final _Word _self;
  final $Res Function(_Word) _then;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? collectionId = null,Object? term = null,Object? linguistics = null,Object? createdAt = null,Object? dictionaryEntryId = freezed,}) {
  return _then(_Word(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,collectionId: null == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as String,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,linguistics: null == linguistics ? _self.linguistics : linguistics // ignore: cast_nullable_to_non_nullable
as WordLinguistics,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,dictionaryEntryId: freezed == dictionaryEntryId ? _self.dictionaryEntryId : dictionaryEntryId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordLinguisticsCopyWith<$Res> get linguistics {
  
  return $WordLinguisticsCopyWith<$Res>(_self.linguistics, (value) {
    return _then(_self.copyWith(linguistics: value));
  });
}
}

// dart format on
