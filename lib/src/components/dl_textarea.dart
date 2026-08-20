/// DlTextarea — Usage rules:
/// - Multi-line text input with a fixed height of 132px. Content scrolls
///   vertically when it exceeds the visible area.
/// - Always takes the full width of its parent container.
/// - Use for longer text input (e.g. comments, descriptions, messages).
///   For single-line input, use DlInput instead.
/// - Has no type or size variants — one consistent appearance.
/// - Set enabled: false to disable. The placeholder color changes to indicate
///   the disabled state.
import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

class DlTextarea extends StatefulWidget {
  const DlTextarea({
    required this.placeholder,
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.enabled = true,
  });

  final String placeholder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  @override
  State<DlTextarea> createState() => _DlTextareaState();
}

class _DlTextareaState extends State<DlTextarea> {
  FocusNode? _internalFocusNode;
  TextEditingController? _internalController;
  late final ScrollController _scrollController;
  double _scrollOffset = 0;

  FocusNode get _focusNode => widget.focusNode ?? _internalFocusNode!;
  TextEditingController get _controller => widget.controller ?? _internalController!;
  bool get _isActive => widget.enabled && _focusNode.hasFocus;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode == null ? FocusNode() : null;
    _internalController =
        widget.controller == null ? TextEditingController() : null;
    _scrollController = ScrollController()..addListener(_handleScrollChanged);
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(covariant DlTextarea oldWidget) {
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
      if (oldWidget.controller == null) {
        _internalController?.dispose();
        _internalController = null;
      }
      _internalController =
          widget.controller == null ? TextEditingController() : null;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScrollChanged);
    _scrollController.dispose();
    _focusNode.removeListener(_handleFocusChanged);
    _internalFocusNode?.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  void _handleFocusChanged() {
    if (mounted) setState(() {});
  }

  void _handleScrollChanged() {
    final nextOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;
    if ((nextOffset - _scrollOffset).abs() < 0.01) return;
    if (mounted) {
      setState(() => _scrollOffset = nextOffset);
    } else {
      _scrollOffset = nextOffset;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return GestureDetector(
      key: const Key('dl_textarea_tap_area'),
      behavior: HitTestBehavior.translucent,
      onTap: widget.enabled ? () => _focusNode.requestFocus() : null,
      child: Container(
        key: const Key('dl_textarea_container'),
        width: double.infinity,
        height: 132,
        decoration: BoxDecoration(
          color: colors.grey.c100,
          borderRadius: BorderRadius.circular(DlRadiusTokens.roundedMd),
          border: Border.all(
            color: _isActive ? colors.black : Colors.transparent,
            width: 2,
          ),
        ),
        child: TextField(
          key: const Key('dl_textarea_field'),
          controller: _controller,
          focusNode: _focusNode,
          scrollController: _scrollController,
          onChanged: widget.onChanged,
          onSubmitted: (_) => FocusScope.of(context).unfocus(),
          textInputAction: TextInputAction.done,
          enabled: widget.enabled,
          maxLines: null,
          expands: true,
          cursorColor: colors.black,
          textAlignVertical: TextAlignVertical.top,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          style: DlTextStyles.textBase.regular.copyWith(color: colors.black),
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(
              left: DlSpacingTokens.p_16,
              right: DlSpacingTokens.p_16,
              top: (DlSpacingTokens.p_16 - _scrollOffset).clamp(
                0.0,
                DlSpacingTokens.p_16,
              ).toDouble(),
            ),
            hintText: widget.placeholder,
            hintStyle: DlTextStyles.textBase.regular.copyWith(
              color: widget.enabled ? colors.grey.c500 : colors.grey.c300,
            ),
          ),
        ),
      ),
    );
  }
}
