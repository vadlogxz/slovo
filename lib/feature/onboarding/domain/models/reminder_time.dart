import 'package:slovo/core/assets/app_assets.dart';

enum ReminderTime {
  morning(hour: 7, minute: 0, label: 'Morning', icon: AppAssets.morning),
  afternoon(hour: 12, minute: 0, label: 'Afternoon', icon: AppAssets.afternoon),
  evening(hour: 18, minute: 0, label: 'Evening', icon: AppAssets.evening),
  night(hour: 21, minute: 0, label: 'Night', icon: AppAssets.night);

  const ReminderTime({
    required this.hour,
    required this.minute,
    required this.label,
    required this.icon,
  });

  final int hour;
  final int minute;
  final String label;
  final String icon;

  String get timeLabel => '${hour.toString().padLeft(2,'0')}:${minute.toString().padLeft(2, '0')}';
}
