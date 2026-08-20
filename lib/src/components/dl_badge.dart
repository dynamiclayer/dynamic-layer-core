/// DlBadge — Usage rules:
/// - Small notification indicator. Use to show unread counts or draw attention
///   to an element (e.g. on icons, navigation items, avatars).
/// - Size sm: A red dot (8px) with no text — use to indicate "something new"
///   without a count.
/// - Size md (default): A red pill with a text value — use to show a count
///   (e.g. "3", "99+"). Keep the value short.
/// - Always position the badge relative to its parent using a Stack with
///   Positioned (e.g. top-right corner of an icon or avatar).
/// - Do not use as a standalone element — it always belongs to another component.
import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlBadgeSize { sm, md }

class DlBadge extends StatelessWidget {
  const DlBadge({super.key, this.size = DlBadgeSize.md, this.value = '1'});

  final DlBadgeSize size;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    switch (size) {
      case DlBadgeSize.sm:
        return DecoratedBox(
          key: const Key('dl_badge_sm_dot'),
          decoration: BoxDecoration(
            color: colors.red.c500,
            borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
          ),
          child: const SizedBox(width: 8, height: 8),
        );
      case DlBadgeSize.md:
        return IntrinsicWidth(
          child: Container(
            key: const Key('dl_badge_md_container'),
            constraints: const BoxConstraints(minWidth: 16),
            padding: const EdgeInsets.symmetric(
              horizontal: DlSpacingTokens.p_4,
            ),
            decoration: BoxDecoration(
              color: colors.red.c500,
              borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
            ),
            alignment: Alignment.center,
            child: Text(
              value,
              key: const Key('dl_badge_md_text'),
              style: DlTextStyles.textXs.semiBold.copyWith(color: Colors.white),
              maxLines: 1,
              softWrap: false,
            ),
          ),
        );
    }
  }
}
