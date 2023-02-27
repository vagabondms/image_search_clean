import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_search/presentation/photo/view/bottom_loader.dart';
import 'package:visibility_detector/visibility_detector.dart';

@immutable
class LoadMore extends StatelessWidget {
  final Function() onLoadMore;

  const LoadMore({super.key, required this.onLoadMore});

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: UniqueKey(),
        child: const SizedBox(
          height: 30,
          child: Center(
            child: BottomLoader(),
          ),
        ),
        onVisibilityChanged: (visibilityInfo) {
          print(visibilityInfo.visibleFraction);
          if (visibilityInfo.visibleFraction > 0.5) {
            onLoadMore();
          }
        });
  }
}
