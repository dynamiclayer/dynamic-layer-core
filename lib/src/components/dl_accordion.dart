import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';
import 'dl_separator.dart';

enum DlAccordionState { defaultState, disabled }

class DlAccordion extends StatefulWidget {
  const DlAccordion({
    required this.title,
    required this.content,
    super.key,
    this.showSeparator = true,
    this.state = DlAccordionState.defaultState,
  });

  final String title;
  final String content;
  final bool showSeparator;
  final DlAccordionState state;

  @override
  State<DlAccordion> createState() => _DlAccordionState();
}

class _DlAccordionState extends State<DlAccordion> {
  bool _isExpanded = false;

  bool get _isDisabled => widget.state == DlAccordionState.disabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final titleColor = _isDisabled ? colors.grey.c500 : colors.black;
    final iconColor = _isDisabled ? colors.grey.c500 : colors.black;
    final titleStyle = _isDisabled
        ? DlTextStyles.textBase.strike
        : DlTextStyles.textBase.medium;

    return Container(
      key: const Key('dl_accordion_container'),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedLg),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _isDisabled ? null : _toggle,
              borderRadius: BorderRadius.circular(DlRadiusTokens.roundedLg),
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: DlSpacingTokens.p_12,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          key: const Key('dl_accordion_title'),
                          style: titleStyle.copyWith(color: titleColor),
                        ),
                      ),
                      const SizedBox(width: DlSpacingTokens.p_16),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        key: const Key('dl_accordion_icon'),
                        color: iconColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(bottom: DlSpacingTokens.p_12),
              child: Text(
                widget.content,
                key: const Key('dl_accordion_content'),
                style: DlTextStyles.textBase.regular.copyWith(
                  color: colors.black,
                ),
              ),
            ),
          if (widget.showSeparator) const DlSeparator(),
        ],
      ),
    );
  }

  void _toggle() {
    final next = !_isExpanded;
    setState(() => _isExpanded = next);
  }
}
