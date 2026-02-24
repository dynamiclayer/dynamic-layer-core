import 'package:flutter/material.dart';

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
