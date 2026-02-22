import 'package:flutter/material.dart';

import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import 'dl_button.dart';
import 'dl_separator.dart';

class DlButtonDock extends StatelessWidget {
  DlButtonDock({
    required this.buttons,
    super.key,
    this.direction = Axis.horizontal,
    this.showSeparator = true,
  }) : assert(buttons.length > 0, 'buttons must not be empty');

  final List<DlButton> buttons;
  final Axis direction;
  final bool showSeparator;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final normalizedButtons = buttons.map(_withDockButtonSizing).toList();
    final dockButtons = direction == Axis.horizontal
        ? normalizedButtons.map((button) => Expanded(child: button)).toList()
        : normalizedButtons
              .map((button) => SizedBox(width: double.infinity, child: button))
              .toList();

    return Container(
      key: const Key('dl_button_dock_container'),
      width: double.infinity,
      color: colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showSeparator) const DlSeparator(),
          Padding(
            padding: const EdgeInsets.all(DlSpacingTokens.p_16),
            child: Flex(
              key: const Key('dl_button_dock_buttons'),
              direction: direction,
              spacing: DlSpacingTokens.p_16,
              children: dockButtons,
            ),
          ),
        ],
      ),
    );
  }

  DlButton _withDockButtonSizing(DlButton button) {
    return DlButton(
      key: button.key,
      label: button.label,
      onPressed: button.onPressed,
      type: button.type,
      size: button.size,
      state: button.state,
      iconLeft: button.iconLeft,
      iconRight: button.iconRight,
      fullWidth: true,
    );
  }
}
