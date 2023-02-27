import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BackgroundHeaderDelegate extends SliverPersistentHeaderDelegate {
  const BackgroundHeaderDelegate({
    required this.searchBarHeight,
    required this.backgroundHeight,
    required this.minBackgroundHeight,
    required this.background,
    required this.child,
  });

  final double searchBarHeight;
  final double backgroundHeight;
  final double minBackgroundHeight;
  final Widget child;
  final Widget background;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / (maxExtent - searchBarHeight);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: searchBarHeight + backgroundHeight,
      ),
      child: Column(
        children: [
          Expanded(
            child: FlexibleSpaceBar.createSettings(
              minExtent: 50,
              maxExtent: backgroundHeight,
              currentExtent: math.max(
                minBackgroundHeight,
                backgroundHeight - shrinkOffset,
              ),
              child: AnimatedContainer(
                duration: Duration.zero,
                color: Color.lerp(Colors.red, Colors.blue, progress),
                child: FlexibleSpaceBar(
                  background: background,
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration.zero,
            height: searchBarHeight,
            color: Color.lerp(Colors.red, Colors.blue, progress),
            alignment: Alignment.center,
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => searchBarHeight + backgroundHeight;

  @override
  double get minExtent => searchBarHeight + minBackgroundHeight;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
