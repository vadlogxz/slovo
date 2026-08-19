// Shared by every enum in the app that needs to parse itself back from a
// Firestore string field, so the "look up by .name, null on no match" lookup
// is written once instead of re-implemented per enum.
T? enumFromName<T extends Enum>(List<T> values, String? name) =>
    values.where((e) => e.name == name).firstOrNull;
