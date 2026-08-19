import { onDocumentWritten } from "firebase-functions/v2/firestore";
import { getFirestore } from "firebase-admin/firestore";

/**
 * Keeps Collection.wordCount in sync with the actual number of words in its
 * `words` subcollection.
 *
 * Re-counts from scratch on every create/update/delete (onDocumentWritten)
 * rather than incrementing/decrementing a running total — self-healing:
 * even if wordCount ever drifts from reality (manual Firestore edit, a
 * failed write, a bug), the next word change recomputes the true count
 * instead of adjusting a possibly-already-wrong number. One function covers
 * add + remove, no separate onDocumentDeleted needed.
 */
export const onWordsChanged = onDocumentWritten(
  {
    document: "users/{userId}/collections/{collectionId}/words/{wordId}",
    region: "europe-west1",
  },
  async (event) => {
    const { userId, collectionId } = event.params;
    const collectionRef = getFirestore()
      .collection("users")
      .doc(userId)
      .collection("collections")
      .doc(collectionId);

    const { count } = (await collectionRef.collection("words").count().get()).data();
    await collectionRef.update({ wordCount: count });
  }
);
