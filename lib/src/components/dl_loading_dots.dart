/// DlLoadingDots — Usage rules:
/// - Three animated bouncing dots (48x16px) indicating a loading/processing
///   state. The dots cycle through a bounce animation.
/// - Used internally by DlButtonLoading. Can also be used standalone for
///   custom loading indicators.
/// - color is optional — defaults to context.dlColors.black. Override when
///   placed on a dark background (e.g. white dots on a primary button).
/// - stepDuration controls the animation speed (default: 300ms per step).
/// - Fixed size — no size or type variants.
import 'dart:async';

import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../theme/dl_color_palette.dart';

class DlLoadingDots extends StatefulWidget {
  const DlLoadingDots({
    super.key,
    this.stepDuration = const Duration(milliseconds: 300),
    this.color,
  });

  final Duration stepDuration;
  final Color? color;

  @override
  State<DlLoadingDots> createState() => _DlLoadingDotsState();
}

class _DlLoadingDotsState extends State<DlLoadingDots> {
  Timer? _timer;
  int _activeIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _activeIndex = 0);
      _startTimer();
    });
  }

  @override
  void didUpdateWidget(covariant DlLoadingDots oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stepDuration != widget.stepDuration) {
      _timer?.cancel();
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final effectiveColor = widget.color ?? colors.black;

    return SizedBox(
      key: const Key('dl_loading_dots'),
      width: 48,
      height: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) => _buildDot(effectiveColor, index)),
      ),
    );
  }

  Widget _buildDot(Color color, int index) {
    return SizedBox(
      width: 10,
      height: 16,
      child: AnimatedAlign(
        key: Key('dl_loading_dot_align_$index'),
        duration: widget.stepDuration,
        curve: Curves.easeInOut,
        alignment: _activeIndex == index
            ? Alignment.topCenter
            : Alignment.bottomCenter,
        child: Container(
          key: Key('dl_loading_dot_$index'),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
          ),
        ),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.stepDuration, (_) {
      if (!mounted || _activeIndex < 0) return;
      setState(() => _activeIndex = (_activeIndex + 1) % 3);
    });
  }
}
