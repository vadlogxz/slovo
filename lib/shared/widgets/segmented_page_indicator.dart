import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';

// A segmented page indicator that shows the current page and total pages in a
// horizontal row of segments. The current page is highlighted with a larger
// segment, while the other segments are smaller and less prominent. The
// indicator is animated when the current page changes.

class SegmentedPageIndicator extends StatefulWidget {
  const SegmentedPageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  final int currentPage;
  final int totalPages;

  @override
  State<SegmentedPageIndicator> createState() => _SegmentedPageIndicatorState();
}

class _SegmentedPageIndicatorState extends State<SegmentedPageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < widget.totalPages; i++)
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: widget.currentPage >= i
                ? _Segment(isActive: true, isCurrent: widget.currentPage == i)
                : const _Segment(isActive: false),
          ),
      ],
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({required this.isActive, this.isCurrent = false});

  final bool isActive;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCurrent ? 30 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive
            ? context.colors.primary
            : context.colors.primaryDark.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
