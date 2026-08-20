/// DlButton — Usage rules:
/// - Default width is content-hugging (fits the label).
/// - Use fullWidth: true when the button is placed inside a container/box
///   alongside other full-width elements (e.g. DlInput). The button should
///   match the width of its sibling elements within the same container.
/// - Types: primary (main action), secondary (alternative action),
///   tertiary (bordered, less emphasis), ghost (no background, minimal emphasis),
///   intelligence (animated gradient border effect).
/// - Use only one primary button per screen to keep the visual hierarchy clear.
/// - Sizes: lg (default, 56px) for main actions, md (48px) for standard,
///   sm (40px) for compact areas, xs (32px) for inline or tight layouts.
/// - To disable, set state: DlButtonState.disabled.
/// - For destructive actions, set state: DlButtonState.danger. Primary uses
///   red background; secondary, tertiary, and ghost use red text color.
/// - For positive actions, set state: DlButtonState.success. Primary uses
///   green background; secondary, tertiary, and ghost use green text color.
/// - iconLeft / iconRight are optional. Do not use both icons together with a
///   long label — prefer one icon side to keep the button clean.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundations/tokens/dl_border_width_tokens.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlButtonType { primary, secondary, tertiary, ghost, intelligence }

enum DlButtonSize { lg, md, sm, xs }

enum DlButtonState { defaultState, pressed, disabled, danger, success }

class DlButton extends StatefulWidget {
  const DlButton({
    required this.label,
    super.key,
    this.onPressed,
    this.type = DlButtonType.primary,
    this.size = DlButtonSize.lg,
    this.state = DlButtonState.defaultState,
    this.iconLeft,
    this.iconRight,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final DlButtonType type;
  final DlButtonSize size;
  final DlButtonState state;
  final Widget? iconLeft;
  final Widget? iconRight;
  final bool fullWidth;

  @override
  State<DlButton> createState() => _DlButtonState();
}

class _DlButtonState extends State<DlButton>
    with SingleTickerProviderStateMixin {
  bool _isPressedByGesture = false;
  AnimationController? _animationController;

  bool get _isDisabled =>
      widget.state == DlButtonState.disabled || widget.onPressed == null;

  bool get _isDanger => widget.state == DlButtonState.danger;

  bool get _isSuccess => widget.state == DlButtonState.success;

  bool get _isPressedState =>
      widget.state == DlButtonState.pressed ||
      ((widget.state == DlButtonState.defaultState || _isDanger || _isSuccess) &&
          _isPressedByGesture);

  bool get _isIntelligence => widget.type == DlButtonType.intelligence;

  @override
  void initState() {
    super.initState();
    if (_isIntelligence) _createAnimationController();
  }

  @override
  void didUpdateWidget(covariant DlButton oldWidget) {
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
    final foregroundColor = _foregroundColor(colors);
    final backgroundColor = _backgroundColor(colors);
    final materialType =
        backgroundColor == null ? MaterialType.transparency : MaterialType.canvas;
    final textStyle = DlTextStyles.textBase.semiBold.copyWith(color: foregroundColor);

    final buttonChild = Row(
      mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.iconLeft != null) ...[
          IconTheme(
            key: const Key('dl_button_icon_left_theme'),
            data: IconThemeData(color: foregroundColor),
            child: widget.iconLeft!,
          ),
          SizedBox(width: _gapForSize()),
        ],
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            widget.label,
            style: textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
        if (widget.iconRight != null) ...[
          SizedBox(width: _gapForSize()),
          IconTheme(
            key: const Key('dl_button_icon_right_theme'),
            data: IconThemeData(color: foregroundColor),
            child: widget.iconRight!,
          ),
        ],
      ],
    );

    final content = Container(
      constraints: BoxConstraints(
        minHeight: _heightForSize(),
        minWidth: widget.fullWidth ? double.infinity : 0,
      ),
      padding: _paddingForSize(),
      child: buttonChild,
    );

    final buttonWidget = Material(
      key: const Key('dl_button_material'),
      type: materialType,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
        side: _borderSide(colors),
      ),
      child: InkWell(
        onTap: _isDisabled
            ? null
            : () {
                HapticFeedback.mediumImpact();
                widget.onPressed?.call();
              },
        onTapDown: _isDisabled ? null : (_) => _setPressedByGesture(true),
        onTapUp: _isDisabled ? null : (_) => _setPressedByGesture(false),
        onTapCancel: _isDisabled ? null : () => _setPressedByGesture(false),
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: content,
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

  Color? _backgroundColor(DlColorPalette colors) {
    switch (type) {
      case DlButtonType.primary:
        if (_isDisabled) return colors.grey.c100;
        if (_isDanger) {
          if (_isPressedByGesture) return colors.red.c600;
          return colors.red.c500;
        }
        if (_isSuccess) {
          if (_isPressedByGesture) return colors.green.c700;
          return colors.green.c600;
        }
        if (_isPressedState) return colors.grey.c700;
        return colors.black;
      case DlButtonType.secondary:
        if (_isDisabled) return colors.grey.c100;
        if (_isPressedState) return colors.grey.c200;
        return colors.grey.c100;
      case DlButtonType.tertiary:
        if (_isDisabled) return colors.white;
        if (_isPressedState) return colors.grey.c100;
        return colors.white;
      case DlButtonType.ghost:
        if (_isPressedState) return colors.grey.c100;
        return null;
      case DlButtonType.intelligence:
        if (_isDisabled) return colors.white;
        if (_isPressedState) return colors.grey.c100;
        return colors.white;
    }
  }

  Color _foregroundColor(DlColorPalette colors) {
    switch (type) {
      case DlButtonType.primary:
        if (_isDisabled) return colors.grey.c600;
        return colors.white;
      case DlButtonType.secondary:
        if (_isDisabled) return colors.grey.c600;
        if (_isDanger) return colors.red.c500;
        if (_isSuccess) return colors.green.c600;
        return colors.black;
      case DlButtonType.tertiary:
        if (_isDisabled) return colors.grey.c500;
        if (_isDanger) return colors.red.c500;
        if (_isSuccess) return colors.green.c600;
        return colors.black;
      case DlButtonType.ghost:
        if (_isDisabled) return colors.grey.c500;
        if (_isDanger) return colors.red.c500;
        if (_isSuccess) return colors.green.c600;
        return colors.black;
      case DlButtonType.intelligence:
        if (_isDisabled) return colors.grey.c500;
        return colors.black;
    }
  }

  BorderSide _borderSide(DlColorPalette colors) {
    switch (type) {
      case DlButtonType.primary:
      case DlButtonType.secondary:
        return BorderSide.none;
      case DlButtonType.tertiary:
        return BorderSide(
          color: colors.grey.c200,
          width: DlBorderWidthTokens.border1,
        );
      case DlButtonType.ghost:
        return BorderSide.none;
      case DlButtonType.intelligence:
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

  double _gapForSize() {
    switch (widget.size) {
      case DlButtonSize.lg:
      case DlButtonSize.md:
      case DlButtonSize.sm:
        return DlSpacingTokens.p_8;
      case DlButtonSize.xs:
        return DlSpacingTokens.p_4;
    }
  }

  DlButtonType get type => widget.type;

  void _setPressedByGesture(bool value) {
    if (_isPressedByGesture == value) return;
    setState(() => _isPressedByGesture = value);
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
