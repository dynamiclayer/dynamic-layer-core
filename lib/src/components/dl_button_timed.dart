import 'dart:async';

import 'package:flutter/material.dart';

import 'dl_button.dart';

class DlButtonTimed extends StatefulWidget {
  const DlButtonTimed({
    required this.label,
    required this.countdownInSeconds,
    super.key,
    this.onPressed,
    this.type = DlButtonType.primary,
    this.size = DlButtonSize.lg,
    this.state = DlButtonState.defaultState,
    this.iconLeft,
    this.iconRight,
    this.fullWidth = false,
    this.onCountdownCompleted,
  }) : assert(
         countdownInSeconds >= 0,
         'countdownInSeconds must be greater than or equal to 0.',
       );

  final String label;
  final int countdownInSeconds;
  final VoidCallback? onPressed;
  final DlButtonType type;
  final DlButtonSize size;
  final DlButtonState state;
  final Widget? iconLeft;
  final Widget? iconRight;
  final bool fullWidth;
  final VoidCallback? onCountdownCompleted;

  @override
  State<DlButtonTimed> createState() => _DlButtonTimedState();
}

class _DlButtonTimedState extends State<DlButtonTimed> {
  Timer? _timer;
  late int _remainingSeconds;
  static void _noop() {}

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.countdownInSeconds;
    _startCountdownIfNeeded();
  }

  @override
  void didUpdateWidget(covariant DlButtonTimed oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.countdownInSeconds != widget.countdownInSeconds) {
      _timer?.cancel();
      _remainingSeconds = widget.countdownInSeconds;
      _startCountdownIfNeeded();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCountingDown = _remainingSeconds > 0;

    return DlButton(
      key: const Key('dl_button_timed'),
      label: '${widget.label} (${_formattedCountdown()})',
      onPressed: isCountingDown ? null : _handlePressed,
      type: widget.type,
      size: widget.size,
      state: isCountingDown ? DlButtonState.disabled : DlButtonState.defaultState,
      iconLeft: widget.iconLeft,
      iconRight: widget.iconRight,
      fullWidth: widget.fullWidth,
    );
  }

  void _startCountdownIfNeeded() {
    if (_remainingSeconds <= 0) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_remainingSeconds <= 0) {
        _timer?.cancel();
        return;
      }
      setState(() => _remainingSeconds -= 1);
      if (_remainingSeconds == 0) {
        _timer?.cancel();
        widget.onCountdownCompleted?.call();
      }
    });
  }

  void _handlePressed() {
    (widget.onPressed ?? _noop).call();
    if (widget.countdownInSeconds <= 0) return;
    _timer?.cancel();
    setState(() => _remainingSeconds = widget.countdownInSeconds);
    _startCountdownIfNeeded();
  }

  String _formattedCountdown() {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    final secondsText = seconds.toString().padLeft(2, '0');
    return '$minutes:$secondsText';
  }
}
