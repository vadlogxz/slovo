import 'package:flutter/material.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/shared/widgets/app_icon.dart';

/// The app's gradient logo mark, Hero-tagged so it animates between the
/// splash screen and the login screen.
class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Hero(
      tag: 'app-logo',
      child: Container(
        width: 76,
        height: 76,
        decoration: BoxDecoration(
          gradient: AppGradients.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withAlpha(80),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: AppIcon(
            path: AppAssets.appLogo,
            size: 36,
            color: colors.textOnBrand,
          ),
        ),
      ),
    );
  }
}

/// The "Slovo" wordmark, Hero-tagged to match [BrandLogo]'s transition.
class BrandTitle extends StatelessWidget {
  const BrandTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'app-title',
      child: Material(
        color: Colors.transparent,
        child: Text('Slovo', style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}
