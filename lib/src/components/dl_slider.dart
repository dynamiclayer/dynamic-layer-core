import 'package:flutter/material.dart';

import '../foundations/tokens/dl_border_width_tokens.dart';
import '../theme/dl_color_palette.dart';

class DlSlider extends StatefulWidget {
  const DlSlider({
    super.key,
    this.initialValue = 0,
    this.onChanged,
  }) : assert(
         initialValue >= 0 && initialValue <= 1,
         'initialValue must be between 0 and 1.',
       );

  final double initialValue;
  final ValueChanged<double>? onChanged;

  @override
  State<DlSlider> createState() => _DlSliderState();
}

class _DlSliderState extends State<DlSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant DlSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return SizedBox(
      key: const Key('dl_slider'),
      width: double.infinity,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 4,
          activeTrackColor: colors.black,
          inactiveTrackColor: colors.grey.c200,
          activeTickMarkColor: Colors.transparent,
          inactiveTickMarkColor: Colors.transparent,
          overlayShape: SliderComponentShape.noOverlay,
          trackShape: const RoundedRectSliderTrackShape(),
          thumbShape: _DlSliderThumbShape(
            fillColor: colors.white,
            borderColor: colors.grey.c200,
          ),
        ),
        child: Slider(
          key: const Key('dl_slider_control'),
          min: 0,
          max: 1,
          value: _value,
          onChanged: (next) {
            setState(() => _value = next);
            widget.onChanged?.call(next);
          },
        ),
      ),
    );
  }
}

class _DlSliderThumbShape extends SliderComponentShape {
  const _DlSliderThumbShape({
    required this.fillColor,
    required this.borderColor,
  });

  final Color fillColor;
  final Color borderColor;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(24, 24);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final radius = getPreferredSize(true, false).width / 2;

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, fillPaint);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = DlBorderWidthTokens.border2;
    canvas.drawCircle(center, radius - (DlBorderWidthTokens.border2 / 2), borderPaint);
  }
}
