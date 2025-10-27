import 'package:flutter/material.dart';

class StickyNavBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyNavBarDelegate({required this.child});

  @override
  double get minExtent => 70;

  @override
  double get maxExtent => 70;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(StickyNavBarDelegate oldDelegate) {
    // Force rebuild - the child widget handles state changes
    return child != oldDelegate.child;
  }
}
