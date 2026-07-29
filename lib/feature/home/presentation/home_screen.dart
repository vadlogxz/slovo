import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/home/presentation/widgets/_.dart';
import 'package:slovo/feature/profile/di/profile_provider.dart';
import 'package:slovo/feature/profile/domain/models/user_profile.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/presentation/mock_vocabulary_data.dart';
import 'package:slovo/shared/widgets/_.dart';

import '../../auth/di/auth_provider.dart';

// No profile backend behind Home — streak/daily-goal display a fixed mock
// profile instead of reading a Firestore-backed provider.


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HomeHeader(),
                const SizedBox(height: AppSpacing.xl),
                const _WordsDueSection(),
                const SizedBox(height: AppSpacing.xl),
                const _DailyGoalSection(),
                const SizedBox(height: AppSpacing.xl),
                const _StatsSection(),
                const SizedBox(height: AppSpacing.xl),
                const _ContinueLearningSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends ConsumerWidget {
  const _HomeHeader();

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    return 'Good evening,';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final userProfile = ref.watch(profileProvider);
    final displayName = userProfile.displayName ?? currentUser?.name;

    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _greeting,
                style: tt.bodyMedium?.copyWith(color: colors.textSecondary),
              ),
              Text(displayName ?? 'Unknown', style: tt.titleLarge),
            ],
          ),
        ),
        StreakBadge(streak: userProfile.streak),
      ],
    );
  }
}

class _DailyGoalSection extends ConsumerWidget {
  const _DailyGoalSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(profileProvider);
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    final goalMinutes = userProfile.dailyGoalMinutes;
    const currentMinutes = 1;
    final progress = goalMinutes > 0 ? currentMinutes / goalMinutes : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'DAILY GOAL',
              style: tt.headlineSmall?.copyWith(
                color: colors.textMuted,
                letterSpacing: 1.2,
                fontSize: 14,
              ),
            ),
            Text(
              '$currentMinutes / $goalMinutes minutes',
              style: tt.labelMedium?.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ProgressBar(value: progress),
      ],
    );
  }
}

// ~30s per word review is a rough estimate until FSRS session timing exists.
const _secondsPerWordReview = 30;

class _WordsDueSection extends StatelessWidget {
  const _WordsDueSection();

  @override
  Widget build(BuildContext context) {
    // No FSRS progress data behind Home — "due" is approximated as the
    // words in each collection that haven't been marked learned yet.
    final collectionsWithDueWords = <String>{};
    final wordsDue = mockCollections.fold<int>(0, (sum, c) {
      final due = (c.wordCount - c.wordsLearned).clamp(0, c.wordCount);
      if (due > 0) collectionsWithDueWords.add(c.id);
      return sum + due;
    });
    final estimatedMinutes = (wordsDue * _secondsPerWordReview / 60).ceil();

    return WordsDueCard(
      wordCount: wordsDue,
      collectionCount: collectionsWithDueWords.length,
      estimatedMinutes: estimatedMinutes,
      onStart: wordsDue == 0
          ? null
          : () => collectionsWithDueWords.length == 1
                ? context.pushNamed(
                    AppRoutes.learnSession.name,
                    pathParameters: {
                      'collectionId': collectionsWithDueWords.single,
                    },
                  )
                : context.pushNamed(AppRoutes.vocabulary.name),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    final wordsLearned =
        mockCollections.fold<int>(0, (sum, c) => sum + c.wordsLearned);
    final totalWords =
        mockCollections.fold<int>(0, (sum, c) => sum + c.wordCount);
    final masteredPercent =
        (Collection.fractionOf(wordsLearned, totalWords) * 100).round();

    return Row(
      spacing: AppSpacing.md,
      children: [
        Expanded(child: DataCard(title: '$wordsLearned', subtitle: 'Words learned')),
        Expanded(child: DataCard(title: '$masteredPercent%', subtitle: 'Mastery overall')),
      ],
    );
  }
}

class _ContinueLearningSection extends StatelessWidget {
  const _ContinueLearningSection();

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    final recentCollections = mockCollections.toList()
      ..sort((a, b) {
        final aTime = a.lastStudiedAt ?? a.updatedAt;
        final bTime = b.lastStudiedAt ?? b.updatedAt;
        return bTime.compareTo(aTime);
      });
    final topCollections = recentCollections.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'CONTINUE LEARNING',
              style: tt.labelSmall?.copyWith(
                color: colors.textMuted,
                letterSpacing: 1.2,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => context.pushNamed(AppRoutes.vocabulary.name),
              child: Row(
                children: [
                  Text(
                    'See all',
                    style: tt.labelMedium?.copyWith(color: colors.primary),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Icon(Icons.arrow_forward_ios_rounded, size: 11, color: colors.primary),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Column(
          spacing: AppSpacing.sm,
          children: [
            ...topCollections.map((c) => _ContinueLearningCard(collection: c)),
            _NewCollectionButton(
              onTap: () => context.pushNamed(AppRoutes.createCollection.name),
            ),
          ],
        ),
      ],
    );
  }
}

class _NewCollectionButton extends StatefulWidget {
  const _NewCollectionButton({this.onTap});

  final VoidCallback? onTap;

  @override
  State<_NewCollectionButton> createState() => _NewCollectionButtonState();
}

class _NewCollectionButtonState extends State<_NewCollectionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 90),
        curve: Curves.easeOut,
        child: CustomPaint(
          painter: _DashedRectPainter(color: colors.primary.withValues(alpha: 0.45)),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSpacing.sm,
                children: [
                  Icon(Icons.add_rounded, size: 18, color: colors.primary),
                  Text(
                    'New collection',
                    style: tt.labelLarge?.copyWith(color: colors.primary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedRectPainter extends CustomPainter {
  const _DashedRectPainter({required this.color});

  final Color color;

  static const _dashWidth = 6.0;
  static const _dashGap = 4.0;
  static const _strokeWidth = 1.5;
  static const _radius = AppRadius.md;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          _strokeWidth / 2,
          _strokeWidth / 2,
          size.width - _strokeWidth,
          size.height - _strokeWidth,
        ),
        const Radius.circular(_radius),
      ));

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + _dashWidth), paint);
        distance += _dashWidth + _dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedRectPainter old) => old.color != color;
}

class _ContinueLearningCard extends StatelessWidget {
  const _ContinueLearningCard({required this.collection});

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;
    final masteredPercent = collection.masteryFraction;
    final mastered = (masteredPercent * 100).round();

    return GestureDetector(
      onTap: () => context.pushNamed(
        AppRoutes.collectionDetail.name,
        pathParameters: {'collectionId': collection.id},
      ),
      child: Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.outline),
      ),
      child: Row(
        children: [
          IconAvatar(
            radius: AppRadius.sm,
            backgroundColor: colors.surfaceSubtle,
            icon: AppIcon(
              path: AppAssets.appLogo,
              size: 22,
              color: colors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(collection.title, style: tt.titleSmall),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${collection.wordCount} ${collection.wordCount == 1 ? 'word' : 'words'} · $mastered% mastered',
                  style: tt.bodySmall?.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              value: masteredPercent,
              strokeWidth: 4.5,
              strokeCap: StrokeCap.round,
              color: colors.primary,
              backgroundColor: colors.primary12,
            ),
          ),
        ],
      ),
      ),
    );
  }
}
