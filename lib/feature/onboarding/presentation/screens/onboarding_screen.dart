import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/onboarding/di/onboarding_provider.dart';
import 'package:slovo/feature/onboarding/domain/models/daily_goal.dart';
import 'package:slovo/shared/mixins/_.dart';
import 'package:slovo/shared/widgets/_.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin, StaggerAnimationMixin {
  late final ({Animation<double> fade, Animation<Offset> slide}) _button;
  late final PageController _pageController;
  late final TextEditingController userNameController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController();
    userNameController = TextEditingController();
    super.initState();

    _button = createStaggerAnimation(start: 0.6, end: 1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    final pages = [
      _Welcome(),
      _Greetings(userNameController: userNameController),
      _DailyGoal(),
    ];

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
              child: ListenableBuilder(
                listenable: userNameController,
                builder: (context, child) => AppButton(
                  isDisabled: _currentPage == 1
                      ? userNameController.text.trim().isEmpty
                      : false,
                  onTap: () {
                    if (_currentPage < pages.length - 1) {
                      if (_currentPage == 1 &&
                          userNameController.text.trim().isEmpty) {
                        return;
                      }

                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      //TODO: Navigate to the next screen or perform any other action
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentPage == 0 ? 'Get Started' : 'Next',
                        style: tt.labelLarge?.copyWith(
                          color:
                              _currentPage == 1 &&
                                  userNameController.text.trim().isEmpty
                              ? context.colors.textSecondary
                              : context.colors.textOnBrand,
                        ),
                      ),
                      if (_currentPage != 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color:
                                _currentPage == 1 &&
                                    userNameController.text.trim().isEmpty
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
                    color: context.colors.rating.withValues(alpha: 0.2),
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
                      color: context.colors.error.withValues(alpha: 0.2),
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
                    color: context.colors.success.withValues(alpha: 0.2),
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
                style: tt.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Greetings extends StatefulWidget {
  const _Greetings({required this.userNameController});

  final TextEditingController userNameController;

  @override
  State<_Greetings> createState() => _GreetingsState();
}

class _GreetingsState extends State<_Greetings> {

  @override
  Widget build(BuildContext context) {
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
          controller: widget.userNameController,
          // onChanged: (value) => setState(() {
          //   _name = value;
          // }),
          decoration: InputDecoration(hintText: 'Enter your name'),
        ),
        SizedBox(height: AppSpacing.md),
        ListenableBuilder(
          listenable: widget.userNameController,
          builder: (context, child) => AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: widget.userNameController.text.isNotEmpty ? 1.0 : 0.0,
            child: AnimatedSlide(
              duration: Duration(milliseconds: 300),
              offset: widget.userNameController.text.isNotEmpty
                  ? Offset.zero
                  : Offset(0, 0.5),
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
                        // text: _name,
                        text: widget.userNameController.text,
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
        ),
      ],
    );
  }
}

class _DailyGoal extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingNotifier = ref.read(onboardingProvider.notifier);
    final goal = ref.watch(onboardingProvider.select((state) => state.dailyGoal));

    Color getGoalColor(DailyGoal goal) {
      switch (goal) {
        case DailyGoal.casual:
          return context.colors.warning;
        case DailyGoal.regular:
          return context.colors.primary;
        case DailyGoal.serious:
          return context.colors.success;
        case DailyGoal.intense:
          return context.colors.error;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Daily goal', style: Theme.of(context).textTheme.headlineMedium),
        Text(
          'Consistency beats intensity',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
        ),
        const SizedBox(height: AppSpacing.xl),
        RadioGroup<int>(
          groupValue: goal.index,
          onChanged: (value) {},
          child: Column(
            spacing: AppSpacing.md,
            children: List.generate(DailyGoal.values.length, (index) {
              final localGoal = DailyGoal.values[index];
              final color = getGoalColor(localGoal);
              return GestureDetector(
                onTap: () {
                  onboardingNotifier.setDailyGoal(localGoal);
                },
                child: Container(
                  padding: EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: localGoal == goal
                        ? color
                        : null,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppRadius.lg),
                    ),
                    border: Border.all(color: context.colors.outline, width: 2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: localGoal == goal
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
                            path: DailyGoal.values[index].iconPath,
                            size: 24,
                            color: localGoal == goal
                                ? Colors.white
                                : color,
                          ),
                        ),
                      ),
                      SizedBox(width: AppSpacing.md),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DailyGoal.values[index].title,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: localGoal == goal
                                  ? context.colors.textOnBrand
                                  : context.colors.textPrimary,
                            ),
                          ),
                          Text(
                            DailyGoal.values[index].description,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: localGoal == goal
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
                            innerRadius: WidgetStatePropertyAll(
                              3,
                            ),
                            value: DailyGoal.values[index].index,
                            side: WidgetStateBorderSide.resolveWith((states) =>
                                BorderSide(width: localGoal == goal ? 3 : 2, color: context.colors.outline)),
                            fillColor: WidgetStateProperty.resolveWith((states) =>
                            states.contains(WidgetState.selected) ? color : context.colors.outline),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
