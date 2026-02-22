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
