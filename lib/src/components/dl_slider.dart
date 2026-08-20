/// DlSlider — Usage rules:
/// - A horizontal slider for selecting a value between 0 and 1. Always takes
///   the full width of its parent container.
/// - initialValue sets the starting position (default: 0). Must be between
///   0 and 1.
/// - onChanged fires on every drag update with the current value (0–1).
/// - No size, type, or state variants — one consistent appearance.
/// - Use for continuous value selection (e.g. volume, brightness, price range).
///   For discrete option selection, use DlChip or DlRadioButton instead.
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
          trackShape: const _DlSliderTrackShape(),
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

class _DlSliderTrackShape extends RoundedRectSliderTrackShape {
  const _DlSliderTrackShape();

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    Offset? secondaryOffset,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    final canvas = context.canvas;
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final trackHeight = sliderTheme.trackHeight ?? 0;
    final fullTrackRect = Rect.fromLTWH(
      offset.dx,
      trackRect.top,
      parentBox.size.width,
      trackHeight,
    );

    final normalizedValue = ((thumbCenter.dx - trackRect.left) / trackRect.width).clamp(
      0.0,
      1.0,
    );
    final splitX = fullTrackRect.left + (fullTrackRect.width * normalizedValue);
    final radius = Radius.circular(trackHeight / 2);

    final activeRect = Rect.fromLTRB(
      fullTrackRect.left,
      fullTrackRect.top,
      splitX,
      fullTrackRect.bottom,
    );
    final inactiveRect = Rect.fromLTRB(
      splitX,
      fullTrackRect.top,
      fullTrackRect.right,
      fullTrackRect.bottom,
    );

    final activePaint = Paint()
      ..color = sliderTheme.activeTrackColor ?? Colors.black
      ..style = PaintingStyle.fill;
    final inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor ?? Colors.grey
      ..style = PaintingStyle.fill;

    if (activeRect.width > 0) {
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          activeRect,
          topLeft: radius,
          bottomLeft: radius,
          topRight: radius,
          bottomRight: radius,
        ),
        activePaint,
      );
    }
    if (inactiveRect.width > 0) {
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          inactiveRect,
          topLeft: radius,
          bottomLeft: radius,
          topRight: radius,
          bottomRight: radius,
        ),
        inactivePaint,
      );
    }
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
    final innerRadius = radius - DlBorderWidthTokens.border2;

    final outerPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, outerPaint);

    final innerPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, innerRadius, innerPaint);
  }
}
