import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_color.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_icon.dart';

class Collection {
  Collection({
    required this.id,
    required this.ownerId,
    required this.title,
    this.description,
    this.color = CollectionColor.purple,
    this.icon = CollectionIcon.none,
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
  CollectionIcon icon;
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

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'] as String,
      ownerId: json['ownerId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      color: CollectionColor.fromString(json['color'] as String? ?? 'purple'),
      icon: CollectionIcon.fromString(json['icon'] as String? ?? 'none'),
      isPublic: json['isPublic'] as bool? ?? false,
      wordCount: json['wordCount'] as int? ?? 0,
      wordsLearned: json['wordsLearned'] as int? ?? 0,
      language: json['language'] as String? ?? 'de',
      tags: List<String>.from(
          json['tags'] as List<dynamic>? ?? const <String>[]),
      lastStudiedAt: (json['lastStudiedAt'] as Timestamp?)?.toDate(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'color': color.name,
      'icon': icon.name,
      'isPublic': isPublic,
      'wordCount': wordCount,
      'wordsLearned': wordsLearned,
      'language': language,
      'tags': tags,
      'lastStudiedAt': lastStudiedAt != null ? Timestamp.fromDate(lastStudiedAt!) : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  Collection copyWith({
    String? title,
    String? description,
    CollectionColor? color,
    CollectionIcon? icon,
    bool? isPublic,
    int? wordCount,
    int? wordsLearned,
    String? language,
    List<String>? tags,
    DateTime? lastStudiedAt,
  }) {
    return Collection(
      id: id,
      ownerId: ownerId,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      isPublic: isPublic ?? this.isPublic,
      wordCount: wordCount ?? this.wordCount,
      wordsLearned: wordsLearned ?? this.wordsLearned,
      language: language ?? this.language,
      tags: tags ?? this.tags,
      lastStudiedAt: lastStudiedAt ?? this.lastStudiedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}