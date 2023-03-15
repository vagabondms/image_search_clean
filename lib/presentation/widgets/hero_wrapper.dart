import 'package:flutter/material.dart';
import 'package:image_search/presentation/photo/photo.dart';

class HeroWrapper extends StatelessWidget {
  final Widget child;

  const HeroWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Rect start = box.localToGlobal(Offset.zero) & box.size;
        final RelativeRect startRect =
            RelativeRect.fromSize(start, MediaQuery.of(context).size);

        Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) =>
                  const PhotoScreen(),
              transitionDuration: Duration(milliseconds: 200),
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                child,
              ) {
                final RelativeRectTween rectTween =
                    RelativeRectTween(begin: startRect, end: RelativeRect.fill);
                final Tween<double> tween = Tween<double>(
                    begin: box.size.width / MediaQuery.of(context).size.width,
                    end: 1);

                // .chain(CurveTween(curve: curve));

                return Stack(
                  children: [
                    HeroTransition(
                        relativeRectTween: rectTween,
                        scaleTween: tween,
                        // rect: animation.drive(rectTween),
                        animation: animation,
                        child: ScaleTransition(
                            scale: animation.drive(tween), child: child)),
                  ],
                );
              }),
        );
      },
      child: child,
    );
  }
}

class HeroTransition extends AnimatedWidget {
  final Widget child;
  final Tween<double> scaleTween;
  final RelativeRectTween relativeRectTween;

  late final Animation scaleAnimation;
  late final Animation relativeRectAnimation;

  HeroTransition({
    super.key,
    required this.scaleTween,
    required this.relativeRectTween,
    required this.child,
    required Animation animation,
  })  : relativeRectAnimation = animation.drive(relativeRectTween),
        scaleAnimation = animation.drive(scaleTween),
        super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRelativeRect(
      rect: relativeRectAnimation.value,
      child: Transform.scale(
        scale: scaleAnimation.value,
        filterQuality: null,
        child: child,
      ),
    );
  }
}
