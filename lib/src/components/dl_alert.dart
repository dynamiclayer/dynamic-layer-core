import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../foundations/icons/dl_icons.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlAlertVariant { info, success, warning, error }

class DlAlert extends StatefulWidget {
  const DlAlert({
    required this.title,
    this.description,
    super.key,
    this.variant = DlAlertVariant.info,
    this.onClose,
  });

  final String title;
  final String? description;
  final DlAlertVariant variant;
  final VoidCallback? onClose;

  @override
  State<DlAlert> createState() => _DlAlertState();
}

class _DlAlertState extends State<DlAlert> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    final colors = context.dlColors;
    final textContentWrapper = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          key: const Key('dl_alert_title'),
          style: DlTextStyles.textBase.semiBold.copyWith(color: colors.black),
        ),
        if (widget.description != null && widget.description!.isNotEmpty) ...[
          const SizedBox(height: DlSpacingTokens.p_4),
          Text(
            widget.description!,
            key: const Key('dl_alert_description'),
            style: DlTextStyles.textBase.regular.copyWith(color: colors.black),
          ),
        ],
      ],
    );

    final leadingSectionWrapper = Padding(
      key: const Key('dl_alert_left_block'),
      padding: const EdgeInsets.all(DlSpacingTokens.p_16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DlAssetIcon(
            key: const Key('dl_alert_variant_icon'),
            assetPath: _assetForVariant(widget.variant),
          ),
          const SizedBox(width: DlSpacingTokens.p_16),
          Expanded(child: textContentWrapper),
        ],
      ),
    );

    return Container(
      key: const Key('dl_alert_container'),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedLg),
        border: Border.all(color: colors.grey.c200, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: leadingSectionWrapper),
          if (widget.onClose != null) ...[
            Material(
              color: Colors.transparent,
              child: InkWell(
                key: const Key('dl_alert_close_button'),
                onTap: _handleCloseTap,
                borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                child: Padding(
                  key: const Key('dl_alert_close_block'),
                  padding: const EdgeInsets.all(DlSpacingTokens.p_16),
                  child: SizedBox.square(
                    dimension: 24,
                    child: Center(
                      child: DlAssetIcon(
                        key: const Key('dl_alert_close_icon'),
                        assetPath: DlIcons.circleXAsset,
                        color: colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _assetForVariant(DlAlertVariant variant) {
    switch (variant) {
      case DlAlertVariant.info:
        return DlIcons.infoAsset;
      case DlAlertVariant.success:
        return DlIcons.circleCheckAsset;
      case DlAlertVariant.warning:
        return DlIcons.alertTriangleFilledAsset;
      case DlAlertVariant.error:
        return DlIcons.circleAlertAsset;
    }
  }

  void _handleCloseTap() {
    if (!_isVisible) return;
    setState(() => _isVisible = false);
    widget.onClose?.call();
  }
}
