import 'package:slovo/feature/vocabulary/domain/models/collection_color.dart';

class Collection{
  Collection({
    required this.id,
    required this.ownerId,
    required this.title,
    this.description,
    this.color = CollectionColor.violet,
    this.isPublic = false,
    this.wordCount = 0,
    this.wordsLearned = 0,
    this.language = 'de',
    this.tags = const <String>[],
    this.lastStudiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String ownerId;
  final String title;
  String? description;
  CollectionColor color;
  bool isPublic;
  int wordCount;
  int wordsLearned;
  String language;
  List<String> tags;
  DateTime? lastStudiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  double get masteryFraction => fractionOf(wordsLearned, wordCount);

  /// Safe divide-as-fraction: 0 when [total] is 0, otherwise clamped to
  /// [0, 1]. Exposed statically so aggregate stats (e.g. mastery summed
  /// across every collection) use the exact same formula as [masteryFraction].
  static double fractionOf(int part, int total) =>
      total > 0 ? (part / total).clamp(0.0, 1.0) : 0.0;
}
