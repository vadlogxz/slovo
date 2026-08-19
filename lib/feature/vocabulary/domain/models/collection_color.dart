import 'package:slovo/core/utils/enum_from_name.dart';

enum CollectionColor {
  teal,
  violet,
  pink,
  gold,
  green,
  purple;

  static CollectionColor fromString(String? value) =>
      enumFromName(values, value) ?? CollectionColor.violet;
}
