import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    this.controller,
    required this.onSubmitted,
  }) : super(key: key);

  final TextEditingController? controller;
  final void Function(String value) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border.fromBorderSide(BorderSide()),
        ),
        child: TextField(
          onSubmitted: onSubmitted,
          keyboardType: TextInputType.text,
          controller: controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Padding(
              padding: EdgeInsets.only(left: 13),
              child: Icon(Icons.search),
            ),
          ),
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }
}

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
          Flexible(
            child: FlexibleSpaceBar.createSettings(
              minExtent: 0,
              maxExtent: backgroundHeight,
              currentExtent: math.max(
                minBackgroundHeight,
                backgroundHeight - shrinkOffset,
              ),
              child: FlexibleSpaceBar(
                background: background,
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
