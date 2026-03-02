import 'package:flutter/material.dart';

import '../foundations/icons/dl_icons.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';
import 'dl_button.dart';

class DlBottomSheet extends StatelessWidget {
  const DlBottomSheet({
    required this.headerTitle,
    required this.contentTitle,
    required this.contentDescription,
    required this.primaryButtonLabel,
    required this.secondaryButtonLabel,
    super.key,
    this.onHeaderIconPressed,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.headerRightIcon,
    this.contentMedia,
  });

  final String headerTitle;
  final String contentTitle;
  final String contentDescription;
  final String primaryButtonLabel;
  final String secondaryButtonLabel;
  final VoidCallback? onHeaderIconPressed;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final Widget? headerRightIcon;
  final Widget? contentMedia;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return Container(
      key: const Key('dl_bottom_sheet'),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(DlRadiusTokens.rounded3Xl),
          topRight: Radius.circular(DlRadiusTokens.rounded3Xl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(colors),
          _buildContent(colors),
          _buildButtonWrapper(),
        ],
      ),
    );
  }

  Widget _buildHeader(DlColorPalette colors) {
    return Container(
      key: const Key('dl_bottom_sheet_header'),
      color: colors.white,
      child: Row(
        children: [
          const SizedBox(
            key: Key('dl_bottom_sheet_header_left_box'),
            width: 56,
            height: 56,
          ),
          Expanded(
            child: Text(
              headerTitle,
              key: const Key('dl_bottom_sheet_header_title'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: DlTextStyles.textBase.semiBold.copyWith(
                color: colors.black,
              ),
            ),
          ),
          SizedBox(
            key: const Key('dl_bottom_sheet_header_right_box'),
            width: 56,
            height: 56,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                key: const Key('dl_bottom_sheet_header_right_tap'),
                onTap: onHeaderIconPressed,
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                child: Center(
                  child: IconTheme(
                    data: IconThemeData(color: colors.black),
                    child: headerRightIcon ?? const DlPlaceholderIcon(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(DlColorPalette colors) {
    return Container(
      key: const Key('dl_bottom_sheet_content'),
      color: colors.white,
      padding: const EdgeInsets.only(
        top: DlSpacingTokens.p_32,
        left: DlSpacingTokens.p_16,
        right: DlSpacingTokens.p_16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            key: const Key('dl_bottom_sheet_media'),
            height: 12,
            child: contentMedia ?? Container(color: colors.grey.c100),
          ),
          Padding(
            key: const Key('dl_bottom_sheet_text_box'),
            padding: const EdgeInsets.symmetric(
              vertical: DlSpacingTokens.p_32,
              horizontal: DlSpacingTokens.p_16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  contentTitle,
                  key: const Key('dl_bottom_sheet_content_title'),
                  style: DlTextStyles.textXl.semiBold.copyWith(
                    color: colors.black,
                  ),
                ),
                Text(
                  contentDescription,
                  key: const Key('dl_bottom_sheet_content_description'),
                  style: DlTextStyles.textBase.regular.copyWith(
                    color: colors.grey.c500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonWrapper() {
    return Container(
      key: const Key('dl_bottom_sheet_button_wrapper'),
      color: Colors.white,
      padding: const EdgeInsets.only(
        left: DlSpacingTokens.p_16,
        right: DlSpacingTokens.p_16,
        top: DlSpacingTokens.p_0,
        bottom: DlSpacingTokens.p_16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DlButton(
            key: const Key('dl_bottom_sheet_primary_button'),
            label: primaryButtonLabel,
            type: DlButtonType.primary,
            fullWidth: true,
            onPressed: onPrimaryPressed,
          ),
          const SizedBox(height: DlSpacingTokens.p_16),
          DlButton(
            key: const Key('dl_bottom_sheet_secondary_button'),
            label: secondaryButtonLabel,
            type: DlButtonType.secondary,
            fullWidth: true,
            onPressed: onSecondaryPressed,
          ),
        ],
      ),
    );
  }
}
