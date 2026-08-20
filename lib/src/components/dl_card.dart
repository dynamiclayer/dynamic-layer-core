/// DlCard — Usage rules:
/// - A selectable card with icon, title, and optional description.
/// - Size md (default): Horizontal layout — icon left, text right. Use in
///   vertical lists or as selectable option rows.
/// - Size lg: Vertical layout — icon on top, text below. Use in grids
///   (e.g. two cards side by side with Expanded).
/// - Set enableActiveState: true to allow the card to toggle a selected state
///   (black border) on tap. Without it, the card still shows a press effect
///   but does not stay selected.
/// - States: defaultState, disabled.
/// - description is optional — use for a short subtitle below the title.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundations/tokens/dl_border_width_tokens.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlCardState { defaultState, disabled }
enum DlCardSize { md, lg }

class DlCard extends StatefulWidget {
  const DlCard({
    required this.icon,
    required this.title,
    this.description,
    this.onTap,
    this.enableActiveState = false,
    this.state = DlCardState.defaultState,
    this.size = DlCardSize.md,
  });

  final Widget icon;
  final String title;
  final String? description;
  final VoidCallback? onTap;
  final bool enableActiveState;
  final DlCardState state;
  final DlCardSize size;

  @override
  State<DlCard> createState() => _DlCardState();
}

class _DlCardState extends State<DlCard> {
  bool _isPressedByGesture = false;
  bool _isActive = false;

  bool get _isDisabled => widget.state == DlCardState.disabled;

  bool get _isInteractive => !_isDisabled;

  void _setPressedByGesture(bool value) {
    if (_isPressedByGesture == value) return;
    setState(() => _isPressedByGesture = value);
  }

  void _handleTap() {
    HapticFeedback.mediumImpact();
    if (widget.enableActiveState) {
      setState(() => _isActive = !_isActive);
    }
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final backgroundColor = _isPressedByGesture ? colors.grey.c200 : colors.grey.c100;
    final borderColor = _isActive && !_isDisabled ? colors.black : Colors.transparent;
    final contentColor = _isDisabled ? colors.grey.c500 : colors.black;
    final content = widget.size == DlCardSize.lg
        ? _buildVerticalContent(contentColor)
        : _buildHorizontalContent(contentColor);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: const Key('dl_card_tap_area'),
        onTap: _isInteractive ? _handleTap : null,
        onTapDown: _isInteractive ? (_) => _setPressedByGesture(true) : null,
        onTapUp: _isInteractive ? (_) => _setPressedByGesture(false) : null,
        onTapCancel: _isInteractive ? () => _setPressedByGesture(false) : null,
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedLg),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: Container(
          key: const Key('dl_card_container'),
          padding: EdgeInsets.all(_paddingForSize()),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(DlRadiusTokens.roundedLg),
            border: Border.all(
              color: borderColor,
              width: DlBorderWidthTokens.border2,
            ),
          ),
          child: content,
        ),
      ),
    );
  }

  Widget _buildHorizontalContent(Color contentColor) {
    return Row(
      key: const Key('dl_card_content_row'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconTheme(
          key: const Key('dl_card_icon_theme'),
          data: IconThemeData(color: contentColor),
          child: widget.icon,
        ),
        SizedBox(width: _gapForSize()),
        Expanded(child: _buildTextContainer(contentColor)),
      ],
    );
  }

  Widget _buildVerticalContent(Color contentColor) {
    return Column(
      key: const Key('dl_card_content_column'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconTheme(
          key: const Key('dl_card_icon_theme'),
          data: IconThemeData(color: contentColor),
          child: widget.icon,
        ),
        SizedBox(height: _gapForSize()),
        _buildTextContainer(contentColor),
      ],
    );
  }

  Widget _buildTextContainer(Color contentColor) {
    return Column(
      key: const Key('dl_card_text_container'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          key: const Key('dl_card_title'),
          style: DlTextStyles.textBase.bold.copyWith(
            color: contentColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          textAlign: TextAlign.start,
        ),
        if (widget.description != null)
          Text(
            widget.description!,
            key: const Key('dl_card_description'),
            style: DlTextStyles.textBase.regular.copyWith(
              color: context.dlColors.grey.c500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            textAlign: TextAlign.start,
          ),
      ],
    );
  }

  double _paddingForSize() {
    switch (widget.size) {
      case DlCardSize.md:
        return DlSpacingTokens.p_12;
      case DlCardSize.lg:
        return DlSpacingTokens.p_16;
    }
  }

  double _gapForSize() {
    switch (widget.size) {
      case DlCardSize.md:
        return DlSpacingTokens.p_12;
      case DlCardSize.lg:
        return DlSpacingTokens.p_16;
    }
  }
}
