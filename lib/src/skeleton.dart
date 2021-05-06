import 'package:flutter/widgets.dart';

class Skeleton extends InheritedWidget {
  const Skeleton({
    Key? key,
    required this.isShown,
    required Widget child,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
  }) : super(key: key, child: child);

  final bool isShown;
  final Color baseColor;
  final Color highlightColor;
  final BorderRadiusGeometry borderRadius;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static Skeleton? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Skeleton>();
  }
}
