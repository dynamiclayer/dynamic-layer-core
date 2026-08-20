/// DlPinKeyboard — Usage rules:
/// - A single circular key (80x80px) for PIN/passcode entry screens. Use
///   multiple instances arranged in a grid (3 columns) to build a full keypad.
/// - Use for security-critical flows that require PIN entry (e.g. banking app
///   login, transaction confirmation, app lock screen).
/// - Type text: Shows a number (required) and optional alphabet letters below.
///   Use for digit keys (e.g. number: "1", alphabet: "ABC").
/// - Type icon: Shows an icon instead of text. Use for special keys like
///   backspace or biometric authentication.
/// - Always pair with input fields above the keypad to show the entered
///   PIN digits.
/// - onPressed fires when the key is tapped. The parent manages the input logic.
/// - No size variants — one consistent size (80x80px).
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundations/icons/dl_icons.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlPinKeyboardState { defaultState, pressed }
enum DlPinKeyboardType { text, icon }

class DlPinKeyboard extends StatefulWidget {
  const DlPinKeyboard({
    super.key,
    this.type = DlPinKeyboardType.text,
    this.number,
    this.alphabet,
    this.icon,
    this.state = DlPinKeyboardState.defaultState,
    this.onPressed,
  }) : assert(
         type != DlPinKeyboardType.text ||
             (number != null && number.length > 0),
         'number is required when type is text.',
       );

  final DlPinKeyboardType type;
  final String? number;
  final String? alphabet;
  final Widget? icon;
  final DlPinKeyboardState state;
  final VoidCallback? onPressed;

  @override
  State<DlPinKeyboard> createState() => _DlPinKeyboardState();
}

class _DlPinKeyboardState extends State<DlPinKeyboard> {
  bool _pressedByGesture = false;

  bool get _isPressed =>
      widget.state == DlPinKeyboardState.pressed ||
      (widget.state == DlPinKeyboardState.defaultState && _pressedByGesture);

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final backgroundColor = _isPressed ? colors.grey.c200 : colors.grey.c100;

    return GestureDetector(
      key: const Key('dl_pin_keyboard_tap_area'),
      behavior: HitTestBehavior.translucent,
      onTap: widget.onPressed == null
          ? null
          : () {
              HapticFeedback.mediumImpact();
              widget.onPressed!.call();
            },
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: Container(
        key: const Key('dl_pin_keyboard_container'),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
        ),
        child: Center(child: _buildContent(colors)),
      ),
    );
  }

  Widget _buildContent(DlColorPalette colors) {
    if (widget.type == DlPinKeyboardType.icon) {
      return KeyedSubtree(
        key: const Key('dl_pin_keyboard_icon'),
        child: widget.icon ?? DlPlaceholderIcon(color: colors.black),
      );
    }

    return Column(
      key: const Key('dl_pin_keyboard_text_column'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.number!,
          key: const Key('dl_pin_keyboard_number'),
          style: DlTextStyles.text3Xl.regular.copyWith(color: colors.black),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        if (widget.alphabet != null)
          Text(
            widget.alphabet!,
            key: const Key('dl_pin_keyboard_alphabet'),
            style: DlTextStyles.textSm.regular.copyWith(
              color: colors.grey.c500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
      ],
    );
  }

  void _setPressed(bool value) {
    if (_pressedByGesture == value) return;
    setState(() => _pressedByGesture = value);
  }
}
