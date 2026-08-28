/// DlInput — Usage rules:
/// - Always takes the full width of its parent container.
/// - Use type: DlInputType.error with errorHelperText to show validation errors.
///   The error icon and helper text appear automatically.
/// - Use type: DlInputType.success for validated fields. The success icon appears
///   automatically.
/// - When the input has text, a clear (X) icon appears on the far right to
///   delete the entered value. This applies to all types including error and
///   success — the type icon sits to the left of the clear icon with p_8 gap.
/// - When type is error or success, the right icon is overridden by the type icon.
///   A custom iconRight is only visible in defaultType and phone.
/// - Sizes: lg (default), md, sm. When used alongside a DlButton in the same
///   container, prefer matching sizes.
/// - Set enabled: false to disable the input. Do not use for read-only display —
///   disabled means the user cannot interact with it.
/// - Use obscureText: true for password fields.
/// - Use type: DlInputType.phone for phone number fields. A DlTag (md, dark)
///   appears on the left showing the country code (default "DE +49"). Tap the
///   tag to open a country picker. The keyboard type is automatically set to
///   phone.
/// - The placeholder text moves above the input value when focused or filled.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundations/icons/dl_icons.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';
import 'dl_tag.dart';

enum DlInputType { defaultType, error, success, phone }

enum DlInputSize { lg, md, sm }

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
    this.phoneTagLabel = 'DE +49',
    this.onPhoneTagPressed,
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
  final String phoneTagLabel;
  final VoidCallback? onPhoneTagPressed;

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
  bool get _isPhoneType => widget.type == DlInputType.phone;

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
    final rightIcons = _buildRightIcons(colors);

    return Column(
      key: const Key('dl_input_wrapper'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFieldTapRegion(
          child: GestureDetector(
            key: const Key('dl_input_tap_area'),
            behavior: HitTestBehavior.translucent,
            onTap: widget.enabled ? () => _focusNode.requestFocus() : null,
            child: Container(
              key: const Key('dl_input_container'),
              padding: EdgeInsets.only(
                left: _paddingLeft(),
                right: _paddingRight(),
                top: _verticalPadding(),
                bottom: _verticalPadding(),
              ),
              decoration: BoxDecoration(
                color: colors.grey.c100,
                borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
                border: Border.all(
                  color: _isActive ? colors.black : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  if (_isPhoneType) ...[
                    GestureDetector(
                      key: const Key('dl_input_phone_tag_tap'),
                      onTap: widget.enabled
                          ? () {
                              HapticFeedback.mediumImpact();
                              widget.onPhoneTagPressed?.call();
                            }
                          : null,
                      child: DlTag(
                        key: const Key('dl_input_phone_tag'),
                        label: widget.phoneTagLabel,
                        size: DlTagSize.md,
                        mode: DlTagMode.dark,
                      ),
                    ),
                    const SizedBox(width: DlSpacingTokens.p_8),
                  ] else if (widget.iconLeft != null) ...[
                    IconTheme(
                      key: const Key('dl_input_icon_left_theme'),
                      data: IconThemeData(color: colors.grey.c500),
                      child: widget.iconLeft!,
                    ),
                    const SizedBox(width: DlSpacingTokens.p_8),
                  ],
                  Expanded(child: inputContent),
                  ...rightIcons,
                ],
              ),
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

  double _paddingLeft() {
    if (_isPhoneType) return DlSpacingTokens.p_16;
    switch (widget.size) {
      case DlInputSize.lg:
      case DlInputSize.md:
        return DlSpacingTokens.p_24;
      case DlInputSize.sm:
        return DlSpacingTokens.p_16;
    }
  }

  double _paddingRight() {
    switch (widget.size) {
      case DlInputSize.lg:
      case DlInputSize.md:
        return DlSpacingTokens.p_24;
      case DlInputSize.sm:
        return DlSpacingTokens.p_16;
    }
  }

  double _verticalPadding() {
    if (_showStackedContent) {
      switch (widget.size) {
        case DlInputSize.lg:
          return DlSpacingTokens.p_8;
        case DlInputSize.md:
          return DlSpacingTokens.p_4;
        case DlInputSize.sm:
          return DlSpacingTokens.p_0;
      }
    }

    switch (widget.size) {
      case DlInputSize.lg:
        return DlSpacingTokens.p_16;
      case DlInputSize.md:
        return DlSpacingTokens.p_12;
      case DlInputSize.sm:
        return DlSpacingTokens.p_8;
    }
  }

  bool get _showClearIcon => _isFilled && _isActive;

  List<Widget> _buildRightIcons(DlColorPalette colors) {
    final icons = <Widget>[];

    if (_isErrorType) {
      icons.add(DlAssetIcon(
        key: const Key('dl_input_type_icon_error'),
        assetPath: DlIcons.circleAlertFilledAsset,
        color: colors.red.c500,
      ));
    } else if (_isSuccessType) {
      icons.add(DlAssetIcon(
        key: const Key('dl_input_type_icon_success'),
        assetPath: DlIcons.circleCheckFilledAsset,
        color: colors.green.c600,
      ));
    } else if (widget.iconRight != null) {
      icons.add(IconTheme(
        key: const Key('dl_input_icon_right_theme'),
        data: IconThemeData(color: colors.grey.c500),
        child: widget.iconRight!,
      ));
    }

    if (_showClearIcon) {
      icons.add(GestureDetector(
        key: const Key('dl_input_clear_icon_tap'),
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _controller.clear();
          widget.onChanged?.call('');
        },
        child: DlAssetIcon(
          key: const Key('dl_input_clear_icon'),
          assetPath: DlIcons.xAsset,
          color: colors.grey.c500,
        ),
      ));
    }

    if (icons.isEmpty) return [];

    final result = <Widget>[const SizedBox(width: DlSpacingTokens.p_8)];
    for (var i = 0; i < icons.length; i++) {
      if (i > 0) result.add(const SizedBox(width: DlSpacingTokens.p_8));
      result.add(icons[i]);
    }
    return result;
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
      keyboardType: _isPhoneType ? TextInputType.phone : widget.keyboardType,
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
