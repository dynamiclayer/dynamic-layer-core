import 'package:flutter/material.dart';

import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';
import 'dl_avatar.dart';
import 'dl_separator.dart';

class DlTopNavigationMessage extends StatelessWidget {
  const DlTopNavigationMessage({
    required this.title,
    super.key,
    this.showSeparator = true,
    this.iconLeft,
    this.iconRight,
    this.onIconLeftTap,
    this.onIconRightTap,
    this.avatar,
  });

  final String title;
  final bool showSeparator;
  final Widget? iconLeft;
  final Widget? iconRight;
  final VoidCallback? onIconLeftTap;
  final VoidCallback? onIconRightTap;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return Container(
      key: const Key('dl_top_navigation_message'),
      width: double.infinity,
      color: colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            key: const Key('dl_top_navigation_message_content'),
            color: colors.white,
            child: Row(
              children: [
                _buildIconBox(
                  key: const Key('dl_top_navigation_message_left_icon_box'),
                  tapKey: const Key('dl_top_navigation_message_left_icon_tap'),
                  iconKey: const Key('dl_top_navigation_message_left_icon'),
                  color: colors.black,
                  icon: iconLeft,
                  onTap: onIconLeftTap,
                ),
                Expanded(
                  child: Row(
                    key: const Key('dl_top_navigation_message_center'),
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      KeyedSubtree(
                        key: const Key('dl_top_navigation_message_avatar'),
                        child: avatar ?? const DlAvatar(size: DlAvatarSize.xs),
                      ),
                      const SizedBox(width: DlSpacingTokens.p_16),
                      Expanded(
                        child: Text(
                          title,
                          key: const Key('dl_top_navigation_message_title'),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: DlTextStyles.textBase.semiBold.copyWith(
                            color: colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildIconBox(
                  key: const Key('dl_top_navigation_message_right_icon_box'),
                  tapKey: const Key('dl_top_navigation_message_right_icon_tap'),
                  iconKey: const Key('dl_top_navigation_message_right_icon'),
                  color: colors.black,
                  icon: iconRight,
                  onTap: onIconRightTap,
                ),
              ],
            ),
          ),
          if (showSeparator)
            const DlSeparator(key: Key('dl_top_navigation_message_separator')),
        ],
      ),
    );
  }

  Widget _buildIconBox({
    required Key key,
    required Key tapKey,
    required Key iconKey,
    required Color color,
    required Widget? icon,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      key: tapKey,
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: SizedBox(
        key: key,
        width: 56,
        height: 56,
        child: Center(
          child: icon == null
              ? const SizedBox.shrink(
                  key: ValueKey('dl_top_navigation_message_icon_empty'),
                )
              : IconTheme(
                  data: IconThemeData(color: color),
                  child: KeyedSubtree(
                    key: iconKey,
                    child: icon,
                  ),
                ),
        ),
      ),
    );
  }
}
