/// DlLineItemMessage — Usage rules:
/// - A full-width list row for message/chat overviews. Shows an avatar on the
///   left, title and time on the top right, and a message preview below.
/// - Use for message inbox or conversation list screens. Each row represents
///   one conversation. Tap the row to open the chat (handle via parent).
/// - title (contact name), time, and message (preview text) are required.
/// - avatar is optional — falls back to a default DlAvatar.
/// - States: defaultState (read message), newState (unread — bold message text,
///   badge shown), disabled (greyed out).
/// - In newState, a badge (e.g. DlBadge) appears next to the message preview
///   to indicate unread messages.
/// - showSeparator: true (default) adds a DlSeparator below the row. Set to
///   false for the last item in the list.
/// - Message preview is limited to 2 lines with ellipsis overflow.
import 'package:flutter/material.dart';

import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';
import 'dl_avatar.dart';
import 'dl_badge.dart';
import 'dl_separator.dart';

enum DlLineItemMessageState { defaultState, newState, disabled }

class DlLineItemMessage extends StatelessWidget {
  const DlLineItemMessage({
    required this.title,
    required this.time,
    required this.message,
    super.key,
    this.state = DlLineItemMessageState.defaultState,
    this.avatar,
    this.badge,
    this.showSeparator = true,
  });

  final String title;
  final String time;
  final String message;
  final DlLineItemMessageState state;
  final Widget? avatar;
  final Widget? badge;
  final bool showSeparator;

  bool get _isNew => state == DlLineItemMessageState.newState;
  bool get _isDisabled => state == DlLineItemMessageState.disabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    final titleStyle = (_isDisabled
            ? DlTextStyles.textBase.regular
            : DlTextStyles.textBase.semiBold)
        .copyWith(color: _isDisabled ? colors.grey.c500 : colors.black);
    final timeStyle = DlTextStyles.textBase.regular.copyWith(color: colors.grey.c500);
    final messageStyle = (_isDisabled
            ? DlTextStyles.textBase.regular
            : (_isNew ? DlTextStyles.textBase.semiBold : DlTextStyles.textBase.regular))
        .copyWith(color: _isDisabled ? colors.grey.c500 : (_isNew ? colors.black : colors.grey.c500));

    return Column(
      key: const Key('dl_line_item_message'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          key: const Key('dl_line_item_message_padding'),
          padding: const EdgeInsets.symmetric(vertical: DlSpacingTokens.p_16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KeyedSubtree(
                key: const Key('dl_line_item_message_avatar'),
                child:
                    avatar ?? const DlAvatar(size: DlAvatarSize.lg, type: DlAvatarType.icon),
              ),
              const SizedBox(width: DlSpacingTokens.p_16),
              Expanded(
                child: Column(
                  key: const Key('dl_line_item_message_text_box'),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      key: const Key('dl_line_item_message_header_row'),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            key: const Key('dl_line_item_message_title'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: titleStyle,
                          ),
                        ),
                        const SizedBox(width: DlSpacingTokens.p_8),
                        Text(
                          time,
                          key: const Key('dl_line_item_message_time'),
                          style: timeStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: DlSpacingTokens.p_4),
                    if (_isNew)
                      Row(
                        key: const Key('dl_line_item_message_new_row'),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              message,
                              key: const Key('dl_line_item_message_body'),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: messageStyle,
                            ),
                          ),
                          const SizedBox(width: DlSpacingTokens.p_16),
                          KeyedSubtree(
                            key: const Key('dl_line_item_message_badge'),
                            child: badge ?? const DlBadge(),
                          ),
                        ],
                      )
                    else
                      Text(
                        message,
                        key: const Key('dl_line_item_message_body'),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: messageStyle,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showSeparator) const DlSeparator(key: Key('dl_line_item_message_separator')),
      ],
    );
  }
}
