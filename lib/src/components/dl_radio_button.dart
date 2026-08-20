/// DlRadioButton — Usage rules:
/// - A toggleable radio button (24x24px). Tapping switches between unselected
///   (default) and selected (active) state.
/// - Always pair with a label text in a Row. The radio button alone has no
///   label — place a Text widget next to it. Default text style for the label
///   is DlTextStyles.textBase.regular.
/// - Use for single-select scenarios where only one option can be chosen from
///   a group. For multi-select, use DlCheckbox instead.
/// - The parent widget is responsible for ensuring only one radio button in a
///   group is active at a time.
/// - States: defaultState (unselected), active (selected), disabled.
/// - No size variants — one consistent size (24x24px).
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundations/tokens/dl_border_width_tokens.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../theme/dl_color_palette.dart';

enum DlRadioButtonState { defaultState, active, disabled }

class DlRadioButton extends StatefulWidget {
  const DlRadioButton({
    super.key,
    this.state = DlRadioButtonState.defaultState,
  });

  final DlRadioButtonState state;

  @override
  State<DlRadioButton> createState() => _DlRadioButtonState();
}

class _DlRadioButtonState extends State<DlRadioButton> {
  late DlRadioButtonState _state;

  bool get _isDisabled => _state == DlRadioButtonState.disabled;
  bool get _isActive => _state == DlRadioButtonState.active;

  @override
  void initState() {
    super.initState();
    _state = widget.state;
  }

  @override
  void didUpdateWidget(covariant DlRadioButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      _state = widget.state;
    }
  }

  void _toggleState() {
    if (_isDisabled) return;
    HapticFeedback.mediumImpact();
    setState(() {
      _state = _isActive ? DlRadioButtonState.defaultState : DlRadioButtonState.active;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final backgroundColor = _isDisabled
        ? colors.grey.c50
        : (_isActive ? colors.black : colors.white);
    final borderColor = _isActive ? Colors.transparent : colors.grey.c200;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: const Key('dl_radio_button_tap_area'),
        onTap: _isDisabled ? null : _toggleState,
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: SizedBox(
          key: const Key('dl_radio_button_outer'),
          width: 24,
          height: 24,
          child: Center(
            child: Container(
              key: const Key('dl_radio_button_inner'),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
                border: Border.all(
                  color: borderColor,
                  width: DlBorderWidthTokens.border1,
                ),
              ),
              child: _isActive
                  ? Center(
                      child: Container(
                        key: const Key('dl_radio_button_active_dot'),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: colors.white,
                          borderRadius: BorderRadius.circular(
                            DlRadiusTokens.roundedFull,
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
