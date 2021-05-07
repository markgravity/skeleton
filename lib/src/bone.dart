import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'skeleton.dart';

part 'bone_transition.dart';

class Bone extends StatefulWidget {
  ///
  /// A constructor create a
  /// single [Bone] with `width` and `height`
  ///
  Bone({
    Key? key,
    required this.child,
    this.width = double.infinity,
    required this.height,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.transition,
    this.period = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
  })  : number = 1,
        spacing = 0,
        variants = [1],
        _isHiddenOnly = false,
        super(key: key);

  ///
  /// A convenient constructor provides an easy and convenient way to create a
  /// multi [Bone] with `width` and `height` are the size of each [Bone]
  ///
  Bone.multiple({
    Key? key,
    required this.child,
    required this.number,
    this.width = double.infinity,
    this.height = 30,
    this.spacing = 8,
    this.variants = const [1],
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.transition,
    this.period = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
  })  : _isHiddenOnly = false,
        super(key: key);

  ///
  /// A convenient constructor provides an easy and convenient way to create a
  /// a [Bone] which hide the `child` when [Skeleton.isShown] is true, and vice versa
  ///
  Bone.hidden({
    Key? key,
    required this.child,
    this.transition,
  })  : width = 0,
        height = 0,
        number = 1,
        spacing = 0,
        variants = [1],
        baseColor = const Color(0xFFE0E0E0),
        highlightColor = const Color(0xFFF5F5F5),
        borderRadius = null,
        _isHiddenOnly = true,
        period = const Duration(milliseconds: 1500),
        direction = ShimmerDirection.ltr,
        super(key: key);

  /// The widget will be shown when [Skeleton.isShown] is false
  final Widget child;

  /// The width of a bone
  final double width;

  /// The height of a bone
  final double height;

  /// The number of bones will be generated
  final int number;

  /// The spacing between bones
  /// Only effect when [number] is greater than 1
  final double spacing;

  /// The list of variant of bone's width
  /// If the size of [variants] is smaller than [number] of bones,
  /// it will takes the last variant for the rest bones
  final List<double> variants;

  /// The background color of a bone
  final Color baseColor;

  /// The shimmer color
  final Color highlightColor;

  /// The border radius of a bone
  final BorderRadiusGeometry? borderRadius;

  /// When it's true, this bone only handle
  /// show/hide [child] base on [Skeleton.isShown]
  final bool _isHiddenOnly;

  /// The showing transition when [Skeleton.isShown] is false
  final BoneTransition? transition;

  /// It controls the speed of shimmer effect. The default value is 1500
  /// milliseconds.
  final Duration period;

  /// It controls the direction of shimmer effect. The default value
  /// is [ShimmerDirection.ltr].
  final ShimmerDirection direction;

  @override
  _BoneState createState() => _BoneState();
}

class _BoneState extends State<Bone> with SingleTickerProviderStateMixin {
  late final BoneTransition transition =
      widget.transition ?? BoneTransition.fadeIn;

  /// It controls showing animation
  late final animationController = AnimationController(
    vsync: this,
    duration: transition.duration,
  );

  /// The current [Skeleton]
  Skeleton? get skeleton => Skeleton.of(context);

  /// Presents for the first build
  bool isInitialed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      isInitialed = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!skeleton!.isShown) animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    if (widget._isHiddenOnly)
      return skeleton!.isShown ? SizedBox.shrink() : _createTransition();

    return skeleton!.isShown
        ? Shimmer.fromColors(
            baseColor: skeleton!.baseColor ?? widget.baseColor,
            highlightColor: skeleton!.highlightColor ?? widget.highlightColor,
            enabled: skeleton!.isShown,
            period: skeleton!.period ?? widget.period,
            direction: skeleton!.direction ?? widget.direction,
            child: _makeBones(),
          )
        : _createTransition();
  }

  /// Create a transition widget
  /// If it's the first time this widget get build,
  /// it just returns [widget.child] without showing animation
  Widget _createTransition() {
    return isInitialed
        ? transition._build(
            child: widget.child, controller: animationController)
        : widget.child;
  }

  /// Create a list of bone widget
  Widget _makeBones() {
    final children = List<Widget>.empty(growable: true);
    for (var i = 0; i < widget.number; i++) {
      if (i != 0)
        children.add(SizedBox(height: skeleton!.spacing ?? widget.spacing));

      children.add(_makeBone(i));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  /// Create a single bone
  Widget _makeBone(int index) {
    final variant = index < widget.variants.length - 1
        ? widget.variants[index]
        : widget.variants.last;

    final line = Container(
      width: widget.width * variant,
      height: skeleton!.height ?? widget.height,
      decoration: BoxDecoration(
        borderRadius: skeleton?.borderRadius ?? widget.borderRadius,
        color: Colors.white,
      ),
    );

    if (widget.width == double.infinity) {
      return FractionallySizedBox(
        widthFactor: variant,
        child: line,
      );
    }
    return line;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
