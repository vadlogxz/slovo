import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/shared/mixins/_.dart';
import 'package:slovo/shared/widgets/_.dart';

class FeaturesScreen extends StatefulWidget {
  const FeaturesScreen({super.key});

  static const List<_FeatureItemModel> _items = [
    _FeatureItemModel(
      title: 'Collect words',
      description: 'Make collections like "Im Café" and add words as you go.',
      iconPath: AppAssets.appLogo,
    ),
    _FeatureItemModel(
      title: 'Learn by review',
      description:
      'Smart spaced repetition surfaces words right before you forget.',
      iconPath: AppAssets.lightingIcon,
    ),
    _FeatureItemModel(
      title: 'Share & discover',
      description: 'Publish a collection or add ones the community has built.',
      iconPath: AppAssets.shareIcon,
    ),
  ];

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen>
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
    _items = List.generate(FeaturesScreen._items.length, (i) {
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
    final tt = Theme.of(context).textTheme;

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
                    Text('How Slovo works', style: tt.headlineLarge),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Three simple habits.',
                      style: tt.labelMedium?.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Column(
                spacing: AppSpacing.md,
                children: List.generate(FeaturesScreen._items.length, (i) {
                  return StaggerRevealAnimation(
                    fade: _items[i].fade,
                    slide: _items[i].slide,
                    child: _FeatureItem(item: FeaturesScreen._items[i]),
                  );
                }),
              ),
              const Spacer(),
              StaggerRevealAnimation(
                fade: _button.fade,
                slide: _button.slide,
                child: AppButton(
                  onTap: () => context.go(AppRoutes.dailyGoalPath),
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

class _FeatureItem extends StatelessWidget {
  final _FeatureItemModel item;

  const _FeatureItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        IconAvatar(
          size: 48,
          backgroundColor: colors.primary12,
          icon: AppIcon(path: item.iconPath, color: colors.primary, size: 24),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: tt.titleLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(
                item.description,
                style: tt.labelMedium?.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureItemModel {
  final String title;
  final String description;
  final String iconPath;

  const _FeatureItemModel({
    required this.title,
    required this.description,
    required this.iconPath,
  });
}