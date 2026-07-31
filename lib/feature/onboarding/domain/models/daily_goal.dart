import 'package:slovo/core/utils/enum_from_name.dart';

import '../../../../core/assets/app_assets.dart';

enum DailyGoal {
  casual(
    title: 'Casual',
    description: '~5 words a day',
    iconPath: AppAssets.coffee,
    minutes: 5,

  ),
  regular(
    title: 'Regular',
    description: '~12 words a day',
    iconPath: AppAssets.target,
    minutes: 10,
  ),
  serious(
    title: 'Serious',
    description: '~20 words a day',
    iconPath: AppAssets.zap,
    minutes: 20,
  ),
  intense(
    title: 'Intense',
    description: '~30 words a day',
    iconPath: AppAssets.flame,
    minutes: 30,
  );

  const DailyGoal({
    required this.title,
    required this.description,
    required this.minutes,
    required this.iconPath,
  });

  final String title;
  final String description;
  final int minutes;
  final String iconPath;

  static DailyGoal fromName(String name) =>
      enumFromName(values, name) ?? regular;
}
