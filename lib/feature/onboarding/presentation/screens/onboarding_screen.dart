import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/onboarding/di/onboarding_provider.dart';
import 'package:slovo/feature/onboarding/domain/models/daily_goal.dart';
import 'package:slovo/feature/onboarding/domain/models/reminder_time.dart';
import 'package:slovo/shared/mixins/_.dart';
import 'package:slovo/shared/widgets/_.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with SingleTickerProviderStateMixin, StaggerAnimationMixin {
  late final ({Animation<double> fade, Animation<Offset> slide}) _button;
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();

    _button = createStaggerAnimation(start: 0.6, end: 1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final pages = [_Welcome(), _Greetings(), _DailyGoal(), _ReminderTime()];

    final userName = ref.watch(
      onboardingProvider.select((value) => value.userName),
    );

    String getButtonText() {
      if (_currentPage == 0) {
        return 'Get Started';
      } else if (_currentPage == pages.length - 1) {
        return 'Start Learning';
      } else {
        return 'Next';
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppSpacing.xl,
          right: AppSpacing.xl,
          bottom: AppSpacing.xl,
          top: AppSpacing.xxl,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 40,
                  child: _currentPage == 0
                      ? null
                      : GestureDetector(
                          onTap: () => _pageController.previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: context.colors.primaryDark.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(AppRadius.md),
                              ),
                            ),
                            child: Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                ),
                SegmentedPageIndicator(
                  currentPage: _currentPage,
                  totalPages: pages.length,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Skip', style: tt.labelLarge),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  if (index >= pages.length || index < 0) return null;
                  return pages[index];
                },
              ),
            ),
            StaggerRevealAnimation(
              fade: _button.fade,
              slide: _button.slide,
              child: AppButton(
                isDisabled: _currentPage == 1 ? userName.trim().isEmpty : false,
                onTap: () {
                  if (_currentPage < pages.length - 1) {
                    if (_currentPage == 1 && userName.trim().isEmpty) {
                      return;
                    }

                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    ref.read(onboardingProvider.notifier).completeOnboarding();
                    context.goNamed('home');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getButtonText(),
                      style: tt.labelLarge?.copyWith(
                        color: _currentPage == 1 && userName.trim().isEmpty
                            ? context.colors.textSecondary
                            : context.colors.textOnBrand,
                      ),
                    ),
                    if (_currentPage != 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: _currentPage == 1 && userName.trim().isEmpty
                              ? context.colors.textSecondary
                              : context.colors.textOnBrand,
                          size: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Welcome extends StatefulWidget {
  const _Welcome();

  @override
  State<_Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<_Welcome>
    with SingleTickerProviderStateMixin, StaggerAnimationMixin {
  late final ({Animation<double> fade, Animation<Offset> slide}) _title;
  late final ({Animation<double> fade, Animation<Offset> slide}) _subtitle;

  @override
  void initState() {
    super.initState();
    _title = createStaggerAnimation(start: 0.2, end: 0.65);
    _subtitle = createStaggerAnimation(start: 0.4, end: 0.85);
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Stack(
      children: [
        Positioned.fill(
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 40,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppAccents.yellow.withValues(alpha: 0.2),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                right: 12,
                child: Transform.rotate(
                  angle: 180,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppAccents.coral.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 190,
                left: 0,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppAccents.mint.withValues(alpha: 0.2),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BrandLogo(),
            const SizedBox(height: AppSpacing.xl),
            StaggerRevealAnimation(
              fade: _title.fade,
              slide: _title.slide,
              child: Text.rich(
                style: tt.headlineLarge,
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(text: 'Learn words '),
                    TextSpan(
                      text: 'every day',
                      style: tt.headlineLarge?.copyWith(
                        color: AppColors.light.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            StaggerRevealAnimation(
              fade: _subtitle.fade,
              slide: _subtitle.slide,
              child: Text(
                'Flashcards, exercises, articles, cases — all in one place.',
                style: tt.bodyLarge?.copyWith(
                  color: context.colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Greetings extends ConsumerWidget {
  const _Greetings();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingNotifier = ref.read(onboardingProvider.notifier);
    final userName = ref.watch(
      onboardingProvider.select((state) => state.userName),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          AppAssets.hiHandAnimation,
          width: 64,
          height: 64,
          repeat: true,
          fit: BoxFit.contain,
        ),
        Text(
          'What\'s your name?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          onChanged: (value) => onboardingNotifier.setUserName(value),
          decoration: InputDecoration(hintText: 'Enter your name'),
        ),
        SizedBox(height: AppSpacing.md),
        AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: userName.isNotEmpty ? 1.0 : 0.0,
          child: AnimatedSlide(
            duration: Duration(milliseconds: 300),
            offset: userName.isNotEmpty ? Offset.zero : Offset(0, 0.5),
            child: Container(
              key: ValueKey('greeting_container'),
              width: double.infinity,
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: context.colors.surfaceAccentTint,
                border: Border.all(
                  color: context.colors.surfaceAccent,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.lg)),
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hallo, ',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(fontSize: 20),
                    ),
                    TextSpan(
                      text: userName,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: context.colors.primary,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextSpan(
                      text: '!',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DailyGoal extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goal = ref.watch(
      onboardingProvider.select((state) => state.dailyGoal),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.md),
        Lottie.asset(
          AppAssets.targetAnimation,
          repeat: false,
          width: 150,
          fit: BoxFit.contain,
        ),
        Text('Daily goal', style: Theme.of(context).textTheme.headlineMedium),
        Text(
          'Consistency beats intensity',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
        ),
        const SizedBox(height: AppSpacing.xl),
        RadioGroup<int>(
          groupValue: goal.index,
          onChanged: (_) => {},
          child: Column(
            spacing: AppSpacing.md,
            // Daily goal options
            children: List.generate(DailyGoal.values.length, (index) {
              final localGoal = DailyGoal.values[index];

              return _DailyGoalItem(
                goal: localGoal,
                isSelected: goal == localGoal,
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _DailyGoalItem extends ConsumerStatefulWidget {
  final bool isSelected;
  final DailyGoal goal;

  const _DailyGoalItem({required this.isSelected, required this.goal});

  @override
  ConsumerState<_DailyGoalItem> createState() => _DailyGoalItemState();
}

class _DailyGoalItemState extends ConsumerState<_DailyGoalItem> {
  bool _isPressed = false;

  Color _getGoalColor(DailyGoal goal) {
    switch (goal) {
      case DailyGoal.casual:
        return AppAccents.orange;
      case DailyGoal.regular:
        return context.colors.primary;
      case DailyGoal.serious:
        return AppAccents.mint;
      case DailyGoal.intense:
        return AppAccents.coral;
    }
  }

  @override
  Widget build(BuildContext context) {
    final onboardingNotifier = ref.read(onboardingProvider.notifier);
    final Color color = _getGoalColor(widget.goal);
    return Listener(
      onPointerDown: (e) {
        setState(() {
          _isPressed = true;
        });
      },
      onPointerUp: (e) {
        setState(() {
          _isPressed = false;
        });
      },
      onPointerCancel: (e) {
        setState(() {
          _isPressed = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          onboardingNotifier.setDailyGoal(widget.goal);
        },
        child: AnimatedScale(
          duration: Duration(milliseconds: 80),
          curve: Curves.easeOut,
          scale: _isPressed ? 0.98 : 1.0,
          child: Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: widget.isSelected ? color : null,
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.lg)),
              border: Border.all(color: context.colors.outline, width: 2),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: widget.isSelected
                        ? Colors.white.withValues(alpha: 0.2)
                        : color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppRadius.lg),
                    ),
                  ),
                  width: 48,
                  height: 48,
                  child: Center(
                    child: AppIcon(
                      path: widget.goal.iconPath,
                      size: 24,
                      color: widget.isSelected ? Colors.white : color,
                    ),
                  ),
                ),
                SizedBox(width: AppSpacing.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.goal.title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: widget.isSelected
                                ? context.colors.textOnBrand
                                : context.colors.textPrimary,
                          ),
                    ),
                    Text(
                      widget.goal.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: widget.isSelected
                            ? context.colors.textOnBrand
                            : context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Transform.scale(
                  scale: 2,
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Radio<int>(
                      innerRadius: WidgetStatePropertyAll(3),
                      value: widget.goal.index,
                      side: WidgetStateBorderSide.resolveWith(
                        (states) => BorderSide(
                          width: widget.isSelected ? 3 : 2,
                          color: context.colors.outline,
                        ),
                      ),
                      fillColor: WidgetStateProperty.resolveWith(
                        (states) => states.contains(WidgetState.selected)
                            ? color
                            : context.colors.outline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReminderTime extends StatelessWidget {
  const _ReminderTime();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.md),
        Lottie.asset(
          AppAssets.bellAnimation,
          repeat: false,
          width: 64,
          fit: BoxFit.contain,
        ),
        Text(
          'When\'s best to study?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          'We\'ll remind you at the right time',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
        ),
        const SizedBox(height: AppSpacing.xl),
        Column(
          spacing: AppSpacing.md,
          children: List.generate(
            ReminderTime.values.length,
            (index) =>
                _ReminderTimeItem(reminderTime: ReminderTime.values[index]),
          ),
        ),
        Spacer(),
        _UserPlan(),
        SizedBox(
          height: AppSpacing.md,
        )
      ],
    );
  }
}

class _UserPlan extends ConsumerWidget {
  const _UserPlan();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingData = ref.watch(onboardingProvider);

    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.lg)),
        border: Border.all(color: context.colors.outline, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'YOUR PLAN',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: context.colors.textSecondary,
              fontSize: 13,
            ),
          ),
          Row(
            spacing: AppSpacing.md,
            children: [
              Text(
                'DE',
                style: TextStyle(
                  fontSize: 22,
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('German ${onboardingData.dailyGoal.description}', style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: context.colors.textPrimary,
                    fontSize: 14,
                  ),),
                  Text('Reminder at ${onboardingData.reminderTime.timeLabel}', style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 11
                  ),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReminderTimeItem extends ConsumerStatefulWidget {
  const _ReminderTimeItem({required this.reminderTime});

  final ReminderTime reminderTime;

  @override
  ConsumerState<_ReminderTimeItem> createState() => _ReminderTimeItemState();
}

class _ReminderTimeItemState extends ConsumerState<_ReminderTimeItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final onboardingNotifier = ref.read(onboardingProvider.notifier);
    final currentReminderTime = ref.watch(
      onboardingProvider.select((state) => state.reminderTime),
    );
    final bool isSelected = currentReminderTime == widget.reminderTime;

    return Listener(
      onPointerDown: (e) {
        setState(() {
          _isPressed = true;
        });
      },
      onPointerUp: (e) {
        setState(() {
          _isPressed = false;
        });
      },
      onPointerCancel: (e) {
        setState(() {
          _isPressed = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          onboardingNotifier.setReminderTime(widget.reminderTime);
        },
        child: AnimatedScale(
          duration: Duration(milliseconds: 80),
          curve: Curves.easeOut,
          scale: _isPressed ? 0.98 : 1.0,
          child: Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isSelected ? context.colors.primaryDark : null,
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.lg)),
              border: Border.all(color: context.colors.outline, width: 2),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.1)
                        : context.colors.surfaceIconBadge,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppRadius.lg),
                    ),
                  ),
                  child: Center(
                    child: AppIcon(
                      path: widget.reminderTime.icon,
                      size: 36,
                      color: isSelected
                          ? AppAccents.yellow
                          : context.colors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(width: AppSpacing.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.reminderTime.label,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontSize: 18,
                            color: isSelected
                                ? context.colors.textOnBrand
                                : context.colors.textPrimary,
                          ),
                    ),
                    Text(
                      widget.reminderTime.timeLabel,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                isSelected
                    ? Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: AppAccents.yellow,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: context.colors.primaryDark,
                            fontWeight: FontWeight.w600,
                            size: 16,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
