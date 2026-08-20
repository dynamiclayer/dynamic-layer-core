/// DlMessageLoading — Usage rules:
/// - A typing indicator bubble with three animated dots, styled like a received
///   message (grey background, left-aligned).
/// - Show while the other party is typing or the system is processing a
///   response. Remove and replace with the actual DlMessage when it arrives.
/// - Always left-align using Align(alignment: Alignment.centerLeft), same as
///   a received DlMessage.
/// - Use together with DlMessage, DlTopNavigation, and DlMessageDock
///   on chat screens.
/// - No size, type, or state variants — one consistent appearance.
import 'dart:async';

import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';

class DlMessageLoading extends StatelessWidget {
  const DlMessageLoading({
    super.key,
    this.stepDuration = const Duration(milliseconds: 450),
  });

  final Duration stepDuration;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return Container(
      key: const Key('dl_message_loading'),
      padding: const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_8,
        vertical: DlSpacingTokens.p_12,
      ),
      decoration: BoxDecoration(
        color: colors.grey.c100,
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
      ),
      child: DlMessageLoadingDots(stepDuration: stepDuration),
    );
  }
}

class DlMessageLoadingDots extends StatefulWidget {
  const DlMessageLoadingDots({
    super.key,
    this.stepDuration = const Duration(milliseconds: 450),
  });

  final Duration stepDuration;

  @override
  State<DlMessageLoadingDots> createState() => _DlMessageLoadingDotsState();
}

class _DlMessageLoadingDotsState extends State<DlMessageLoadingDots> {
  Timer? _timer;
  int _phase = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.stepDuration, (_) {
      if (!mounted) return;
      setState(() => _phase = (_phase + 1) % 3);
    });
  }

  @override
  void didUpdateWidget(covariant DlMessageLoadingDots oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stepDuration != widget.stepDuration) {
      _timer?.cancel();
      _timer = Timer.periodic(widget.stepDuration, (_) {
        if (!mounted) return;
        setState(() => _phase = (_phase + 1) % 3);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final palette = [colors.grey.c300, colors.grey.c400, colors.grey.c500];
    final dotColors = [
      palette[(0 - _phase) % 3],
      palette[(1 - _phase) % 3],
      palette[(2 - _phase) % 3],
    ];

    return Row(
      key: const Key('dl_message_loading_dots'),
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(0, dotColors[0]),
        const SizedBox(width: DlSpacingTokens.p_8),
        _buildDot(1, dotColors[1]),
        const SizedBox(width: DlSpacingTokens.p_8),
        _buildDot(2, dotColors[2]),
      ],
    );
  }

  Widget _buildDot(int index, Color color) {
    return Container(
      key: Key('dl_message_loading_dot_$index'),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
      ),
    );
  }
}
