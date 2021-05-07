part of 'bone.dart';

typedef BoneTransitionBuilder = Widget Function(
    Widget child, AnimationController controller);

class BoneTransition {
  const BoneTransition({
    required this.builder,
    this.duration = const Duration(milliseconds: 600),
  });

  static final fadeIn = BoneTransition(
    builder: (child, controller) => FadeTransition(
      opacity: CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
      child: child,
    ),
  );

  /// A function to create a transition widget
  final BoneTransitionBuilder builder;

  /// The duration of animation
  final Duration duration;

  /// Create a transition widget
  Widget _build(
      {required Widget child, required AnimationController controller}) {
    return builder(child, controller);
  }
}
