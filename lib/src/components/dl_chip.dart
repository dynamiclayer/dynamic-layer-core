/// DlChip — Usage rules:
/// - An interactive, toggleable pill. Tapping switches between default (grey)
///   and active (black) state. Use for filter options or selectable categories.
/// - Content-hugging — width fits the label. Has a pill shape (roundedFull).
/// - Unlike DlTag, the chip is interactive. Unlike DlButton, it toggles state
///   rather than triggering an action.
/// - Use multiple chips in a horizontal Wrap to let the user select one or more
///   options.
/// - States: defaultState (unselected), active (selected), disabled.
/// - Sizes: lg (default), md, sm.
/// - onStateChanged fires when the user toggles the chip and returns the new state.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlChipState { defaultState, active, disabled }
enum DlChipSize { lg, md, sm }

class DlChip extends StatefulWidget {
  const DlChip({
    required this.label,
    super.key,
    this.state = DlChipState.defaultState,
    this.size = DlChipSize.lg,
    this.onStateChanged,
  });

  final String label;
  final DlChipState state;
  final DlChipSize size;
  final ValueChanged<DlChipState>? onStateChanged;

  @override
  State<DlChip> createState() => _DlChipState();
}

class _DlChipState extends State<DlChip> {
  late DlChipState _state;

  bool get _isDisabled => _state == DlChipState.disabled;
  bool get _isActive => _state == DlChipState.active;

  @override
  void initState() {
    super.initState();
    _state = widget.state;
  }

  @override
  void didUpdateWidget(covariant DlChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      _state = widget.state;
    }
  }

  void _toggleState() {
    if (_isDisabled) return;
    HapticFeedback.mediumImpact();
    late DlChipState nextState;
    setState(() {
      nextState = _isActive ? DlChipState.defaultState : DlChipState.active;
      _state = nextState;
    });
    widget.onStateChanged?.call(nextState);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final backgroundColor = _isActive ? colors.black : colors.grey.c100;
    final textStyle = _textStyleForState(colors);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: const Key('dl_chip_tap_area'),
        onTap: _isDisabled ? null : _toggleState,
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: Container(
          key: const Key('dl_chip_container'),
          padding: _paddingForSize(),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
          ),
          child: Text(
            widget.label,
            key: const Key('dl_chip_text'),
            style: textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
      ),
    );
  }

  EdgeInsets _paddingForSize() {
    switch (widget.size) {
      case DlChipSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: DlSpacingTokens.p_16,
          vertical: DlSpacingTokens.p_8,
        );
      case DlChipSize.md:
        return const EdgeInsets.symmetric(
          horizontal: DlSpacingTokens.p_12,
          vertical: DlSpacingTokens.p_4,
        );
      case DlChipSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: DlSpacingTokens.p_8,
          vertical: DlSpacingTokens.p_2,
        );
    }
  }

  TextStyle _textStyleForState(DlColorPalette colors) {
    if (_isDisabled) {
      return _disabledBaseStyle().copyWith(color: colors.grey.c500);
    }

    return _enabledBaseStyle().copyWith(
      color: _isActive ? colors.white : colors.black,
    );
  }

  TextStyle _enabledBaseStyle() {
    switch (widget.size) {
      case DlChipSize.lg:
        return DlTextStyles.textBase.semiBold;
      case DlChipSize.md:
        return DlTextStyles.textSm.semiBold;
      case DlChipSize.sm:
        return DlTextStyles.textXs.semiBold;
    }
  }

  TextStyle _disabledBaseStyle() {
    switch (widget.size) {
      case DlChipSize.lg:
        return DlTextStyles.textBase.regular;
      case DlChipSize.md:
        return DlTextStyles.textSm.regular;
      case DlChipSize.sm:
        return DlTextStyles.textXs.regular;
    }
  }
}
