import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_color.dart';

part 'collection.freezed.dart';

@freezed
abstract class Collection with _$Collection {
  const Collection._();

  const factory Collection({
    required String id,
    required String ownerId,
    required String title,
    String? description,
    @Default(CollectionColor.violet) CollectionColor color,
    @Default(false) bool isPublic,
    @Default(0) int wordCount,
    @Default(0) int wordsLearned,
    @Default('de') String language,
    @Default(<String>[]) List<String> tags,
    DateTime? lastStudiedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Collection;

  /// Fraction of [wordCount] that's [wordsLearned], in [0, 1]. 0 when the
  /// collection is empty — the single formula every mastery-percent display
  /// in the app derives from, so they can't drift apart.
  double get masteryFraction => fractionOf(wordsLearned, wordCount);

  /// Safe divide-as-fraction: 0 when [total] is 0, otherwise clamped to
  /// [0, 1]. Exposed statically so aggregate stats (e.g. mastery summed
  /// across every collection) use the exact same formula as [masteryFraction].
  static double fractionOf(int part, int total) =>
      total > 0 ? (part / total).clamp(0.0, 1.0) : 0.0;
}
