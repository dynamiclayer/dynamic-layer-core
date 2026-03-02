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
    super.key,
    this.contentTitle,
    this.contentDescription,
    this.buttons = const [],
    this.contentMedia,
  });

  final String headerTitle;
  final String? contentTitle;
  final String? contentDescription;
  final List<DlButton> buttons;
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
          _buildHeader(context, colors),
          _buildContent(colors),
          if (buttons.isNotEmpty) _buildButtonWrapper(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, DlColorPalette colors) {
    return Container(
      key: const Key('dl_bottom_sheet_header'),
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
                onTap: () => Navigator.of(context).maybePop(),
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                child: Center(
                  child: IconTheme(
                    data: IconThemeData(color: colors.black),
                    child: const DlAssetIcon(assetPath: DlIcons.xAsset),
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
    final hasTitle = contentTitle != null && contentTitle!.isNotEmpty;
    final hasDescription =
        contentDescription != null && contentDescription!.isNotEmpty;

    return Container(
      key: const Key('dl_bottom_sheet_content'),
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
            height: 120,
            child: contentMedia ?? Container(color: colors.grey.c100),
          ),
          if (hasTitle || hasDescription)
            Padding(
              key: const Key('dl_bottom_sheet_text_box'),
              padding: const EdgeInsets.symmetric(
                vertical: DlSpacingTokens.p_32,
                horizontal: DlSpacingTokens.p_16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (hasTitle)
                    Text(
                      contentTitle!,
                      key: const Key('dl_bottom_sheet_content_title'),
                      textAlign: TextAlign.center,
                      style: DlTextStyles.textXl.semiBold.copyWith(
                        color: colors.black,
                      ),
                    ),
                  if (hasTitle && hasDescription)
                    const SizedBox(height: DlSpacingTokens.p_8),
                  if (hasDescription)
                    Text(
                      contentDescription!,
                      key: const Key('dl_bottom_sheet_content_description'),
                      textAlign: TextAlign.center,
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
      padding: const EdgeInsets.only(
        left: DlSpacingTokens.p_16,
        right: DlSpacingTokens.p_16,
        top: DlSpacingTokens.p_0,
        bottom: DlSpacingTokens.p_16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < buttons.length; i++) ...[
            buttons[i],
            if (i < buttons.length - 1)
              const SizedBox(height: DlSpacingTokens.p_16),
          ],
        ],
      ),
    );
  }
}
