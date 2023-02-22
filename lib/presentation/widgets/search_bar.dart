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

// class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
//   MyHeaderDelegate();
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     final appBarSize = maxExtent - shrinkOffset;
//     final proportion = 2 - (maxExtent / appBarSize);
//     final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
//     return Theme(
//       data: ThemeData.dark(),
//       child: ConstrainedBox(
//         constraints: BoxConstraints(minHeight: maxExtent),
//         child: Stack(
//           children: [
//             Positioned(
//               bottom: 0.0,
//               left: 0.0,
//               right: 0.0,
//               top: 0,
//               child: Image(
//                 image: AssetImage('assets/images/feature.png'),
//                 fit: BoxFit.none,
//               ),
//             ),
//             Positioned(
//               bottom: 0.0,
//               left: 0.0,
//               right: 0.0,
//               child: Opacity(opacity: percent, child: Text('hi')),
//             ),
//             Positioned(
//               top: 0.0,
//               left: 0.0,
//               right: 0.0,
//               child: AppBar(
//                 title: Opacity(opacity: 1 - percent, child: Text('hi')),
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   double get maxExtent => 300;
//
//   @override
//   OverScrollHeaderStretchConfiguration get stretchConfiguration =>
//       OverScrollHeaderStretchConfiguration();
//
//   @override
//   double get minExtent => kToolbarHeight + 0;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }
