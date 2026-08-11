import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_icon.dart';

import '../models/collection_color.dart';

abstract class CollectionRepository {
  Stream<List<Collection>> getUserCollections({required String userId});

  Future<void> createCollection({
    required String userId,
    required String title,
    required CollectionIcon icon,
    required CollectionColor color,
    String? description,
});
}