import 'package:slovo/core/utils/enum_from_name.dart';

enum DailyGoal {
  casual(title: 'Casual', description: '~5 words a day', minutes: 5),
  regular(title: 'Regular', description: '~12 words a day', minutes: 10),
  serious(title: 'Serious', description: '~20 words a day', minutes: 15),
  intense(title: 'Intense', description: '~30 words a day', minutes: 20);

  const DailyGoal({
    required this.title,
    required this.description,
    required this.minutes,
  });

  final String title;
  final String description;
  final int minutes;

  static DailyGoal fromName(String name) =>
      enumFromName(values, name) ?? regular;
}
