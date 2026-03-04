import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_text_styles.dart';
import 'dl_button.dart';
import 'dl_pagination.dart';

enum DlCoachMarkDirection { bottom, top, left, right }

class DlCoachMarkStep {
  const DlCoachMarkStep({required this.title, required this.description});

  final String title;
  final String description;
}

class DlCoachMark extends StatefulWidget {
  DlCoachMark({
    required this.steps,
    super.key,
    this.initialStepIndex = 0,
    this.onPaginationChanged,
    this.leftButtonLabel = 'Back',
    this.rightButtonLabel = 'Next',
    this.onLeftButtonPressed,
    this.onRightButtonPressed,
    this.direction = DlCoachMarkDirection.bottom,
  }) : assert(steps.isNotEmpty, 'steps must not be empty'),
       assert(
         initialStepIndex >= 0 && initialStepIndex < steps.length,
         'initialStepIndex must be within steps bounds.',
       );

  final List<DlCoachMarkStep> steps;
  final int initialStepIndex;
  final ValueChanged<int>? onPaginationChanged;
  final String leftButtonLabel;
  final String rightButtonLabel;
  final VoidCallback? onLeftButtonPressed;
  final VoidCallback? onRightButtonPressed;
  final DlCoachMarkDirection direction;

  @override
  State<DlCoachMark> createState() => _DlCoachMarkState();
}

class _DlCoachMarkState extends State<DlCoachMark> {
  late int _currentStepIndex;

  @override
  void initState() {
    super.initState();
    _currentStepIndex = widget.initialStepIndex;
  }

  @override
  void didUpdateWidget(covariant DlCoachMark oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialStepIndex != widget.initialStepIndex ||
        oldWidget.steps.length != widget.steps.length) {
      _currentStepIndex = widget.initialStepIndex.clamp(
        0,
        widget.steps.length - 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = widget.steps[_currentStepIndex];

    final box = Container(
      key: const Key('dl_coach_mark_box'),
      width: double.infinity,
      padding: const EdgeInsets.all(DlSpacingTokens.p_16),
      decoration: BoxDecoration(
        color: _coachMarkBackground,
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedXl),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            currentStep.title,
            key: const Key('dl_coach_mark_title'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: DlTextStyles.textBase.semiBold.copyWith(
              color: _coachMarkText,
            ),
          ),
          Text(
            currentStep.description,
            key: const Key('dl_coach_mark_description'),
            style: DlTextStyles.textBase.regular.copyWith(
              color: _coachMarkText,
            ),
          ),
          const SizedBox(height: DlSpacingTokens.p_8),
          Row(
            key: const Key('dl_coach_mark_footer'),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DlPagination(
                key: ValueKey('dl_coach_mark_pagination_$_currentStepIndex'),
                count: widget.steps.length,
                initialIndex: _currentStepIndex,
                onChanged: _setStepFromPagination,
                selectedDotColor: Colors.white,
                unselectedDotColor: Colors.white.withAlpha(102),
              ),
              Row(
                key: const Key('dl_coach_mark_buttons'),
                children: [
                  DlButton(
                    key: const Key('dl_coach_mark_left_button'),
                    label: widget.leftButtonLabel,
                    type: DlButtonType.secondary,
                    size: DlButtonSize.xs,
                    state: _canGoBack
                        ? DlButtonState.defaultState
                        : DlButtonState.disabled,
                    onPressed: _canGoBack ? _onBackPressed : _noop,
                  ),
                  const SizedBox(width: DlSpacingTokens.p_8),
                  DlButton(
                    key: const Key('dl_coach_mark_right_button'),
                    label: widget.rightButtonLabel,
                    type: DlButtonType.secondary,
                    size: DlButtonSize.xs,
                    state: _canGoNext
                        ? DlButtonState.defaultState
                        : DlButtonState.disabled,
                    onPressed: _canGoNext ? _onNextPressed : _noop,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    final arrow = CustomPaint(
      key: const Key('dl_coach_mark_arrow'),
      size: _arrowSizeForDirection(widget.direction),
      painter: _DlCoachMarkArrowPainter(direction: widget.direction),
    );

    switch (widget.direction) {
      case DlCoachMarkDirection.bottom:
        return SizedBox(
          key: const Key('dl_coach_mark'),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              box,
              Align(alignment: Alignment.center, child: arrow),
            ],
          ),
        );
      case DlCoachMarkDirection.top:
        return SizedBox(
          key: const Key('dl_coach_mark'),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(alignment: Alignment.center, child: arrow),
              box,
            ],
          ),
        );
      case DlCoachMarkDirection.left:
        return SizedBox(
          key: const Key('dl_coach_mark'),
          width: double.infinity,
          child: Row(
            children: [
              arrow,
              Expanded(child: box),
            ],
          ),
        );
      case DlCoachMarkDirection.right:
        return SizedBox(
          key: const Key('dl_coach_mark'),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(child: box),
              arrow,
            ],
          ),
        );
    }
  }

  bool get _canGoBack => _currentStepIndex > 0;
  bool get _canGoNext => _currentStepIndex < widget.steps.length - 1;

  void _onBackPressed() {
    if (!_canGoBack) return;
    widget.onLeftButtonPressed?.call();
    _setStep(_currentStepIndex - 1);
  }

  void _onNextPressed() {
    if (!_canGoNext) return;
    widget.onRightButtonPressed?.call();
    _setStep(_currentStepIndex + 1);
  }

  void _setStepFromPagination(int index) {
    _setStep(index);
  }

  void _setStep(int index) {
    if (index == _currentStepIndex) return;
    setState(() => _currentStepIndex = index);
    widget.onPaginationChanged?.call(index);
  }

  Size _arrowSizeForDirection(DlCoachMarkDirection direction) {
    switch (direction) {
      case DlCoachMarkDirection.bottom:
      case DlCoachMarkDirection.top:
        return const Size(20, 10);
      case DlCoachMarkDirection.left:
      case DlCoachMarkDirection.right:
        return const Size(10, 20);
    }
  }

  static void _noop() {}
}

const Color _coachMarkBackground = Color(0xFF1F1F1F);
const Color _coachMarkText = Color(0xFFFFFFFF);

class _DlCoachMarkArrowPainter extends CustomPainter {
  const _DlCoachMarkArrowPainter({required this.direction});

  final DlCoachMarkDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    const tipRadius = 2.0;
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final path = Path();

    switch (direction) {
      case DlCoachMarkDirection.bottom:
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
      case DlCoachMarkDirection.top:
        path
          ..moveTo(0, size.height)
          ..lineTo(centerX - tipRadius, tipRadius)
          ..quadraticBezierTo(centerX, 0, centerX + tipRadius, tipRadius)
          ..lineTo(size.width, size.height)
          ..close();
      case DlCoachMarkDirection.left:
        path
          ..moveTo(size.width, 0)
          ..lineTo(tipRadius, centerY - tipRadius)
          ..quadraticBezierTo(0, centerY, tipRadius, centerY + tipRadius)
          ..lineTo(size.width, size.height)
          ..close();
      case DlCoachMarkDirection.right:
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
      ..color = _coachMarkBackground;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _DlCoachMarkArrowPainter oldDelegate) {
    return oldDelegate.direction != direction;
  }
}
