import 'package:flutter/material.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/app/shell/models/tab_item.dart';
import 'package:slovo/app/shell/widgets/bottom_nav_icon.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/theme/_.dart';

abstract final class AppTabs {
  static const List<TabItem> items = [
    TabItem(
      icon: AppAssets.homeIcon,
      label: 'Home',
      routePath: AppRoutes.homePath,
    ),
    TabItem(
      icon: AppAssets.bookOutlineIcon,
      label: 'Vocabulary',
      routePath: AppRoutes.vocabularyPath,
    ),
    TabItem(
      icon: AppAssets.userOutlineIcon,
      label: 'Profile',
      routePath: AppRoutes.profilePath,
    ),
  ];

  static int indexFromLocation(String location) {
    if (location.startsWith(AppRoutes.homePath)) return 0;
    if (location.startsWith(AppRoutes.vocabularyPath)) return 1;
    if (location.startsWith(AppRoutes.profilePath)) return 2;
    return 0;
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, required this.currentIndex, required this.onTap, required this.height});

  final double height;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _widthAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 24.0, end: 48.0), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 48.0, end: 24.0), weight: 60),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: widget.height,
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colors.outline, width: 2),
        ),

      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / AppTabs.items.length;
          final indicatorX = widget.currentIndex * tabWidth;

          return Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: SizedBox(
              height: 40,
              child: Stack(
                children: [
                  Row(
                    children: List.generate(AppTabs.items.length, (i) {
                      final item = AppTabs.items[i];
                      final selected = i == widget.currentIndex;
                      return Expanded(
                        child: Semantics(
                          button: true,
                          label: item.label,
                          child: GestureDetector(
                            onTap: () => widget.onTap(i),
                            behavior: HitTestBehavior.opaque,
                            child: Align(
                              alignment: AlignmentGeometry.topCenter,
                              child: NavIcon(
                                path: item.icon,
                                selected: selected,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  AnimatedBuilder(
                    animation: _widthAnimation,
                    builder: (context, _) => AnimatedPositioned(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      left:
                      indicatorX +
                          (tabWidth / 2) -
                          (_widthAnimation.value / 2),
                      bottom: 0,
                      child: Container(
                        width: _widthAnimation.value,
                        height: 5,
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: context.colors.primary.withValues(alpha: 0.35),
                              blurRadius: 8,
                              spreadRadius: 2,
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
        },
      ),
    );
  }
}
