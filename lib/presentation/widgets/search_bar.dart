import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide()),
        ),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              border: InputBorder.none,
              icon: Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: Icon(Icons.search))),
        ),
      ),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / (maxExtent - searchBarHeight);
    final double currentExtent = math.max(
      minBackgroundHeight,
      backgroundHeight - shrinkOffset,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 400,
        maxHeight: 800,
      ),
      child: Column(
        children: [
          Flexible(
            child: FlexibleSpaceBar.createSettings(
              minExtent: 0,
              maxExtent: 300,
              currentExtent: currentExtent,
              child: const FlexibleSpaceBar(
                background: Image(
                  image: AssetImage('assets/images/feature.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration.zero,
            height: searchBarHeight,
            color: Color.lerp(Colors.red, Colors.blue, progress),
            alignment: Alignment.center,
            child: const SearchBar(),
          ),
        ],
      ),
    );
  }

  final double searchBarHeight = 100;
  final double backgroundHeight = 300;
  final double minBackgroundHeight = 50;

  @override
  double get maxExtent => 400;

  @override
  double get minExtent => 150;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
