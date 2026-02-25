import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlOtpInputState { defaultState, error, success, disabled }
enum DlOtpInputSize { lg, md, sm }

class DlOTPInput extends StatefulWidget {
  const DlOTPInput({
    super.key,
    this.state = DlOtpInputState.defaultState,
    this.size = DlOtpInputSize.md,
    this.onChanged,
  });

  final DlOtpInputState state;
  final DlOtpInputSize size;
  final ValueChanged<String>? onChanged;

  @override
  State<DlOTPInput> createState() => _DlOTPInputState();
}

class _DlOTPInputState extends State<DlOTPInput> {
  static const Duration _maskDelay = Duration(milliseconds: 500);

  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  Timer? _maskTimer;
  bool _showMaskDot = false;

  bool get _isDisabled => widget.state == DlOtpInputState.disabled;
  bool get _isError => widget.state == DlOtpInputState.error;
  bool get _isSuccess => widget.state == DlOtpInputState.success;
  bool get _isActiveDefault =>
      widget.state == DlOtpInputState.defaultState && _focusNode.hasFocus;
  bool get _hasValue => _controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    _maskTimer?.cancel();
    _focusNode.removeListener(_handleFocusChanged);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChanged() {
    if (!_focusNode.hasFocus) {
      _maskTimer?.cancel();
    }
    if (mounted) setState(() {});
  }

  void _handleTap() {
    if (_isDisabled) return;
    _focusNode.requestFocus();
  }

  void _handleChanged(String value) {
    _maskTimer?.cancel();
    if (value.isEmpty) {
      if (_showMaskDot) setState(() => _showMaskDot = false);
      widget.onChanged?.call(value);
      return;
    }

    setState(() => _showMaskDot = false);
    _maskTimer = Timer(_maskDelay, () {
      if (!mounted || _controller.text.isEmpty) return;
      setState(() => _showMaskDot = true);
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final backgroundColor = _backgroundColor(colors);
    final borderColor = _borderColor(colors);
    final textColor = _textColor(colors);

    return GestureDetector(
      key: const Key('dl_otp_input_tap_area'),
      behavior: HitTestBehavior.translucent,
      onTap: _handleTap,
      child: Container(
        key: const Key('dl_otp_input_container'),
        width: _dimensionForSize(),
        height: _dimensionForSize(),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(DlRadiusTokens.roundedMd),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        child: _isDisabled
            ? Center(
                child: Text(
                  '-',
                  key: const Key('dl_otp_input_disabled_text'),
                  style: DlTextStyles.textBase.regular.copyWith(
                    color: colors.grey.c500,
                  ),
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  TextField(
                    key: const Key('dl_otp_input_text_field'),
                    controller: _controller,
                    focusNode: _focusNode,
                    enabled: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    cursorColor: textColor,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    style: DlTextStyles.textBase.semiBold.copyWith(
                      color: _showMaskDot ? Colors.transparent : textColor,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      counterText: '',
                    ),
                    onChanged: _handleChanged,
                  ),
                  if (_showMaskDot && _hasValue)
                    Container(
                      key: const Key('dl_otp_input_mask_dot'),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: textColor,
                        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  double _dimensionForSize() {
    switch (widget.size) {
      case DlOtpInputSize.lg:
        return 56;
      case DlOtpInputSize.md:
        return 48;
      case DlOtpInputSize.sm:
        return 40;
    }
  }

  Color _backgroundColor(DlColorPalette colors) {
    if (_isError) return colors.red.c50;
    if (_isSuccess) return colors.green.c50;
    return colors.grey.c100;
  }

  Color _borderColor(DlColorPalette colors) {
    if (_isError) return colors.red.c500;
    if (_isSuccess) return colors.green.c500;
    if (_isActiveDefault) return colors.black;
    return Colors.transparent;
  }

  Color _textColor(DlColorPalette colors) {
    if (_isError) return colors.red.c500;
    if (_isSuccess) return colors.green.c500;
    return colors.black;
  }
}
