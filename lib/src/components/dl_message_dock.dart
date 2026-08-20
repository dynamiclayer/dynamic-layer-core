/// DlMessageDock — Usage rules:
/// - A message input bar fixed at the bottom of a chat screen, below the
///   scrollable message list. Never place inside a ScrollView. Sits directly
///   inside the Column that is the child of SafeArea, after the Expanded
///   scroll area.
/// - Contains a plus icon button on the left, a text input in the center,
///   and a send button that appears when text is entered.
/// - Use together with DlTopNavigation (top) and DlMessage (content).
/// - onSend fires with the message text when the send button is tapped.
///   clearOnSend: true (default) clears the input after sending.
/// - showSeparator: true (default) adds a DlSeparator above the dock.
/// - The text input grows vertically for multi-line messages.
/// - Set enabled: false to disable input. Set isSending: true to block
///   sending while a message is being processed.
import 'package:flutter/material.dart';

import '../foundations/icons/dl_icons.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';
import 'dl_button.dart';
import 'dl_button_icon.dart';
import 'dl_separator.dart';

class DlMessageDock extends StatefulWidget {
  const DlMessageDock({
    super.key,
    this.showSeparator = true,
    this.placeholder = 'Type a message',
    this.onIconPressed,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.enabled = true,
    this.onActionPressed,
    this.onSend,
    this.clearOnSend = true,
    this.isSending = false,
  });

  final bool showSeparator;
  final String placeholder;
  final VoidCallback? onIconPressed;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final VoidCallback? onActionPressed;
  final ValueChanged<String>? onSend;
  final bool clearOnSend;
  final bool isSending;

  @override
  State<DlMessageDock> createState() => _DlMessageDockState();
}

class _DlMessageDockState extends State<DlMessageDock> {
  FocusNode? _internalFocusNode;
  TextEditingController? _internalController;
  bool _isActionPressedByGesture = false;

  FocusNode get _focusNode => widget.focusNode ?? _internalFocusNode!;
  TextEditingController get _controller => widget.controller ?? _internalController!;
  bool get _showActionButton => _controller.text.trim().isNotEmpty;
  bool get _canSend => widget.enabled && !widget.isSending && _showActionButton;
  VoidCallback get _effectiveLeftAction => widget.onIconPressed ?? _noop;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode == null ? FocusNode() : null;
    _internalController =
        widget.controller == null ? TextEditingController() : null;
    _controller.addListener(_handleTextChanged);
  }

  @override
  void didUpdateWidget(covariant DlMessageDock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      if (oldWidget.focusNode == null) {
        _internalFocusNode?.dispose();
        _internalFocusNode = null;
      }
      _internalFocusNode = widget.focusNode == null ? FocusNode() : null;
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
    _controller.removeListener(_handleTextChanged);
    _internalFocusNode?.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return Container(
      key: const Key('dl_message_dock'),
      width: double.infinity,
      color: colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.showSeparator) const DlSeparator(key: Key('dl_message_dock_separator')),
          Padding(
            padding: const EdgeInsets.all(DlSpacingTokens.p_16),
            child: TextFieldTapRegion(
              child: Row(
              key: const Key('dl_message_dock_content'),
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DlButtonIcon(
                  key: const Key('dl_message_dock_icon_button'),
                  type: DlButtonType.secondary,
                  size: DlButtonSize.md,
                  icon: const DlAssetIcon(assetPath: DlIcons.plusAsset),
                  onPressed: _effectiveLeftAction,
                ),
                const SizedBox(width: DlSpacingTokens.p_8),
                Expanded(
                  child: Container(
                    key: const Key('dl_message_dock_input_container'),
                    decoration: BoxDecoration(
                      color: colors.grey.c100,
                      borderRadius: BorderRadius.circular(DlRadiusTokens.rounded3Xl),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Padding(
                            key: const Key('dl_message_dock_input_text_box'),
                            padding: const EdgeInsets.fromLTRB(DlSpacingTokens.p_16, DlSpacingTokens.p_12, DlSpacingTokens.p_12, DlSpacingTokens.p_12),
                            child: TextField(
                              key: const Key('dl_message_dock_input'),
                              controller: _controller,
                              focusNode: _focusNode,
                              onChanged: widget.onChanged,
                              onTapOutside: (_) => FocusScope.of(context).unfocus(),
                              enabled: widget.enabled,
                              minLines: 1,
                              maxLines: 8,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              cursorColor: colors.black,
                              style: DlTextStyles.textBase.regular.copyWith(
                                color: colors.black,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                hintText: widget.placeholder,
                                hintStyle: DlTextStyles.textBase.regular.copyWith(
                                  color: colors.grey.c500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (_showActionButton)
                          GestureDetector(
                            key: const Key('dl_message_dock_action_box'),
                            behavior: HitTestBehavior.translucent,
                            onTapDown: _canSend ? (_) => _setActionPressedByGesture(true) : null,
                            onTapUp: _canSend ? (_) => _setActionPressedByGesture(false) : null,
                            onTapCancel: _canSend ? () => _setActionPressedByGesture(false) : null,
                            onTap: _canSend ? _handleSend : null,
                            child: SizedBox(
                              width: 48,
                              height: 48,
                              child: Center(
                                child: IgnorePointer(
                                  child: DlButtonIcon(
                                    key: const Key('dl_message_dock_action_button'),
                                    type: DlButtonType.primary,
                                    size: DlButtonSize.xs,
                                    state: _isActionPressedByGesture
                                        ? DlButtonState.pressed
                                        : DlButtonState.defaultState,
                                    icon: const DlAssetIcon(assetPath: DlIcons.arrowUpAsset),
                                    onPressed: _canSend ? _handleSend : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ),
          ),
        ],
      ),
    );
  }

  void _setActionPressedByGesture(bool value) {
    if (_isActionPressedByGesture == value) return;
    setState(() => _isActionPressedByGesture = value);
  }

  void _handleSend() {
    final textToSend = _controller.text.trim();
    if (textToSend.isEmpty) return;
    widget.onSend?.call(textToSend);
    widget.onActionPressed?.call();
    if (widget.clearOnSend) {
      _controller.clear();
    }
  }

  static void _noop() {}
}
