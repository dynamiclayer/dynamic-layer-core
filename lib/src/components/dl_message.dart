import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlMessageType { message, ownMessage }

enum DlMessageState { single, response }

class DlMessage extends StatelessWidget {
  const DlMessage({
    required this.message,
    super.key,
    this.type = DlMessageType.message,
    this.state = DlMessageState.single,
    this.author,
    this.responseTitle,
    this.responseMessage,
  }) : assert(
         state != DlMessageState.response ||
             (responseTitle != null && responseMessage != null),
         'responseTitle and responseMessage are required for response state.',
       );

  final DlMessageType type;
  final DlMessageState state;
  final String? author;
  final String message;
  final String? responseTitle;
  final String? responseMessage;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final isOwnMessage = type == DlMessageType.ownMessage;
    final isResponse = state == DlMessageState.response;
    final hasAuthor = !isOwnMessage && author != null && author!.isNotEmpty;

    return ConstrainedBox(
      key: const Key('dl_message_constraints'),
      constraints: const BoxConstraints(maxWidth: 240),
      child: Container(
        key: const Key('dl_message_container'),
        padding: const EdgeInsets.all(DlSpacingTokens.p_12),
        decoration: BoxDecoration(
          color: isOwnMessage ? colors.grey.c800 : colors.grey.c100,
          borderRadius: BorderRadius.circular(DlRadiusTokens.roundedMd),
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
            if (!isOwnMessage && isResponse) ...[
              if (hasAuthor) const SizedBox(height: DlSpacingTokens.p_4),
              _buildResponseBox(colors, isOwnMessage: false),
              const SizedBox(height: DlSpacingTokens.p_4),
            ],
            if (isOwnMessage && isResponse) ...[
              _buildResponseBox(colors, isOwnMessage: true),
              const SizedBox(height: DlSpacingTokens.p_4),
            ],
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

  Widget _buildResponseBox(
    DlColorPalette colors, {
    required bool isOwnMessage,
  }) {
    return Container(
      key: const Key('dl_message_response_box'),
      width: double.infinity,
      padding: const EdgeInsets.all(DlSpacingTokens.p_12),
      decoration: BoxDecoration(
        color: isOwnMessage ? colors.grey.c700 : colors.grey.c200,
        borderRadius: BorderRadius.circular(DlRadiusTokens.rounded),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            responseTitle!,
            key: const Key('dl_message_response_title'),
            style: DlTextStyles.textXs.semiBold.copyWith(
              color: isOwnMessage ? colors.white : colors.black,
            ),
          ),
          Text(
            responseMessage!,
            key: const Key('dl_message_response_text'),
            style: DlTextStyles.textXs.regular.copyWith(
              color: isOwnMessage ? colors.white : colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
