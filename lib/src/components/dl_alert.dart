/// DlAlert — Usage rules:
/// - An inline alert banner with icon, title, and optional description. Always
///   takes the full width of its parent container.
/// - Use for persistent, contextual messages within the page content (e.g.
///   form validation summary, important notices). Place inside the scrollable
///   content area.
/// - Unlike DlSnackbar (temporary overlay), DlAlert is part of the page layout.
/// - Variants: defaultVariant (grey, customizable icon via iconLeft),
///   info (violet), success (green), warning (yellow), error (red).
///   The icon and background color are set automatically by variant.
/// - description is optional — use for additional detail below the title.
/// - The entire alert is tappable. onTap is optional.
/// - A chevron-right icon on the right indicates the alert is actionable.
/// - No size variants — one consistent appearance.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../foundations/icons/dl_icons.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlAlertVariant { defaultVariant, info, success, warning, error }

class DlAlert extends StatelessWidget {
  const DlAlert({
    required this.title,
    this.description,
    super.key,
    this.variant = DlAlertVariant.info,
    this.onTap,
    this.iconLeft,
  });

  final String title;
  final String? description;
  final DlAlertVariant variant;
  final VoidCallback? onTap;
  final Widget? iconLeft;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap?.call();
      },
      child: Container(
        key: const Key('dl_alert_container'),
        width: double.infinity,
        decoration: BoxDecoration(
          color: _backgroundColorForVariant(
              colors, variant, Theme.of(context).brightness),
          borderRadius: BorderRadius.circular(DlRadiusTokens.roundedLg),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                key: const Key('dl_alert_left_block'),
                padding: const EdgeInsets.all(DlSpacingTokens.p_16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (variant == DlAlertVariant.defaultVariant)
                      iconLeft ??
                          DlPlaceholderIcon(
                            key: const Key('dl_alert_variant_icon'),
                            color: colors.black,
                          )
                    else
                      DlAssetIcon(
                        key: const Key('dl_alert_variant_icon'),
                        assetPath: _assetForVariant(variant),
                        color: _iconColorForVariant(colors, variant),
                      ),
                    const SizedBox(width: DlSpacingTokens.p_16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            key: const Key('dl_alert_title'),
                            style: DlTextStyles.textBase.semiBold
                                .copyWith(color: colors.black),
                          ),
                          if (description != null &&
                              description!.isNotEmpty) ...[
                            const SizedBox(height: DlSpacingTokens.p_4),
                            Text(
                              description!,
                              key: const Key('dl_alert_description'),
                              style: DlTextStyles.textBase.regular
                                  .copyWith(color: colors.black),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              key: const Key('dl_alert_chevron_block'),
              padding: const EdgeInsets.all(DlSpacingTokens.p_16),
              child: SizedBox.square(
                dimension: 24,
                child: Center(
                  child: DlAssetIcon(
                    key: const Key('dl_alert_chevron_icon'),
                    assetPath: DlIcons.chevronRightAsset,
                    color: colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _assetForVariant(DlAlertVariant variant) {
    switch (variant) {
      case DlAlertVariant.defaultVariant:
        return DlIcons.placeholderAsset;
      case DlAlertVariant.info:
        return DlIcons.placeholderAsset;
      case DlAlertVariant.success:
        return DlIcons.placeholderAsset;
      case DlAlertVariant.warning:
        return DlIcons.placeholderAsset;
      case DlAlertVariant.error:
        return DlIcons.placeholderAsset;
    }
  }

  Color _iconColorForVariant(DlColorPalette colors, DlAlertVariant variant) {
    switch (variant) {
      case DlAlertVariant.defaultVariant:
        return colors.black;
      case DlAlertVariant.info:
        return colors.violet.c500;
      case DlAlertVariant.success:
        return colors.green.c600;
      case DlAlertVariant.warning:
        return colors.yellow.c500;
      case DlAlertVariant.error:
        return colors.red.c500;
    }
  }

  Color _backgroundColorForVariant(
      DlColorPalette colors, DlAlertVariant variant, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    switch (variant) {
      case DlAlertVariant.defaultVariant:
        return colors.grey.c100;
      case DlAlertVariant.info:
        return isDark ? colors.violet.c950 : colors.violet.c50;
      case DlAlertVariant.success:
        return isDark ? colors.green.c950 : colors.green.c50;
      case DlAlertVariant.warning:
        return isDark ? colors.yellow.c950 : colors.yellow.c50;
      case DlAlertVariant.error:
        return isDark ? colors.red.c950 : colors.red.c50;
    }
  }
}
