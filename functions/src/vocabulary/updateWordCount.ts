import { onDocumentWritten } from "firebase-functions/v2/firestore";
import { logger } from "firebase-functions";
import { getFirestore } from "firebase-admin/firestore";

/**
 * Keeps every affected Collection.wordCount in sync whenever a word is
 * created, updated, or deleted.
 *
 * Words live in a single flat `users/{userId}/words/{wordId}` collection and
 * belong to zero or more collections via their `collectionIds` array field
 * (a word can be in several collections at once) — so one word write can
 * change the count for multiple collections at once: any collectionId that
 * was added to or removed from `collectionIds` needs its count redone.
 *
 * Re-counts from scratch for each affected collection (via an
 * `array-contains` query) rather than incrementing/decrementing a running
 * total — self-healing: even if wordCount ever drifts from reality (manual
 * Firestore edit, a failed write, a bug), the next word change recomputes
 * the true count instead of adjusting a possibly-already-wrong number. One
 * function covers add + remove + move-between-collections, no separate
 * onDocumentDeleted needed.
 */
export const onWordsChanged = onDocumentWritten(
  {
    document: "users/{userId}/words/{wordId}",
    region: "europe-west1",
  },
  async (event) => {
    const { userId } = event.params;

    const beforeIds: string[] = event.data?.before?.data()?.collectionIds ?? [];
    const afterIds: string[] = event.data?.after?.data()?.collectionIds ?? [];

    // Union of old + new membership — any collection in either set could
    // have gained or lost this word, and needs its count redone. A
    // collection present in both is safe to recompute too; it's just a
    // wasted (cheap) read, not a correctness issue.
    const affectedCollectionIds = new Set([...beforeIds, ...afterIds]);

    if (affectedCollectionIds.size === 0) return;

    const firestore = getFirestore();
    const userRef = firestore.collection("users").doc(userId);
    const wordsRef = userRef.collection("words");

    await Promise.all(
      Array.from(affectedCollectionIds).map(async (collectionId) => {
        const { count } = (
          await wordsRef
            .where("collectionIds", "array-contains", collectionId)
            .count()
            .get()
        ).data();

        try {
          await userRef.collection("collections").doc(collectionId).update({
            wordCount: count,
          });
        } catch (error) {
          // Collection may have been deleted concurrently — don't fail the
          // whole batch of updates over one missing doc.
          logger.warn(
            `Failed to update wordCount for users/${userId}/collections/${collectionId}`,
            error
          );
        }
      })
    );
  }
);