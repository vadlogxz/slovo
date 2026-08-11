import '../../../../core/utils/enum_from_name.dart';

enum CollectionIcon {
  none,
  book,
  star,
  heart,
  flag,
  school,
  travel,
  work,
  food,
  music,
  movie,
  sport,
  nature,
  science,
  home;

  static CollectionIcon fromString(String? value) =>
      enumFromName(values, value) ?? CollectionIcon.none;
}