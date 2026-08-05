import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/app/shell/widgets/bottom_nav.dart';
import 'package:slovo/core/logging/app_logger.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final currentTab = AppTabs.items[navigationShell.currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: navigationShell),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNav(
              height: 80,
              currentIndex: navigationShell.currentIndex,
              onTap: (value) {
                if (value < 0 || value >= AppTabs.items.length) {
                  AppLogger.warning('Invalid tab index: $value');
                  return;
                }
                final selectedTab = AppTabs.items[value];
                if (selectedTab.routePath != currentTab.routePath) {
                  navigationShell.goBranch(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class B extends StatefulWidget {
  const B({super.key});

  @override
  State<B> createState() => _BState();
}

class _BState extends State<B> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

