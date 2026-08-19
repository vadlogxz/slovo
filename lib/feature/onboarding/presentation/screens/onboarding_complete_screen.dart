import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/onboarding/di/onboarding_provider.dart';
import 'package:slovo/shared/mixins/_.dart';
import 'package:slovo/shared/widgets/_.dart';

class OnboardingCompleteScreen extends ConsumerStatefulWidget {
  const OnboardingCompleteScreen({super.key});

  static const _summaryItems = [
    _SettingsItemModel(
      title: 'Starter collection',
      description: 'Im Café · 24 words',
      iconPath: AppAssets.appLogo,
    ),
    _SettingsItemModel(
      title: 'Daily goal',
      description: '',
      iconPath: AppAssets.lightingIcon,
    ),
  ];

  @override
  ConsumerState<OnboardingCompleteScreen> createState() =>
      _OnboardingCompleteScreenState();
}

class _OnboardingCompleteScreenState
    extends ConsumerState<OnboardingCompleteScreen>
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
    _items = List.generate(OnboardingCompleteScreen._summaryItems.length, (i) {
      final start = 0.3 + i * 0.15;
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
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    final dailyGoal = ref.watch(onboardingProvider).dailyGoal;
    final goalDescription = '${dailyGoal.minutes} min · ${dailyGoal.title}';
    final userName = ref.watch(currentUserProvider)?.name ?? 'there';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            top: AppSpacing.xxl,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StaggerRevealAnimation(
                    fade: _header.fade,
                    slide: _header.slide,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconAvatar(
                          size: 64,
                          backgroundColor: colors.primary12,
                          icon: Icon(Icons.check, size: 36, color: colors.primary),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          'You\'re all set, $userName.',
                          style: tt.headlineLarge,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'We\'ve added a starter collection so you can begin right away.',
                          style: tt.bodySmall?.copyWith(
                            fontSize: 16,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  ...List.generate(OnboardingCompleteScreen._summaryItems.length, (i) {
                    final item = OnboardingCompleteScreen._summaryItems[i];
                    final isFirst = i == 0;
                    final isLast = i == OnboardingCompleteScreen._summaryItems.length - 1;
                    return StaggerRevealAnimation(
                      fade: _items[i].fade,
                      slide: _items[i].slide,
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          border: Border.all(color: colors.outline, width: 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(isFirst ? AppRadius.md : 0),
                            topRight: Radius.circular(isFirst ? AppRadius.md : 0),
                            bottomLeft: Radius.circular(isLast ? AppRadius.md : 0),
                            bottomRight: Radius.circular(isLast ? AppRadius.md : 0),
                          ),
                        ),
                        child: _SettingsItem(
                          title: item.title,
                          description: item.description.isEmpty ? goalDescription : item.description,
                          iconPath: item.iconPath,
                        ),
                      ),
                    );
                  }),
                ],
              ),
              StaggerRevealAnimation(
                fade: _button.fade,
                slide: _button.slide,
                child: AppButton(
                  onTap: () async {
                    await ref.read(onboardingProvider.notifier).completeOnboarding();
                    if (context.mounted) context.go(AppRoutes.homePath);
                  },
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

class _SettingsItem extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;

  const _SettingsItem({
    required this.title,
    required this.description,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    return Row(
      children: [
        AppIcon(path: iconPath, color: colors.primary, size: 24),
        const SizedBox(width: AppSpacing.md),
        Text(title, style: tt.labelMedium?.copyWith(fontSize: 16)),
        const Spacer(),
        Text(description, style: tt.titleMedium),
      ],
    );
  }
}

class _SettingsItemModel {
  final String title;
  final String description;
  final String iconPath;

  const _SettingsItemModel({
    required this.title,
    required this.description,
    required this.iconPath,
  });
}