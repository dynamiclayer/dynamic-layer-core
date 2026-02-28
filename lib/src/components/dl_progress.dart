import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../theme/dl_color_palette.dart';

class DlProgress extends StatelessWidget {
  const DlProgress({
    super.key,
    this.value = 0,
  }) : assert(
         value >= 0 && value <= 100,
         'value must be between 0 and 100.',
       );

  final double value;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return Container(
      key: const Key('dl_progress'),
      width: double.infinity,
      height: 8,
      decoration: BoxDecoration(
        color: colors.grey.c200,
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: value / 100,
            child: Container(
              key: const Key('dl_progress_fill'),
              height: 8,
              color: colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
