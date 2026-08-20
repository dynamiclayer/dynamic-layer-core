/// DlSwitch — Usage rules:
/// - A toggle switch (50x32px) for on/off settings. Tapping switches between
///   inactive (grey) and active (black) with a sliding animation.
/// - Can be used standalone or paired with a label text in a Row. When used
///   with a label, default text style is DlTextStyles.textBase.regular.
/// - Use for binary settings (e.g. notifications on/off, dark mode).
///   For selecting an option from a group, use DlRadioButton or DlCheckbox.
/// - No size, state, or disabled variants — one consistent appearance.
/// - Has no callback — manages its own internal state. The parent reads the
///   state when needed.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../theme/dl_color_palette.dart';

class DlSwitch extends StatefulWidget {
  const DlSwitch({super.key});

  @override
  State<DlSwitch> createState() => _DlSwitchState();
}

class _DlSwitchState extends State<DlSwitch> {
  bool _isActive = false;

  void _toggle() {
    HapticFeedback.mediumImpact();
    setState(() => _isActive = !_isActive);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final backgroundColor = _isActive ? colors.green.c600 : colors.grey.c200;

    return GestureDetector(
      key: const Key('dl_switch_tap_area'),
      behavior: HitTestBehavior.translucent,
      onTap: _toggle,
      child: AnimatedContainer(
        key: const Key('dl_switch_track'),
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        width: 50,
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          alignment: _isActive ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            key: const Key('dl_switch_thumb'),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
            ),
          ),
        ),
      ),
    );
  }
}
