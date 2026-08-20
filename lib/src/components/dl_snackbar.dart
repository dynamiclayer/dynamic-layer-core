/// DlSnackbar — Usage rules:
/// - A brief feedback message with an icon and label. Content-hugging — width
///   fits the label, horizontally centered on the screen.
/// - Use for temporary notifications after user actions (e.g. "Saved
///   successfully", "Error occurred"). Show via an overlay or animation,
///   then dismiss after a short duration.
/// - Types: success (green check), error (red alert), warning (yellow triangle),
///   information (violet info icon). The icon is set automatically by type.
/// - Not interactive — purely visual feedback. No buttons or dismiss action.
/// - No size variants — one consistent appearance.
/// - Keep the label short — single line, truncates on overflow.
import 'package:flutter/material.dart';

import '../foundations/icons/dl_icons.dart';
import '../foundations/tokens/dl_border_width_tokens.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlSnackbarType { success, error, warning, information }

class DlSnackbar extends StatelessWidget {
  const DlSnackbar({
    required this.label,
    super.key,
    this.type = DlSnackbarType.success,
  });

  final String label;
  final DlSnackbarType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return Align(
      alignment: Alignment.center,
      child: IntrinsicWidth(
        child: Container(
          key: const Key('dl_snackbar'),
          padding: const EdgeInsets.fromLTRB(
            DlSpacingTokens.p_12,
            DlSpacingTokens.p_12,
            DlSpacingTokens.p_20,
            DlSpacingTokens.p_12,
          ),
          decoration: BoxDecoration(
            color: colors.white,
            borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
            border: Border.all(
              color: colors.grey.c200,
              width: DlBorderWidthTokens.border1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DlAssetIcon(
                key: const Key('dl_snackbar_icon'),
                assetPath: _iconPathForType(),
                color: _iconColorForType(colors),
              ),
              const SizedBox(width: DlSpacingTokens.p_8),
              Flexible(
                child: Text(
                  label,
                  key: const Key('dl_snackbar_label'),
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
      ),
    );
  }

  String _iconPathForType() {
    switch (type) {
      case DlSnackbarType.success:
        return DlIcons.circleCheckFilledAsset;
      case DlSnackbarType.error:
        return DlIcons.circleAlertFilledAsset;
      case DlSnackbarType.warning:
        return DlIcons.triangleAlertFilledAsset;
      case DlSnackbarType.information:
        return DlIcons.circleAlertFilledAsset;
    }
  }

  Color _iconColorForType(DlColorPalette colors) {
    switch (type) {
      case DlSnackbarType.success:
        return colors.green.c600;
      case DlSnackbarType.error:
        return colors.red.c500;
      case DlSnackbarType.warning:
        return colors.yellow.c500;
      case DlSnackbarType.information:
        return colors.violet.c500;
    }
  }
}
