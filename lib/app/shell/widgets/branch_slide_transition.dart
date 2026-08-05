import 'package:flutter/material.dart';

class BranchSlideTransition extends StatefulWidget {
  final List<Widget> children;
  final int currentIndex;

  const BranchSlideTransition({
    super.key,
    required this.children,
    required this.currentIndex,
  });

  @override
  State<BranchSlideTransition> createState() => _BranchSlideTransitionState();
}

class _BranchSlideTransitionState extends State<BranchSlideTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _curve;
  int _previousIndex = 0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BranchSlideTransition oldWidget) {
    if (oldWidget.currentIndex != widget.currentIndex) {
      _previousIndex = oldWidget.currentIndex;
      _controller.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(widget.children.length, (index) {
        return Positioned.fill(
          child: AnimatedBuilder(
            animation: _curve,
            builder: (context, child) {
              final offsetX =
                  (index -
                      (_previousIndex +
                          (widget.currentIndex - _previousIndex) *
                              _curve.value)) *
                  MediaQuery.of(context).size.width;
              return Transform.translate(
                offset: Offset(offsetX, 0),
                child: child,
              );
            },
            child: widget.children[index],
          ),
        );
      }),
    );
  }
}
