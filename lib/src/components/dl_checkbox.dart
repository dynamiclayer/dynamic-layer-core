import 'package:flutter/material.dart';

import '../foundations/tokens/dl_border_width_tokens.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../theme/dl_color_palette.dart';

enum DlCheckboxState { defaultState, active, disabled }

class DlCheckbox extends StatefulWidget {
  const DlCheckbox({
    super.key,
    this.state = DlCheckboxState.defaultState,
  });

  final DlCheckboxState state;

  @override
  State<DlCheckbox> createState() => _DlCheckboxState();
}

class _DlCheckboxState extends State<DlCheckbox> {
  late DlCheckboxState _state;

  bool get _isDisabled => _state == DlCheckboxState.disabled;
  bool get _isActive => _state == DlCheckboxState.active;

  @override
  void initState() {
    super.initState();
    _state = widget.state;
  }

  @override
  void didUpdateWidget(covariant DlCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      _state = widget.state;
    }
  }

  void _toggleState() {
    if (_isDisabled) return;
    setState(() {
      _state = _isActive ? DlCheckboxState.defaultState : DlCheckboxState.active;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final backgroundColor = _isDisabled
        ? colors.grey.c50
        : (_isActive ? colors.black : colors.white);
    final borderColor = _isActive ? Colors.transparent : colors.grey.c200;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: const Key('dl_checkbox_tap_area'),
        onTap: _isDisabled ? null : _toggleState,
        borderRadius: BorderRadius.circular(DlRadiusTokens.rounded),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: SizedBox(
          key: const Key('dl_checkbox_outer'),
          width: 24,
          height: 24,
          child: Center(
            child: Container(
              key: const Key('dl_checkbox_inner'),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(DlRadiusTokens.rounded),
                border: Border.all(
                  color: borderColor,
                  width: DlBorderWidthTokens.border1,
                ),
              ),
              child: _isActive
                  ? Center(
                      child: CustomPaint(
                        key: const Key('dl_checkbox_checkmark'),
                        size: const Size(22, 22),
                        painter: _DlCheckboxCheckmarkPainter(
                          color: colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _DlCheckboxCheckmarkPainter extends CustomPainter {
  const _DlCheckboxCheckmarkPainter({
    required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const sqrt2 = 1.41421356237;
    const shortSegmentLength = 4.0;
    const longSegmentLength = 7.0;
    final shortDelta = shortSegmentLength / sqrt2;
    final longDelta = longSegmentLength / sqrt2;
    final checkWidth = shortDelta + longDelta;
    final checkHeight = longDelta;
    final offsetX = (size.width - checkWidth) / 2;
    final offsetY = (size.height - checkHeight) / 2;

    final start = Offset(offsetX, offsetY + (longDelta - shortDelta));
    final middle = Offset(offsetX + shortDelta, offsetY + longDelta);
    final end = Offset(offsetX + checkWidth, offsetY);

    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(middle.dx, middle.dy)
      ..lineTo(end.dx, end.dy);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
