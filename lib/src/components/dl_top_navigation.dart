/// DlTopNavigation — Usage rules:
/// - Size MD: Fixed at the top of the screen, above the scrollable content area.
///   Never place inside a ScrollView. Sits directly inside the Column that is
///   the child of SafeArea, before the Expanded scroll area.
/// - Size LG: Not fixed. Placed inside the scrollable content area.
import 'package:flutter/material.dart';

import '../foundations/icons/dl_icons.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import 'dl_button.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';
import 'dl_button_icon.dart';
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
  });

  final String title;
  final bool showSeparator;
  final DlTopNavigationSize size;
  final DlButtonIcon? iconLeft;
  final DlButtonIcon? iconRight;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final effectiveIconLeft = iconLeft ??
        (size == DlTopNavigationSize.md
            ? DlButtonIcon(
                icon: const DlAssetIcon(assetPath: DlIcons.chevronLeftAsset),
                type: DlButtonType.secondary,
                size: DlButtonSize.sm,
                onPressed: () => Navigator.of(context).maybePop(),
              )
            : null);

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
                ? _buildMdContent(colors, effectiveIconLeft)
                : _buildLgContent(colors, effectiveIconLeft),
          ),
          if (showSeparator) const DlSeparator(key: Key('dl_top_navigation_separator')),
        ],
      ),
    );
  }

  Widget _buildMdContent(DlColorPalette colors, DlButtonIcon? effectiveIconLeft) {
    return Row(
      children: [
        _buildIconBox(
          key: const Key('dl_top_navigation_left_icon_box'),
          icon: effectiveIconLeft,
          alignment: Alignment.centerRight,
        ),
        const SizedBox(width: DlSpacingTokens.p_16),
        Expanded(
          child: Text(
            title,
            key: const Key('dl_top_navigation_title'),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: DlTextStyles.textBase.bold.copyWith(color: colors.black),
          ),
        ),
        const SizedBox(width: DlSpacingTokens.p_16),
        _buildIconBox(
          key: const Key('dl_top_navigation_right_icon_box'),
          icon: iconRight,
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Widget _buildLgContent(DlColorPalette colors, DlButtonIcon? effectiveIconLeft) {
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
            icon: effectiveIconLeft,
            alignment: Alignment.centerLeft,
          ),
          _buildIconBox(
            key: const Key('dl_top_navigation_right_icon_box'),
            icon: iconRight,
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }

  Widget _buildIconBox({
    required Key key,
    required DlButtonIcon? icon,
    required Alignment alignment,
  }) {
    return SizedBox(
      key: key,
      width: 56,
      height: 56,
      child: Align(
        alignment: alignment,
        child: icon ??
            const SizedBox.shrink(
              key: ValueKey('dl_top_navigation_icon_empty'),
            ),
      ),
    );
  }
}
