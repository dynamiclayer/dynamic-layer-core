/// DlMessage — Usage rules:
/// - A chat message bubble with a max width of 240px. Use inside a chat/message
///   screen together with DlTopNavigation and DlMessageDock.
/// - Type message: Received message (grey background, left-aligned). Use
///   Align(alignment: Alignment.centerLeft) to position it.
/// - Type ownMessage: Sent message (dark background, white text, right-aligned).
///   Use Align(alignment: Alignment.centerRight) to position it.
/// - author is optional — shown above received messages for group chats.
///   Not shown for ownMessage.
/// - Place messages in a vertical list inside the scrollable content area.
import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlMessageType { message, ownMessage }

class DlMessage extends StatelessWidget {
  const DlMessage({
    required this.message,
    super.key,
    this.type = DlMessageType.message,
    this.author,
  });

  final DlMessageType type;
  final String? author;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final isOwnMessage = type == DlMessageType.ownMessage;
    final hasAuthor = !isOwnMessage && author != null && author!.isNotEmpty;

    return ConstrainedBox(
      key: const Key('dl_message_constraints'),
      constraints: const BoxConstraints(maxWidth: 240),
      child: Container(
        key: const Key('dl_message_container'),
        padding: const EdgeInsets.all(DlSpacingTokens.p_12),
        decoration: BoxDecoration(
          color: isOwnMessage ? colors.blue.c600 : colors.grey.c100,
          borderRadius: BorderRadius.circular(DlRadiusTokens.roundedXl),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasAuthor)
              Text(
                author!,
                key: const Key('dl_message_author'),
                style: DlTextStyles.textBase.semiBold.copyWith(
                  color: colors.black,
                ),
              ),
            Text(
              message,
              key: const Key('dl_message_text'),
              style: DlTextStyles.textBase.regular.copyWith(
                color: isOwnMessage ? colors.white : colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
