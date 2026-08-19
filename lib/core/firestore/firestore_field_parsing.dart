// Shared by every repository's fromFirestore mapper, so "read a nullable
// numeric field, falling back to a default when it's missing" is written
// once instead of `(data[key] as num?)?.toInt() ?? fallback` per field.
int intOrDefault(Map<String, dynamic> data, String key, [int fallback = 0]) =>
    (data[key] as num?)?.toInt() ?? fallback;
