import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/shared/mixins/_.dart';
import 'package:slovo/shared/widgets/_.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin, StaggerAnimationMixin {
  late final ({Animation<double> fade, Animation<Offset> slide}) _chip;
  late final ({Animation<double> fade, Animation<Offset> slide}) _title;
  late final ({Animation<double> fade, Animation<Offset> slide}) _subtitle;
  late final ({Animation<double> fade, Animation<Offset> slide}) _button;

  @override
  void initState() {
    super.initState();

    // Animations
    _chip = createStaggerAnimation(start: 0.0, end: 0.4);
    _title = createStaggerAnimation(start: 0.2, end: 0.65);
    _subtitle = createStaggerAnimation(start: 0.4, end: 0.85);
    _button = createStaggerAnimation(start: 0.6, end: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          // Background main fade
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppGradients.primary.colors,
                  stops: const [0.0, 0.6],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Background secondary fade
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black],
                  stops: [0.3, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Main content
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StaggerRevealAnimation(
                    fade: _chip.fade,
                    slide: _chip.slide,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm,
                        horizontal: AppSpacing.lg,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.textOnBrand.withAlpha(60),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          AppIcon(path: AppAssets.germanyFlag, size: 18),
                          Text(
                            'Learning German',
                            style: tt.labelMedium?.copyWith(
                              color: context.colors.textOnBrand,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  StaggerRevealAnimation(
                    fade: _title.fade,
                    slide: _title.slide,
                    child: Text(
                      'Build collections of\nthe words you meet.',
                      style: tt.headlineLarge?.copyWith(color: context.colors.textInverse),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  StaggerRevealAnimation(
                    fade: _subtitle.fade,
                    slide: _subtitle.slide,
                    child: Text(
                      'Articles, plurals and examples handled for you — just learn.',
                      style: tt.headlineSmall?.copyWith(
                        color: context.colors.textInverse.withAlpha(160),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  StaggerRevealAnimation(
                    fade: _button.fade,
                    slide: _button.slide,
                    child: AppButton(
                      onTap: () => context.go(AppRoutes.featuresPath),
                      text: 'Get Started',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
