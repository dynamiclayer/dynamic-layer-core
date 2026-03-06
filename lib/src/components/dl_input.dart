import 'package:flutter/material.dart';

import '../foundations/icons/dl_icons.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlInputType { defaultType, error, success }

enum DlInputSize { lg, mg, sm }

class DlInput extends StatefulWidget {
  const DlInput({
    required this.placeholder,
    super.key,
    this.iconLeft,
    this.iconRight,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.type = DlInputType.defaultType,
    this.size = DlInputSize.lg,
    this.errorHelperText,
  });

  final String placeholder;
  final Widget? iconLeft;
  final Widget? iconRight;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final DlInputType type;
  final DlInputSize size;
  final String? errorHelperText;

  @override
  State<DlInput> createState() => _DlInputState();
}

class _DlInputState extends State<DlInput> {
  FocusNode? _internalFocusNode;
  TextEditingController? _internalController;

  FocusNode get _focusNode => widget.focusNode ?? _internalFocusNode!;
  TextEditingController get _controller =>
      widget.controller ?? _internalController!;

  bool get _isActive => widget.enabled && _focusNode.hasFocus;
  bool get _isFilled => _controller.text.isNotEmpty;
  bool get _showStackedContent => _isActive || _isFilled;
  bool get _isErrorType => widget.type == DlInputType.error;
  bool get _isSuccessType => widget.type == DlInputType.success;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode == null ? FocusNode() : null;
    _internalController = widget.controller == null
        ? TextEditingController()
        : null;
    _focusNode.addListener(_handleFocusChanged);
    _controller.addListener(_handleTextChanged);
  }

  @override
  void didUpdateWidget(covariant DlInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChanged);
      if (oldWidget.focusNode == null) {
        _internalFocusNode?.removeListener(_handleFocusChanged);
        _internalFocusNode?.dispose();
        _internalFocusNode = null;
      }
      _internalFocusNode = widget.focusNode == null ? FocusNode() : null;
      _focusNode.addListener(_handleFocusChanged);
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleTextChanged);
      if (oldWidget.controller == null) {
        _internalController?.removeListener(_handleTextChanged);
        _internalController?.dispose();
        _internalController = null;
      }
      _internalController = widget.controller == null
          ? TextEditingController()
          : null;
      _controller.addListener(_handleTextChanged);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChanged);
    _controller.removeListener(_handleTextChanged);
    _internalFocusNode?.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  void _handleFocusChanged() {
    if (mounted) setState(() {});
  }

  void _handleTextChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final inputContent = _buildInputContent(colors);
    final helperText = _errorHelperText;
    final showErrorHelper = helperText != null;
    final rightIcon = _effectiveRightIcon(colors);
    final shouldTintRightIcon = !_usesFixedTypeRightIcon;

    return Column(
      key: const Key('dl_input_wrapper'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          key: const Key('dl_input_tap_area'),
          behavior: HitTestBehavior.translucent,
          onTap: widget.enabled ? () => _focusNode.requestFocus() : null,
          child: Container(
            key: const Key('dl_input_container'),
            padding: EdgeInsets.symmetric(
              horizontal: _horizontalPadding(),
              vertical: _verticalPadding(),
            ),
            decoration: BoxDecoration(
              color: colors.grey.c100,
              borderRadius: BorderRadius.circular(DlRadiusTokens.roundedMd),
              border: Border.all(
                color: _isActive ? colors.black : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                if (widget.iconLeft != null) ...[
                  IconTheme(
                    key: const Key('dl_input_icon_left_theme'),
                    data: IconThemeData(color: colors.grey.c500),
                    child: widget.iconLeft!,
                  ),
                  const SizedBox(width: DlSpacingTokens.p_16),
                ],
                Expanded(child: inputContent),
                if (rightIcon != null) ...[
                  const SizedBox(width: DlSpacingTokens.p_16),
                  if (shouldTintRightIcon)
                    IconTheme(
                      key: const Key('dl_input_icon_right_theme'),
                      data: IconThemeData(color: colors.grey.c500),
                      child: rightIcon,
                    )
                  else
                    rightIcon,
                ],
              ],
            ),
          ),
        ),
        if (showErrorHelper) ...[
          const SizedBox(height: DlSpacingTokens.p_8),
          Text(
            helperText,
            key: const Key('dl_input_error_helper_text'),
            style: DlTextStyles.textSm.medium.copyWith(color: colors.red.c500),
          ),
        ],
      ],
    );
  }

  String? get _errorHelperText {
    if (!_isErrorType) return null;
    return widget.errorHelperText ?? 'Error helper text';
  }

  double _horizontalPadding() {
    switch (widget.size) {
      case DlInputSize.lg:
      case DlInputSize.mg:
        return DlSpacingTokens.p_16;
      case DlInputSize.sm:
        return DlSpacingTokens.p_12;
    }
  }

  double _verticalPadding() {
    if (_showStackedContent) {
      switch (widget.size) {
        case DlInputSize.lg:
          return DlSpacingTokens.p_8;
        case DlInputSize.mg:
          return DlSpacingTokens.p_4;
        case DlInputSize.sm:
          return DlSpacingTokens.p_0;
      }
    }

    switch (widget.size) {
      case DlInputSize.lg:
        return DlSpacingTokens.p_16;
      case DlInputSize.mg:
        return DlSpacingTokens.p_12;
      case DlInputSize.sm:
        return DlSpacingTokens.p_8;
    }
  }

  bool get _usesFixedTypeRightIcon => _isErrorType || _isSuccessType;

  Widget? _effectiveRightIcon(DlColorPalette colors) {
    if (_isErrorType) {
      return DlAssetIcon(
        key: const Key('dl_input_type_icon_error'),
        assetPath: DlIcons.circleAlertAsset,
        color: colors.red.c500,
      );
    }
    if (_isSuccessType) {
      return DlAssetIcon(
        key: const Key('dl_input_type_icon_success'),
        assetPath: DlIcons.circleCheckAsset,
        color: colors.green.c600,
      );
    }
    return widget.iconRight;
  }

  Widget _buildInputContent(DlColorPalette colors) {
    return Column(
      key: const Key('dl_input_active_content'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_showStackedContent)
          Text(
            widget.placeholder,
            key: const Key('dl_input_active_placeholder'),
            style: DlTextStyles.textXs.regular.copyWith(
              color: _placeholderColor(colors),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        _buildTextField(
          colors,
          hintText: _showStackedContent ? null : widget.placeholder,
          hintColor: _placeholderColor(colors),
        ),
      ],
    );
  }

  Color _placeholderColor(DlColorPalette colors) {
    if (!widget.enabled) return colors.grey.c300;
    if (_isErrorType) return colors.red.c500;
    if (_isSuccessType) return colors.green.c500;
    return colors.grey.c500;
  }

  Widget _buildTextField(
    DlColorPalette colors, {
    String? hintText,
    required Color hintColor,
  }) {
    return TextField(
      key: const Key('dl_input_text_field'),
      controller: _controller,
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      onSubmitted: (_) => FocusScope.of(context).unfocus(),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,
      enabled: widget.enabled,
      maxLines: 1,
      cursorColor: colors.black,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      style: DlTextStyles.textBase.regular.copyWith(
        color: colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        hintMaxLines: 1,
        hintStyle: DlTextStyles.textBase.regular.copyWith(
          color: hintColor,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
