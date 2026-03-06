import 'package:flutter/material.dart';

import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';
import 'dl_separator.dart';

enum DlTopNavigationSize { md, lg }

class DlTopNavigation extends StatelessWidget {
  const DlTopNavigation({
    required this.title,
    super.key,
    this.showSeparator = true,
    this.size = DlTopNavigationSize.md,
    this.iconLeft,
    this.iconRight,
    this.onIconLeftTap,
    this.onIconRightTap,
  });

  final String title;
  final bool showSeparator;
  final DlTopNavigationSize size;
  final Widget? iconLeft;
  final Widget? iconRight;
  final VoidCallback? onIconLeftTap;
  final VoidCallback? onIconRightTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return Container(
      key: const Key('dl_top_navigation'),
      width: double.infinity,
      color: size == DlTopNavigationSize.md ? colors.white : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            key: const Key('dl_top_navigation_content'),
            color: size == DlTopNavigationSize.md ? colors.white : null,
            child: size == DlTopNavigationSize.md
                ? _buildMdContent(colors)
                : _buildLgContent(colors),
          ),
          if (showSeparator) const DlSeparator(key: Key('dl_top_navigation_separator')),
        ],
      ),
    );
  }

  Widget _buildMdContent(DlColorPalette colors) {
    return Row(
      children: [
        _buildIconBox(
          key: const Key('dl_top_navigation_left_icon_box'),
          tapKey: const Key('dl_top_navigation_left_icon_tap'),
          iconKey: const Key('dl_top_navigation_left_icon'),
          color: colors.black,
          icon: iconLeft,
          onTap: onIconLeftTap,
        ),
        const SizedBox(width: DlSpacingTokens.p_16),
        Expanded(
          child: Text(
            title,
            key: const Key('dl_top_navigation_title'),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: DlTextStyles.textBase.semiBold.copyWith(color: colors.black),
          ),
        ),
        const SizedBox(width: DlSpacingTokens.p_16),
        _buildIconBox(
          key: const Key('dl_top_navigation_right_icon_box'),
          tapKey: const Key('dl_top_navigation_right_icon_tap'),
          iconKey: const Key('dl_top_navigation_right_icon'),
          color: colors.black,
          icon: iconRight,
          onTap: onIconRightTap,
        ),
      ],
    );
  }

  Widget _buildLgContent(DlColorPalette colors) {
    return Padding(
      key: const Key('dl_top_navigation_lg_padding'),
      padding: const EdgeInsets.symmetric(vertical: DlSpacingTokens.p_16),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              key: const Key('dl_top_navigation_title_wrapper'),
              padding: const EdgeInsets.symmetric(horizontal: DlSpacingTokens.p_16),
              child: Text(
                title,
                key: const Key('dl_top_navigation_title'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: DlTextStyles.text4Xl.bold.copyWith(color: colors.black),
              ),
            ),
          ),
          const SizedBox(width: DlSpacingTokens.p_16),
          _buildIconBox(
            key: const Key('dl_top_navigation_left_icon_box'),
            tapKey: const Key('dl_top_navigation_left_icon_tap'),
            iconKey: const Key('dl_top_navigation_left_icon'),
            color: colors.black,
            icon: iconLeft,
            onTap: onIconLeftTap,
          ),
          _buildIconBox(
            key: const Key('dl_top_navigation_right_icon_box'),
            tapKey: const Key('dl_top_navigation_right_icon_tap'),
            iconKey: const Key('dl_top_navigation_right_icon'),
            color: colors.black,
            icon: iconRight,
            onTap: onIconRightTap,
          ),
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
              ? const SizedBox.shrink(key: ValueKey('dl_top_navigation_icon_empty'))
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
