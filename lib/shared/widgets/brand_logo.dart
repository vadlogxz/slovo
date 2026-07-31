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
        width: 112,
        height: 112,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colors.primary,
          border: Border.all(
            color: colors.primaryDark,
            width: 2,
          )
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
