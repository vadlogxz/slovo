import 'package:slovo/core/utils/enum_from_name.dart';

enum CollectionColor {
  yellow,
  orange,
  mint,
  coral,
  blue,
  purple;

  static CollectionColor fromString(String? value) =>
      enumFromName(values, value) ?? CollectionColor.purple;


}
