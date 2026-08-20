/// DlButtonLoading — Usage rules:
/// - Replaces a DlButton while an async action is in progress (e.g. form
///   submission, API call). Swap back to DlButton when the action completes.
/// - Must use the same type, size, and fullWidth as the DlButton it replaces,
///   so the layout does not shift during the loading state.
/// - Not interactive — has no onPressed. It is a visual indicator only.
/// - Shares the same Type and Size enums as DlButton.
/// - Sizes: lg (default, 56px), md (48px), sm (40px), xs (32px).
import 'package:flutter/material.dart';

import '../foundations/tokens/dl_border_width_tokens.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import 'dl_button.dart';
import 'dl_loading_dots.dart';

class DlButtonLoading extends StatefulWidget {
  const DlButtonLoading({
    super.key,
    this.type = DlButtonType.primary,
    this.size = DlButtonSize.lg,
    this.state = DlButtonState.defaultState,
    this.fullWidth = false,
    this.stepDuration = const Duration(milliseconds: 300),
  });

  final DlButtonType type;
  final DlButtonSize size;
  final DlButtonState state;
  final bool fullWidth;
  final Duration stepDuration;

  @override
  State<DlButtonLoading> createState() => _DlButtonLoadingState();
}

class _DlButtonLoadingState extends State<DlButtonLoading>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  bool get _isIntelligence => widget.type == DlButtonType.intelligence;
  bool get _isDanger => widget.state == DlButtonState.danger;
  bool get _isSuccess => widget.state == DlButtonState.success;

  @override
  void initState() {
    super.initState();
    if (_isIntelligence) _createAnimationController();
  }

  @override
  void didUpdateWidget(covariant DlButtonLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isIntelligence && _animationController == null) {
      _createAnimationController();
    } else if (!_isIntelligence && _animationController != null) {
      _animationController!.dispose();
      _animationController = null;
    }
  }

  void _createAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final backgroundColor = _backgroundColor(colors);
    final materialType = backgroundColor == null
        ? MaterialType.transparency
        : MaterialType.canvas;

    final buttonWidget = Material(
      key: const Key('dl_button_loading_material'),
      type: materialType,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
        side: _borderSide(colors),
      ),
      child: Container(
        key: const Key('dl_button_loading_container'),
        constraints: BoxConstraints(
          minHeight: _heightForSize(),
          minWidth: widget.fullWidth ? double.infinity : 0,
        ),
        padding: _paddingForSize(),
        child: Center(
          child: DlLoadingDots(
            stepDuration: widget.stepDuration,
            color: _dotColor(colors),
          ),
        ),
      ),
    );

    if (!_isIntelligence || _animationController == null) {
      return buttonWidget;
    }

    final gradientColors = [
      colors.orange.c500,
      colors.magenta.c500,
      colors.fuchsia.c500,
      colors.blue.c500,
      colors.cyan.c400,
    ];

    return Stack(
      children: [
        buttonWidget,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _animationController!,
              builder: (context, _) => CustomPaint(
                painter: _AnimatedBorderPainter(
                  progress: _animationController!.value,
                  colors: gradientColors,
                  strokeWidth: 1,
                  segmentLength: 240,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _dotColor(DlColorPalette colors) {
    if (widget.type == DlButtonType.primary) return colors.white;
    if (_isDanger) return colors.red.c500;
    if (_isSuccess) return colors.green.c600;
    return colors.black;
  }

  Color? _backgroundColor(DlColorPalette colors) {
    switch (widget.type) {
      case DlButtonType.primary:
        if (_isDanger) return colors.red.c500;
        if (_isSuccess) return colors.green.c600;
        return colors.black;
      case DlButtonType.secondary:
        return colors.grey.c100;
      case DlButtonType.tertiary:
        return colors.white;
      case DlButtonType.ghost:
        return null;
      case DlButtonType.intelligence:
        return colors.white;
    }
  }

  BorderSide _borderSide(DlColorPalette colors) {
    switch (widget.type) {
      case DlButtonType.primary:
      case DlButtonType.secondary:
      case DlButtonType.ghost:
        return BorderSide.none;
      case DlButtonType.intelligence:
        return BorderSide(
          color: colors.grey.c200,
          width: DlBorderWidthTokens.border1,
        );
      case DlButtonType.tertiary:
        return BorderSide(
          color: colors.grey.c200,
          width: DlBorderWidthTokens.border1,
        );
    }
  }

  double _heightForSize() {
    switch (widget.size) {
      case DlButtonSize.lg:
        return 56;
      case DlButtonSize.md:
        return 48;
      case DlButtonSize.sm:
        return 40;
      case DlButtonSize.xs:
        return 32;
    }
  }

  EdgeInsets _paddingForSize() {
    switch (widget.size) {
      case DlButtonSize.lg:
        return const EdgeInsets.fromLTRB(
          DlSpacingTokens.p_24,
          DlSpacingTokens.p_16,
          DlSpacingTokens.p_24,
          DlSpacingTokens.p_16,
        );
      case DlButtonSize.md:
        return const EdgeInsets.fromLTRB(
          DlSpacingTokens.p_16,
          DlSpacingTokens.p_12,
          DlSpacingTokens.p_16,
          DlSpacingTokens.p_12,
        );
      case DlButtonSize.sm:
        return const EdgeInsets.fromLTRB(
          DlSpacingTokens.p_16,
          DlSpacingTokens.p_8,
          DlSpacingTokens.p_16,
          DlSpacingTokens.p_8,
        );
      case DlButtonSize.xs:
        return const EdgeInsets.fromLTRB(
          DlSpacingTokens.p_12,
          DlSpacingTokens.p_4,
          DlSpacingTokens.p_12,
          DlSpacingTokens.p_4,
        );
    }
  }
}

class _AnimatedBorderPainter extends CustomPainter {
  _AnimatedBorderPainter({
    required this.progress,
    required this.colors,
    required this.strokeWidth,
    required this.segmentLength,
  });

  final double progress;
  final List<Color> colors;
  final double strokeWidth;
  final double segmentLength;

  static const int _steps = 32;
  static const double _fadeLength = 0.15;

  @override
  void paint(Canvas canvas, Size size) {
    final halfStroke = strokeWidth / 2;
    final rrect = RRect.fromRectAndRadius(
      (Offset.zero & size).deflate(halfStroke),
      Radius.circular(size.height / 2),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().first;
    final totalLength = metrics.length;
    final start = progress * totalLength;
    final stepLength = segmentLength / _steps;

    for (int i = 0; i < _steps; i++) {
      final t = i / (_steps - 1);
      final baseColor = _lerpColors(t);
      final opacity = _fadeOpacity(t);
      final color = baseColor.withOpacity(opacity);

      final segStart = (start + i * stepLength) % totalLength;
      final segEnd = (start + (i + 1) * stepLength) % totalLength;

      Path piece;
      if (segStart <= segEnd) {
        piece = metrics.extractPath(segStart, segEnd);
      } else {
        piece = metrics.extractPath(segStart, totalLength);
        piece.addPath(metrics.extractPath(0, segEnd), Offset.zero);
      }

      canvas.drawPath(
        piece,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = color,
      );
    }
  }

  Color _lerpColors(double t) {
    if (colors.length == 1) return colors[0];
    final scaled = t * (colors.length - 1);
    final index = scaled.floor().clamp(0, colors.length - 2);
    final localT = scaled - index;
    return Color.lerp(colors[index], colors[index + 1], localT)!;
  }

  double _fadeOpacity(double t) {
    if (t < _fadeLength) return t / _fadeLength;
    if (t > 1.0 - _fadeLength) return (1.0 - t) / _fadeLength;
    return 1.0;
  }

  @override
  bool shouldRepaint(_AnimatedBorderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
