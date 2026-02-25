import 'package:flutter/material.dart';

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
    setState(() => _isActive = !_isActive);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final backgroundColor = _isActive ? colors.black : colors.grey.c200;

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
              color: colors.white,
              borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
            ),
          ),
        ),
      ),
    );
  }
}
