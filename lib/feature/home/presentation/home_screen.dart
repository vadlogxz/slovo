import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/profile/di/profile_provider.dart';
import 'package:slovo/shared/widgets/_.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        spacing: AppSpacing.md,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_Greetings(), _DailyStreak()],
          ),
          _DailyProgress(),
          _StartLearningButton(),
          _StatsSection(),
        ],
      ),
    );
  }
}

class _Greetings extends ConsumerWidget {
  const _Greetings();

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Guten Morgen';
    } else if (hour < 18) {
      return 'Guten Tag';
    } else {
      return 'Guten Abend';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? userName = ref.watch(
      profileProvider.select(
        (userProfile) => userProfile.asData?.value.displayName,
      ),
    );
    return Skeletonizer(
      enabled: userName == null,
      enableSwitchAnimation: true,
      effect: ShimmerEffect(
        baseColor: context.colors.surface,
        highlightColor: context.colors.surface.withValues(alpha: 0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_getGreeting()},',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Row(
            children: [
              Text(
                userName ?? 'Gast',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontSize: 24),
              ),
              Skeleton.ignore(
                child: LottieBuilder.asset(
                  AppAssets.hiHandAnimation,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  repeat: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DailyStreak extends ConsumerWidget {
  const _DailyStreak();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyStreak = ref.watch(
      profileProvider.select(
        (userProfile) => userProfile.asData?.value.streak ?? 0,
      ),
    );
    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.sm,
        right: AppSpacing.md,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppAccents.rating,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(width: 2, color: context.colors.primaryDark),
      ),
      child: Row(
        children: [
          AppIcon(path: AppAssets.flame, color: AppAccents.flame),
          SizedBox(width: AppSpacing.sm),
          Text(
            dailyStreak.toString(),
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _DailyProgress extends ConsumerWidget {
  const _DailyProgress();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyGoalMinutes = ref.watch(
      profileProvider.select((p) => p.asData?.value.dailyGoalMinutes),
    );

    int minutesCompleted = 12; // Placeholder for completed minutes, should be fetched from user data

    double progress = dailyGoalMinutes != null && dailyGoalMinutes > 0
        ? minutesCompleted / dailyGoalMinutes
        : 0.0;

    //TODO: Implement logic to calculate progress based on user's daily goal and completed minutes
    // Now we are using a placeholder value for demonstration purposes.
    // Also need to implement animation when user complete the daily goal and show a star icon with a glow effect

    return Skeletonizer(
      enabled: dailyGoalMinutes == null,
      enableSwitchAnimation: true,
      effect: ShimmerEffect(
        baseColor: context.colors.surface.withValues(alpha: 0.2),
        highlightColor: context.colors.surface.withValues(alpha: 0.6),
      ),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.circular(AppSpacing.md),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TODAY',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: context.colors.textOnBrand.withValues(alpha: 0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: minutesCompleted.toString(),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 24,
                      color: context.colors.textOnBrand,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' / $dailyGoalMinutes min',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: context.colors.textOnBrand.withValues(alpha: 0.4),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Skeleton.replace(
                    height: 10,
                    replacement: Bone(borderRadius: BorderRadius.circular(AppRadius.sm)),
                    child: AppProgressBar(
                      value: progress,
                      height: 8,
                      backgroundColor: AppAccents.rating,
                    ),
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Skeleton.replace(
                  height: 36,
                  width: 36,
                  replacement: Bone(shape: BoxShape.circle),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: progress >= 1
                          ? AppAccents.rating.withValues(alpha: 0.4)
                          : Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.star,
                      color: progress >= 1 ? AppAccents.rating : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StartLearningButton extends StatelessWidget {
  const _StartLearningButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      // TODO: Set onTap to navigate to the learning screen
      onTap: () {},
      backgroundColor: context.colors.primaryDark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: AppSpacing.md,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppAccents.rating,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.play_arrow, color: context.colors.primaryDark),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start Learning',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: context.colors.textOnBrand,
                  fontSize: 18,
                ),
              ),
              Text(
                'Recommended for you',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: context.colors.textOnBrand.withValues(alpha: 0.6),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'My words',
            value: '120',
            icon: Icons.bookmark,
            color: context.colors.primary,
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatCard(
            title: 'Collections',
            value: '8',
            icon: Icons.folder,
            color: AppAccents.mint,
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatCard(
            title: 'Stats',
            value: '91%',
            icon: Icons.stacked_bar_chart,
            color: AppAccents.flame,
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatCard(
            title: 'Daily goal',
            value: '20m',
            icon: Icons.access_time,
            color: AppAccents.blue,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends ConsumerWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(color: context.colors.outline, width: 2),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: AppSpacing.sm),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 13,
                color: context.colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
