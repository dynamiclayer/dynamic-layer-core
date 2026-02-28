import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../theme/dl_color_palette.dart';

class DlSkeleton extends StatefulWidget {
  const DlSkeleton({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.rounded = DlRadiusTokens.roundedMd,
  });

  final double width;
  final double height;
  final double rounded;

  @override
  State<DlSkeleton> createState() => _DlSkeletonState();
}

class _DlSkeletonState extends State<DlSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final colors = context.dlColors;
    _colorAnimation = ColorTween(
      begin: colors.grey.c50,
      end: colors.grey.c100,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          key: const Key('dl_skeleton'),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.circular(widget.rounded),
          ),
        );
      },
    );
  }
}
