import 'package:flutter/material.dart';

import '../foundations/tokens/dl_border_width_tokens.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import 'dl_button.dart';
import 'dl_loading_dots.dart';

class DlButtonLoading extends StatelessWidget {
  const DlButtonLoading({
    super.key,
    this.type = DlButtonType.primary,
    this.size = DlButtonSize.lg,
    this.fullWidth = false,
    this.stepDuration = const Duration(milliseconds: 300),
  });

  final DlButtonType type;
  final DlButtonSize size;
  final bool fullWidth;
  final Duration stepDuration;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final backgroundColor = _backgroundColor(colors);
    final materialType = backgroundColor == null
        ? MaterialType.transparency
        : MaterialType.canvas;

    return Material(
      key: const Key('dl_button_loading_material'),
      type: materialType,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedMd),
        side: _borderSide(colors),
      ),
      child: Container(
        key: const Key('dl_button_loading_container'),
        constraints: BoxConstraints(
          minHeight: _heightForSize(),
          minWidth: fullWidth ? double.infinity : 0,
        ),
        padding: _paddingForSize(),
        child: Center(
          child: DlLoadingDots(
            stepDuration: stepDuration,
            color: type == DlButtonType.primary ? colors.white : colors.black,
          ),
        ),
      ),
    );
  }

  Color? _backgroundColor(DlColorPalette colors) {
    switch (type) {
      case DlButtonType.primary:
        return colors.black;
      case DlButtonType.secondary:
        return colors.grey.c100;
      case DlButtonType.tertiary:
        return colors.white;
      case DlButtonType.ghost:
        return null;
    }
  }

  BorderSide _borderSide(DlColorPalette colors) {
    switch (type) {
      case DlButtonType.primary:
      case DlButtonType.secondary:
      case DlButtonType.ghost:
        return BorderSide.none;
      case DlButtonType.tertiary:
        return BorderSide(
          color: colors.grey.c200,
          width: DlBorderWidthTokens.border1,
        );
    }
  }

  double _heightForSize() {
    switch (size) {
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
    switch (size) {
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
