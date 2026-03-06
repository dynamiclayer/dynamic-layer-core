import 'package:flutter/material.dart';

import '../foundations/tokens/dl_border_width_tokens.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import 'dl_button.dart';

class DlButtonIcon extends StatefulWidget {
  const DlButtonIcon({
    required this.icon,
    super.key,
    this.onPressed,
    this.type = DlButtonType.primary,
    this.size = DlButtonSize.lg,
    this.state = DlButtonState.defaultState,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final DlButtonType type;
  final DlButtonSize size;
  final DlButtonState state;

  @override
  State<DlButtonIcon> createState() => _DlButtonIconState();
}

class _DlButtonIconState extends State<DlButtonIcon> {
  bool _isPressedByGesture = false;

  bool get _isDisabled =>
      widget.state == DlButtonState.disabled || widget.onPressed == null;

  bool get _isPressedState =>
      widget.state == DlButtonState.pressed ||
      (widget.state == DlButtonState.defaultState && _isPressedByGesture);

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final foregroundColor = _foregroundColor(colors);
    final backgroundColor = _backgroundColor(colors);
    final materialType = backgroundColor == null
        ? MaterialType.transparency
        : MaterialType.canvas;

    final content = SizedBox.square(
      key: const Key('dl_button_icon_size_box'),
      dimension: _heightForSize(),
      child: Padding(
        key: const Key('dl_button_icon_padding'),
        padding: _paddingForSize(),
        child: Center(
          child: IconTheme(
            key: const Key('dl_button_icon_theme'),
            data: IconThemeData(color: foregroundColor),
            child: widget.icon,
          ),
        ),
      ),
    );

    return Material(
      key: const Key('dl_button_icon_material'),
      type: materialType,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedMd),
        side: _borderSide(colors),
      ),
      child: InkWell(
        onTap: _isDisabled ? null : widget.onPressed,
        onTapDown: _isDisabled ? null : (_) => _setPressedByGesture(true),
        onTapUp: _isDisabled ? null : (_) => _setPressedByGesture(false),
        onTapCancel: _isDisabled ? null : () => _setPressedByGesture(false),
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedMd),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: content,
      ),
    );
  }

  Color? _backgroundColor(DlColorPalette colors) {
    switch (widget.type) {
      case DlButtonType.primary:
        if (_isDisabled) return colors.grey.c100;
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
    }
  }

  Color _foregroundColor(DlColorPalette colors) {
    switch (widget.type) {
      case DlButtonType.primary:
        if (_isDisabled) return colors.grey.c600;
        return colors.white;
      case DlButtonType.secondary:
        if (_isDisabled) return colors.grey.c600;
        return colors.black;
      case DlButtonType.tertiary:
        if (_isDisabled) return colors.grey.c500;
        return colors.black;
      case DlButtonType.ghost:
        if (_isDisabled) return colors.grey.c500;
        return colors.black;
    }
  }

  BorderSide _borderSide(DlColorPalette colors) {
    switch (widget.type) {
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
        return const EdgeInsets.all(DlSpacingTokens.p_16);
      case DlButtonSize.md:
        return const EdgeInsets.all(DlSpacingTokens.p_12);
      case DlButtonSize.sm:
        return const EdgeInsets.all(DlSpacingTokens.p_8);
      case DlButtonSize.xs:
        return const EdgeInsets.all(DlSpacingTokens.p_4);
    }
  }

  void _setPressedByGesture(bool value) {
    if (_isPressedByGesture == value) return;
    setState(() => _isPressedByGesture = value);
  }
}
