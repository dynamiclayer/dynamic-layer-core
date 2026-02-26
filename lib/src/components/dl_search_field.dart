import 'package:flutter/material.dart';

import '../foundations/icons/dl_icons.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlSearchFieldSize { lg, md, sm }

class DlSearchField extends StatefulWidget {
  const DlSearchField({
    required this.placeholder,
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.enabled = true,
    this.size = DlSearchFieldSize.lg,
  });

  final String placeholder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool enabled;
  final DlSearchFieldSize size;

  @override
  State<DlSearchField> createState() => _DlSearchFieldState();
}

class _DlSearchFieldState extends State<DlSearchField> {
  FocusNode? _internalFocusNode;
  TextEditingController? _internalController;

  FocusNode get _focusNode => widget.focusNode ?? _internalFocusNode!;
  TextEditingController get _controller => widget.controller ?? _internalController!;

  bool get _isActive => widget.enabled && _focusNode.hasFocus;
  bool get _showClearIcon => widget.enabled && _controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode == null ? FocusNode() : null;
    _internalController =
        widget.controller == null ? TextEditingController() : null;
    _focusNode.addListener(_handleFocusChanged);
    _controller.addListener(_handleTextChanged);
  }

  @override
  void didUpdateWidget(covariant DlSearchField oldWidget) {
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
      _internalController =
          widget.controller == null ? TextEditingController() : null;
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

    return GestureDetector(
      key: const Key('dl_search_field_tap_area'),
      behavior: HitTestBehavior.translucent,
      onTap: widget.enabled ? () => _focusNode.requestFocus() : null,
      child: Container(
        key: const Key('dl_search_field_container'),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: DlSpacingTokens.p_16,
          vertical: _verticalPadding(),
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
            DlAssetIcon(
              key: const Key('dl_search_field_icon'),
              assetPath: DlIcons.searchAsset,
              color: widget.enabled ? colors.grey.c500 : colors.grey.c300,
            ),
            const SizedBox(width: DlSpacingTokens.p_16),
            Expanded(
              child: TextField(
                key: const Key('dl_search_field_text_field'),
                controller: _controller,
                focusNode: _focusNode,
                onChanged: widget.onChanged,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                enabled: widget.enabled,
                maxLines: 1,
                cursorColor: colors.black,
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
                  hintText: widget.placeholder,
                  hintMaxLines: 1,
                  hintStyle: DlTextStyles.textBase.regular.copyWith(
                    color: widget.enabled ? colors.grey.c500 : colors.grey.c300,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            if (_showClearIcon) ...[
              const SizedBox(width: DlSpacingTokens.p_16),
              GestureDetector(
                key: const Key('dl_search_field_clear_icon_tap'),
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _controller.clear();
                  widget.onChanged?.call('');
                },
                child: DlAssetIcon(
                  key: const Key('dl_search_field_clear_icon'),
                  assetPath: DlIcons.xAsset,
                  color: colors.grey.c500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  double _verticalPadding() {
    switch (widget.size) {
      case DlSearchFieldSize.lg:
        return DlSpacingTokens.p_16;
      case DlSearchFieldSize.md:
        return DlSpacingTokens.p_12;
      case DlSearchFieldSize.sm:
        return DlSpacingTokens.p_8;
    }
  }
}
