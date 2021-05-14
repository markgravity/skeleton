import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import 'bone.dart';

class Skeleton extends InheritedWidget {
  const Skeleton({
    Key? key,
    required this.isShown,
    required Widget child,
    this.height,
    this.spacing,
    this.transition,
    this.period,
    this.direction,
    this.baseColor,
    this.highlightColor,
    this.borderRadius,
  }) : super(key: key, child: child);

  /// It's controls whether skeleton animation is ran or not
  final bool isShown;

  /// The default background color of child bones
  final Color? baseColor;

  /// The default shimmer color of child bones
  final Color? highlightColor;

  /// The default border radius of child bones
  final BorderRadiusGeometry? borderRadius;

  /// The default height of child bones
  /// Only effect to [Bone.multiple]
  final double? height;

  /// The default spacing between bones
  final double? spacing;

  /// The default showing transition of child bones
  final BoneTransition? transition;

  /// The default speed of shimmer effect in child bones
  final Duration? period;

  /// The default  direction of shimmer effect in child bones
  final ShimmerDirection? direction;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static Skeleton? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Skeleton>();
  }
}
