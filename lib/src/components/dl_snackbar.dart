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
      alignment: Alignment.centerLeft,
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
            borderRadius: BorderRadius.circular(DlRadiusTokens.roundedMd),
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
              ),
              const SizedBox(width: DlSpacingTokens.p_8),
              Flexible(
                child: Text(
                  label,
                  key: const Key('dl_snackbar_label'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: DlTextStyles.textBase.semiBold.copyWith(color: colors.black),
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
        return DlIcons.circleCheckAsset;
      case DlSnackbarType.error:
        return DlIcons.circleAlertAsset;
      case DlSnackbarType.warning:
        return DlIcons.alertTriangleFilledAsset;
      case DlSnackbarType.information:
        return DlIcons.infoAsset;
    }
  }
}
