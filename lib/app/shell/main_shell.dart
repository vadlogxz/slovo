import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/app/shell/widgets/bottom_nav.dart';
import 'package:slovo/core/logging/app_logger.dart';
import 'package:slovo/core/theme/app_spacing.dart';

const _navbarHeight = 60.0;

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final currentTab = AppTabs.indexFromLocation(location);

    return Scaffold(
      body: Stack(
        children: [
          MediaQuery(
            data: MediaQuery.of(context).copyWith(
              padding: MediaQuery.of(context).padding.copyWith(
                bottom:
                    _navbarHeight +
                    MediaQuery.of(context).padding.bottom +
                    AppSpacing.lg,
              ),
            ),
            child: child,
          ),
          Positioned(
            right: AppSpacing.md,
            left: AppSpacing.md,
            bottom: MediaQuery.of(context).padding.bottom + AppSpacing.lg,
            child: BottomNav(
              height: _navbarHeight,
              currentIndex: currentTab,
              onTap: (value) {
                if (value < 0 || value >= AppTabs.items.length) {
                  AppLogger.warning('Invalid tab index: $value');
                  return;
                }
                final routePath = AppTabs.items[value].routePath;
                if (routePath != location) {
                  context.go(routePath);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
