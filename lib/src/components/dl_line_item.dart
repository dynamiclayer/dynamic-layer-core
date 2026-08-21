/// DlLineItem — Usage rules:
/// - A full-width list row with a title, optional description on the left,
///   and an optional trailing element on the right.
/// - Types control the trailing element: defaultType (no trailing element),
///   switchType (DlSwitch), button (DlButton xs), checkbox (DlCheckbox),
///   radioButton (DlRadioButton), chevron (arrow icon for navigation).
/// - For checkbox, radioButton, and chevron types, the entire row is tappable.
///   For switchType and button, only the trailing element is interactive.
/// - Use multiple line items stacked vertically for settings pages, option
///   lists, or selection screens.
/// - showSeparator: true (default) adds a DlSeparator below the row. Set to
///   false for the last item in a group.
/// - States: defaultState, disabled.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundations/icons/dl_icons.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';
import 'dl_button.dart';
import 'dl_checkbox.dart';
import 'dl_radio_button.dart';
import 'dl_separator.dart';
import 'dl_switch.dart';

enum DlLineItemType { defaultType, switchType, button, checkbox, radioButton, chevron }
enum DlLineItemState { defaultState, disabled, danger, success }

class DlLineItem extends StatefulWidget {
  const DlLineItem({
    required this.title,
    super.key,
    this.description,
    this.type = DlLineItemType.defaultType,
    this.state = DlLineItemState.defaultState,
    this.showSeparator = true,
    this.buttonLabel = 'Button',
    this.onButtonPressed,
    this.onItemTap,
    this.radioSelected,
    this.onRadioSelectedChanged,
    this.iconLeft = false,
    this.iconLeftWidget,
    this.buttonType = DlButtonType.secondary,
    this.buttonState = DlButtonState.defaultState,
  });

  final String title;
  final String? description;
  final DlLineItemType type;
  final DlLineItemState state;
  final bool showSeparator;
  final String buttonLabel;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onItemTap;
  final bool? radioSelected;
  final ValueChanged<bool>? onRadioSelectedChanged;
  final bool iconLeft;
  final Widget? iconLeftWidget;
  final DlButtonType buttonType;
  final DlButtonState buttonState;

  @override
  State<DlLineItem> createState() => _DlLineItemState();
}

class _DlLineItemState extends State<DlLineItem> {
  DlCheckboxState _checkboxState = DlCheckboxState.defaultState;
  DlRadioButtonState _radioButtonState = DlRadioButtonState.defaultState;

  bool get _effectiveRadioSelected =>
      widget.radioSelected ?? (_radioButtonState == DlRadioButtonState.active);

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final hasDescription =
        widget.description != null && widget.description!.isNotEmpty;
    final isDisabled = widget.state == DlLineItemState.disabled;
    final isDanger = widget.state == DlLineItemState.danger;
    final isSuccess = widget.state == DlLineItemState.success;
    final titleColor = isDisabled
        ? colors.grey.c500
        : isDanger
            ? colors.red.c500
            : colors.black;
    final titleStyle = isDisabled
        ? DlTextStyles.textBase.regular.copyWith(color: titleColor)
        : DlTextStyles.textBase.semiBold.copyWith(color: titleColor);
    final descriptionStyle = DlTextStyles.textBase.regular.copyWith(
      color: colors.grey.c500,
    );

    return Column(
      key: const Key('dl_line_item'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          key: const Key('dl_line_item_tap_area'),
          behavior: HitTestBehavior.translucent,
          onTap: (_isWholeComponentTappable && !isDisabled)
              ? _handleWholeComponentTap
              : null,
          child: Padding(
            key: const Key('dl_line_item_content_padding'),
            padding: const EdgeInsets.symmetric(vertical: DlSpacingTokens.p_12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.iconLeft) ...[
                        IconTheme(
                          key: const Key('dl_line_item_icon_left_theme'),
                          data: IconThemeData(
                            color: isDanger
                                ? colors.red.c500
                                : isSuccess
                                    ? colors.green.c600
                                    : colors.grey.c400,
                          ),
                          child: widget.iconLeftWidget ?? const DlPlaceholderIcon(
                            key: Key('dl_line_item_icon_left'),
                          ),
                        ),
                        const SizedBox(width: DlSpacingTokens.p_16),
                      ],
                      Expanded(
                        child: Column(
                          key: const Key('dl_line_item_text_box'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              key: const Key('dl_line_item_title'),
                              style: titleStyle,
                            ),
                            if (hasDescription) ...[
                              const SizedBox(height: DlSpacingTokens.p_8),
                              Text(
                                widget.description!,
                                key: const Key('dl_line_item_description'),
                                style: descriptionStyle,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (_showsTrailingElement) ...[
                  const SizedBox(width: DlSpacingTokens.p_16),
                  _buildTrailingElement(colors, isDisabled: isDisabled),
                ],
              ],
            ),
          ),
        ),
        if (widget.showSeparator)
          const DlSeparator(key: Key('dl_line_item_separator')),
      ],
    );
  }

  bool get _showsTrailingElement => widget.type != DlLineItemType.defaultType;
  bool get _isWholeComponentTappable =>
      widget.type == DlLineItemType.checkbox ||
      widget.type == DlLineItemType.radioButton ||
      widget.type == DlLineItemType.chevron;

  Widget _buildTrailingElement(
    DlColorPalette colors, {
    required bool isDisabled,
  }) {
    switch (widget.type) {
      case DlLineItemType.defaultType:
        return const SizedBox.shrink();
      case DlLineItemType.switchType:
        return IgnorePointer(
          ignoring: isDisabled,
          child: const DlSwitch(key: Key('dl_line_item_switch')),
        );
      case DlLineItemType.button:
        return DlButton(
          key: const Key('dl_line_item_button'),
          label: widget.buttonLabel,
          type: widget.buttonType,
          size: DlButtonSize.xs,
          state: isDisabled ? DlButtonState.disabled : widget.buttonState,
          onPressed: isDisabled ? _noop : (widget.onButtonPressed ?? _noop),
        );
      case DlLineItemType.checkbox:
        return IgnorePointer(
          child: DlCheckbox(
            key: const Key('dl_line_item_checkbox'),
            state: isDisabled ? DlCheckboxState.disabled : _checkboxState,
          ),
        );
      case DlLineItemType.radioButton:
        return IgnorePointer(
          child: DlRadioButton(
            key: const Key('dl_line_item_radio_button'),
            state: isDisabled
                ? DlRadioButtonState.disabled
                : (_effectiveRadioSelected
                      ? DlRadioButtonState.active
                      : DlRadioButtonState.defaultState),
          ),
        );
      case DlLineItemType.chevron:
        return IconTheme(
          key: const Key('dl_line_item_chevron_theme'),
          data: IconThemeData(
            color: isDisabled ? colors.grey.c400 : colors.black,
          ),
          child: const DlAssetIcon(
            key: Key('dl_line_item_chevron'),
            assetPath: DlIcons.chevronRightAsset,
          ),
        );
    }
  }

  void _handleWholeComponentTap() {
    switch (widget.type) {
      case DlLineItemType.checkbox:
        HapticFeedback.mediumImpact();
        setState(() {
          _checkboxState = _checkboxState == DlCheckboxState.active
              ? DlCheckboxState.defaultState
              : DlCheckboxState.active;
        });
        break;
      case DlLineItemType.radioButton:
        HapticFeedback.mediumImpact();
        final nextSelected = !_effectiveRadioSelected;
        if (widget.radioSelected == null) {
          setState(() {
            _radioButtonState = nextSelected
                ? DlRadioButtonState.active
                : DlRadioButtonState.defaultState;
          });
        }
        widget.onRadioSelectedChanged?.call(nextSelected);
        break;
      case DlLineItemType.chevron:
        HapticFeedback.mediumImpact();
        break;
      case DlLineItemType.defaultType:
      case DlLineItemType.switchType:
      case DlLineItemType.button:
        return;
    }
    widget.onItemTap?.call();
  }

  static void _noop() {}
}
