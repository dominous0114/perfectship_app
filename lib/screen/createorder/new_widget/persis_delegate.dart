import 'package:flutter/material.dart';

class FloatingHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget minChild;
  final Widget maxChild;

  FloatingHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.minChild,
    required this.maxChild,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final reachedMinSize = shrinkOffset >= maxExtent - minExtent;
    return SizedBox.expand(child: reachedMinSize ? minChild : maxChild);
  }

  @override
  bool shouldRebuild(FloatingHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        minChild != oldDelegate.minChild ||
        maxChild != oldDelegate.maxChild;
  }
}
