/// DlTag — Usage rules:
/// - A small label for categorization or status display. Content-hugging —
///   width fits the label text.
/// - Not interactive — purely visual. Do not use as a button or chip.
/// - Use to highlight or label elements (e.g. a "New" tag next to a new item
///   on a screen, or a status like "Pending", "Completed").
/// - Types: defaultType (neutral/grey), warning (yellow), error (red),
///   success (green).
/// - Modes: light (default, subtle background) or dark (stronger background,
///   white text).
/// - Sizes: lg (default), md, sm.
/// - iconLeft / iconRight are optional. Keep icons small to match the tag size.
import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlTagSize { lg, md, sm }
enum DlTagMode { light, dark }
enum DlTagType { defaultType, warning, error, success }

class DlTag extends StatelessWidget {
  const DlTag({
    required this.label,
    super.key,
    this.iconLeft,
    this.iconRight,
    this.size = DlTagSize.lg,
    this.mode = DlTagMode.light,
    this.type = DlTagType.defaultType,
  });

  final String label;
  final Widget? iconLeft;
  final Widget? iconRight;
  final DlTagSize size;
  final DlTagMode mode;
  final DlTagType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final backgroundColor = _backgroundColor(colors);
    final foregroundColor = _foregroundColor(colors);

    return Container(
      key: const Key('dl_tag_container'),
      padding: _paddingForSize(),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
      ),
      child: Row(
        key: const Key('dl_tag_row'),
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconLeft != null) ...[
            SizedBox.square(
              key: const Key('dl_tag_icon_left_size_box'),
              dimension: _iconDimensionForSize(),
              child: Center(
                child: IconTheme(
                  key: const Key('dl_tag_icon_left_theme'),
                  data: IconThemeData(color: foregroundColor),
                  child: iconLeft!,
                ),
              ),
            ),
            const SizedBox(width: DlSpacingTokens.p_2),
          ],
          Text(
            label,
            key: const Key('dl_tag_label'),
            style: _textStyleForSize().copyWith(color: foregroundColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          if (iconRight != null) ...[
            const SizedBox(width: DlSpacingTokens.p_2),
            SizedBox.square(
              key: const Key('dl_tag_icon_right_size_box'),
              dimension: _iconDimensionForSize(),
              child: Center(
                child: IconTheme(
                  key: const Key('dl_tag_icon_right_theme'),
                  data: IconThemeData(color: foregroundColor),
                  child: iconRight!,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  EdgeInsets _paddingForSize() {
    switch (size) {
      case DlTagSize.lg:
      case DlTagSize.md:
        return const EdgeInsets.symmetric(
          horizontal: DlSpacingTokens.p_8,
          vertical: DlSpacingTokens.p_2,
        );
      case DlTagSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: DlSpacingTokens.p_4,
          vertical: DlSpacingTokens.p_2,
        );
    }
  }

  TextStyle _textStyleForSize() {
    switch (size) {
      case DlTagSize.lg:
        return DlTextStyles.textBase.semiBold;
      case DlTagSize.md:
        return DlTextStyles.textSm.semiBold;
      case DlTagSize.sm:
        return DlTextStyles.textXs.semiBold;
    }
  }

  double _iconDimensionForSize() {
    switch (size) {
      case DlTagSize.lg:
        return 24;
      case DlTagSize.md:
        return 20;
      case DlTagSize.sm:
        return 16;
    }
  }

  Color _backgroundColor(DlColorPalette colors) {
    switch (type) {
      case DlTagType.defaultType:
        switch (mode) {
          case DlTagMode.light:
            return colors.grey.c100;
          case DlTagMode.dark:
            return colors.grey.c500;
        }
      case DlTagType.warning:
        switch (mode) {
          case DlTagMode.light:
            return colors.yellow.c300;
          case DlTagMode.dark:
            return colors.yellow.c500;
        }
      case DlTagType.error:
        switch (mode) {
          case DlTagMode.light:
            return colors.red.c100;
          case DlTagMode.dark:
            return colors.red.c500;
        }
      case DlTagType.success:
        switch (mode) {
          case DlTagMode.light:
            return colors.green.c100;
          case DlTagMode.dark:
            return colors.green.c600;
        }
    }
  }

  Color _foregroundColor(DlColorPalette colors) {
    switch (type) {
      case DlTagType.defaultType:
        switch (mode) {
          case DlTagMode.light:
            return colors.grey.c600;
          case DlTagMode.dark:
            return colors.white;
        }
      case DlTagType.warning:
        switch (mode) {
          case DlTagMode.light:
            return colors.yellow.c700;
          case DlTagMode.dark:
            return Colors.black;
        }
      case DlTagType.error:
        switch (mode) {
          case DlTagMode.light:
            return colors.red.c600;
          case DlTagMode.dark:
            return Colors.white;
        }
      case DlTagType.success:
        switch (mode) {
          case DlTagMode.light:
            return colors.green.c700;
          case DlTagMode.dark:
            return Colors.white;
        }
    }
  }
}
