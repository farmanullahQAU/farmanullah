import 'package:flutter/material.dart';

class StickyNavBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final double maxHeight;

  StickyNavBarDelegate({
    required this.child,
    this.height = 64,
    this.maxHeight = 400,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: shrinkOffset > 0
              ? [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        clipBehavior: Clip.none,
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(StickyNavBarDelegate oldDelegate) {
    return child != oldDelegate.child || height != oldDelegate.height;
  }
}
