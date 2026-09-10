import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/feature/learning/domain/services/fsrs_word_progress_scheduler.dart';

final wordProgressSchedulerProvider = Provider<FsrsWordProgressScheduler>(
  (ref) => FsrsWordProgressScheduler(),
);
