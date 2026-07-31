import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/onboarding/di/onboarding_provider.dart';
import 'package:slovo/feature/onboarding/domain/models/_.dart';
import 'package:slovo/shared/mixins/_.dart';
import 'package:slovo/shared/widgets/_.dart';

class DailyGoalScreen extends ConsumerStatefulWidget {
  const DailyGoalScreen({super.key});

  @override
  ConsumerState<DailyGoalScreen> createState() => _DailyGoalScreenState();
}

class _DailyGoalScreenState extends ConsumerState<DailyGoalScreen>
    with SingleTickerProviderStateMixin, StaggerAnimationMixin {

  late final ({Animation<double> fade, Animation<Offset> slide}) _header;
  late final List<({Animation<double> fade, Animation<Offset> slide})> _items;
  late final ({Animation<double> fade, Animation<Offset> slide}) _button;

  @override
  Duration get animationDuration => const Duration(milliseconds: 1400);

  @override
  void initState() {
    super.initState();

    _header = createStaggerAnimation(start: 0.0, end: 0.5);
    _items = List.generate(DailyGoal.values.length, (i) {
      final start = 0.3 + i * 0.10;
      return createStaggerAnimation(
        start: start,
        end: start + 0.35,
        beginOffset: const Offset(0, 0.3),
      );
    });
    _button = createStaggerAnimation(
      start: 0.7,
      end: 1.0,
      beginOffset: const Offset(0, 0.4),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    final goal = ref.watch(onboardingProvider).dailyGoal;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            top: AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StaggerRevealAnimation(
                fade: _header.fade,
                slide: _header.slide,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Set a daily goal', style: tt.headlineLarge),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Small and steady. Change it anytime.',
                      style: tt.labelMedium?.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              RadioGroup<int>(
                groupValue: goal.index,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(onboardingProvider.notifier).setDailyGoal(DailyGoal.values[value]);
                  }
                },
                child: Column(
                  spacing: AppSpacing.md,
                  children: List.generate(DailyGoal.values.length, (i) {
                    final item = DailyGoal.values[i];
                    return StaggerRevealAnimation(
                      fade: _items[i].fade,
                      slide: _items[i].slide,
                      child: _GoalItem(
                        item: item,
                        value: i,
                        isSelected: item == goal,
                        onTap: () => ref.read(onboardingProvider.notifier).setDailyGoal(item),
                      ),
                    );
                  }),
                ),
              ),
              const Spacer(),
              StaggerRevealAnimation(
                fade: _button.fade,
                slide: _button.slide,
                child: AppButton(
                  onTap: (){},
                  text: 'Get Started',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalItem extends StatelessWidget {
  final DailyGoal item;
  final int value;
  final bool isSelected;
  final VoidCallback onTap;

  const _GoalItem({
    required this.item,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? colors.primary : colors.outline,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppSpacing.lg,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.minutes.toString(),
                  style: tt.headlineMedium?.copyWith(color: colors.primary),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text('min', style: tt.labelSmall?.copyWith(fontSize: 14)),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: tt.titleLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(item.description, style: tt.labelMedium?.copyWith(fontSize: 14)),
                ],
              ),
            ),
            Transform.scale(
              scale: 1.25,
              child: Radio<int>(
                value: value,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) return colors.primary;
                  return colors.outline;
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

