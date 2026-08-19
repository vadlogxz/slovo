import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:slovo/core/error/firestore_error_handling.dart';
import 'package:slovo/core/firestore/firestore_paths.dart';
import 'package:slovo/core/firestore/firestore_query_streaming.dart';
import 'package:slovo/feature/study/domain/models/card_progress.dart';
import 'package:slovo/feature/study/domain/repositories/card_progress_repository.dart';

// CardProgress is a pure-Dart domain model (per architecture.md), so its
// Firestore (de)serialization — which needs the Timestamp type — lives here
// in the data layer instead of on the model itself.
CardProgress _progressFromFirestore(String wordId, Map<String, dynamic> data) {
  return CardProgress(
    wordId: wordId,
    collectionId: data['collectionId'] as String,
    card: fsrs.Card(
      cardId: (data['cardId'] as num).toInt(),
      state: fsrs.State.fromValue((data['state'] as num).toInt()),
      step: (data['step'] as num?)?.toInt(),
      stability: (data['stability'] as num?)?.toDouble(),
      difficulty: (data['difficulty'] as num?)?.toDouble(),
      due: (data['due'] as Timestamp).toDate().toUtc(),
      lastReview: (data['lastReview'] as Timestamp?)?.toDate().toUtc(),
    ),
  );
}

Map<String, dynamic> _progressToFirestore(CardProgress progress) => {
  'collectionId': progress.collectionId,
  'cardId': progress.card.cardId,
  'state': progress.card.state.value,
  if (progress.card.step != null) 'step': progress.card.step,
  if (progress.card.stability != null) 'stability': progress.card.stability,
  if (progress.card.difficulty != null) 'difficulty': progress.card.difficulty,
  'due': Timestamp.fromDate(progress.card.due),
  if (progress.card.lastReview != null)
    'lastReview': Timestamp.fromDate(progress.card.lastReview!),
};

class FirestoreCardProgressRepository implements CardProgressRepository {
  FirestoreCardProgressRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  // Doc ID = wordId, matching _progressFromFirestore(wordId, data).
  CollectionReference<Map<String, dynamic>> _progressRef(String userId) =>
      _firestore.collection('users').doc(userId).collection('progress');

  CollectionReference<Map<String, dynamic>> _collectionsRef(String userId) =>
      _firestore.userCollectionsRef(userId);

  @override
  Stream<List<CardProgress>> watchCollectionProgress(
    String userId,
    String collectionId,
  ) {
    return watchQueryAsList(
      _progressRef(userId).where('collectionId', isEqualTo: collectionId),
      _progressFromFirestore,
    );
  }

  @override
  Stream<List<CardProgress>> watchAllProgress(String userId) {
    return watchQueryAsList(_progressRef(userId), _progressFromFirestore);
  }

  @override
  Future<void> saveProgress(
    String userId,
    CardProgress progress, {
    int wordsLearnedDelta = 0,
  }) {
    return wrapFirestoreErrors(() async {
      final batch = _firestore.batch();
      batch.set(
        _progressRef(userId).doc(progress.wordId),
        _progressToFirestore(progress),
      );
      if (wordsLearnedDelta != 0) {
        batch.update(_collectionsRef(userId).doc(progress.collectionId), {
          'wordsLearned': FieldValue.increment(wordsLearnedDelta),
        });
      }
      await batch.commit();
    });
  }
}
