/// DlSeparator — Usage rules:
/// - A 1px line to visually divide content sections. Always use to separate
///   thematic categories or content groups from each other.
/// - Orientation horizontal (default): Full-width line. Use between list items,
///   sections, or above/below fixed components like DlButtonDock.
/// - Orientation vertical: Full-height line. Use between side-by-side elements
///   (e.g. inside a Row).
/// - No size, state, or color variants — one consistent appearance (grey.c200).
/// - Do not add extra spacing around it — the separator provides only the line.
///   Use SizedBox or padding on surrounding elements for spacing.
import 'package:flutter/material.dart';

import '../theme/dl_color_palette.dart';

enum DlSeparatorOrientation { horizontal, vertical }

class DlSeparator extends StatelessWidget {
  const DlSeparator({
    super.key,
    this.orientation = DlSeparatorOrientation.horizontal,
  });

  final DlSeparatorOrientation orientation;

  @override
  Widget build(BuildContext context) {
    final color = context.dlColors.grey.c200;

    switch (orientation) {
      case DlSeparatorOrientation.horizontal:
        return SizedBox(
          key: const Key('dl_separator_line'),
          width: double.infinity,
          height: 1,
          child: DecoratedBox(decoration: BoxDecoration(color: color)),
        );
      case DlSeparatorOrientation.vertical:
        return SizedBox(
          key: const Key('dl_separator_line'),
          width: 1,
          height: double.infinity,
          child: DecoratedBox(decoration: BoxDecoration(color: color)),
        );
    }
  }
}
