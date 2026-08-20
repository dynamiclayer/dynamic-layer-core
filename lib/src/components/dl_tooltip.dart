/// DlTooltip — Usage rules:
/// - A dark overlay label with an arrow pointing to the related element.
///   Content-hugging — width fits the label.
/// - Use for brief contextual hints or explanations next to UI elements.
/// - Direction controls where the arrow points: bottom (default), top, left,
///   right. Choose the direction so the arrow points toward the element it
///   describes.
/// - Always keep the tooltip fully within the visible screen area. Choose the
///   direction based on the target element's position — e.g. if the element is
///   near the right edge, use direction left so the tooltip does not overflow.
/// - Position the tooltip relative to its target using a Stack with Positioned,
///   or place it inline adjacent to the target element.
/// - Not interactive — purely informational. For interactive guidance, use
///   DlCoachMark instead.
/// - No size or type variants — one consistent dark appearance.
import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlTooltipDirection { bottom, top, left, right }

class DlTooltip extends StatelessWidget {
  const DlTooltip({
    required this.label,
    super.key,
    this.direction = DlTooltipDirection.bottom,
  });

  final String label;
  final DlTooltipDirection direction;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final bgColor = colors.black;
    final textColor = colors.white;

    final tooltipBox = Container(
      key: const Key('dl_tooltip_box'),
      padding: const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_16,
        vertical: DlSpacingTokens.p_8,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
      ),
      child: Text(
        label,
        key: const Key('dl_tooltip_label'),
        style: DlTextStyles.textBase.bold.copyWith(color: textColor),
      ),
    );

    final arrow = CustomPaint(
      key: const Key('dl_tooltip_arrow'),
      size: _arrowSizeForDirection(direction),
      painter: _DlTooltipArrowPainter(direction: direction, color: bgColor),
    );

    switch (direction) {
      case DlTooltipDirection.bottom:
        return Column(
          key: const Key('dl_tooltip'),
          mainAxisSize: MainAxisSize.min,
          children: [tooltipBox, arrow],
        );
      case DlTooltipDirection.top:
        return Column(
          key: const Key('dl_tooltip'),
          mainAxisSize: MainAxisSize.min,
          children: [arrow, tooltipBox],
        );
      case DlTooltipDirection.left:
        return Row(
          key: const Key('dl_tooltip'),
          mainAxisSize: MainAxisSize.min,
          children: [arrow, tooltipBox],
        );
      case DlTooltipDirection.right:
        return Row(
          key: const Key('dl_tooltip'),
          mainAxisSize: MainAxisSize.min,
          children: [tooltipBox, arrow],
        );
    }
  }

  Size _arrowSizeForDirection(DlTooltipDirection direction) {
    switch (direction) {
      case DlTooltipDirection.bottom:
      case DlTooltipDirection.top:
        return const Size(20, 10);
      case DlTooltipDirection.left:
      case DlTooltipDirection.right:
        return const Size(10, 20);
    }
  }
}

class _DlTooltipArrowPainter extends CustomPainter {
  const _DlTooltipArrowPainter({required this.direction, required this.color});

  final DlTooltipDirection direction;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const tipRadius = 2.0;
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final path = Path();

    switch (direction) {
      case DlTooltipDirection.bottom:
        path
          ..moveTo(0, 0)
          ..lineTo(centerX - tipRadius, size.height - tipRadius)
          ..quadraticBezierTo(
            centerX,
            size.height,
            centerX + tipRadius,
            size.height - tipRadius,
          )
          ..lineTo(size.width, 0)
          ..close();
      case DlTooltipDirection.top:
        path
          ..moveTo(0, size.height)
          ..lineTo(centerX - tipRadius, tipRadius)
          ..quadraticBezierTo(centerX, 0, centerX + tipRadius, tipRadius)
          ..lineTo(size.width, size.height)
          ..close();
      case DlTooltipDirection.left:
        path
          ..moveTo(size.width, 0)
          ..lineTo(tipRadius, centerY - tipRadius)
          ..quadraticBezierTo(0, centerY, tipRadius, centerY + tipRadius)
          ..lineTo(size.width, size.height)
          ..close();
      case DlTooltipDirection.right:
        path
          ..moveTo(0, 0)
          ..lineTo(size.width - tipRadius, centerY - tipRadius)
          ..quadraticBezierTo(
            size.width,
            centerY,
            size.width - tipRadius,
            centerY + tipRadius,
          )
          ..lineTo(0, size.height)
          ..close();
    }

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _DlTooltipArrowPainter oldDelegate) {
    return oldDelegate.direction != direction || oldDelegate.color != color;
  }
}
