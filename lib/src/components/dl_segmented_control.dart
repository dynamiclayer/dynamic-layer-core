/// DlSegmentedControl — Usage rules:
/// - A pill-shaped tab bar with a grey background. The active tab is highlighted
///   with a white pill. Always takes the full width of its parent container.
/// - Use for 3 or fewer options only. For more than 3 options, use
///   DlTabControl instead.
/// - Use to switch between different content sections or views on the same screen.
///   Pair with an IndexedStack or conditional content below the control.
/// - Each tab can have an optional badge (e.g. DlBadge) shown next to the label.
/// - The first enabled tab is automatically selected on initialization.
/// - Individual tabs can be disabled via DlSegmentedControlTabState.disabled.
/// - onTabChanged fires with the selected tab index when the user switches tabs.
/// - No size variants — one consistent appearance.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlSegmentedControlTabState { defaultState, disabled }

class DlSegmentedControlTab {
  const DlSegmentedControlTab({
    required this.label,
    this.state = DlSegmentedControlTabState.defaultState,
    this.badge,
  });

  final String label;
  final DlSegmentedControlTabState state;
  final Widget? badge;
}

class DlSegmentedControl extends StatefulWidget {
  DlSegmentedControl({
    required this.tabs,
    super.key,
    this.onTabChanged,
  }) : assert(tabs.isNotEmpty, 'tabs must not be empty.');

  final List<DlSegmentedControlTab> tabs;
  final ValueChanged<int>? onTabChanged;

  @override
  State<DlSegmentedControl> createState() => _DlSegmentedControlState();
}

class _DlSegmentedControlState extends State<DlSegmentedControl> {
  int? _activeIndex;

  @override
  void initState() {
    super.initState();
    _activeIndex = _firstEnabledIndex();
  }

  @override
  void didUpdateWidget(covariant DlSegmentedControl oldWidget) {
    super.didUpdateWidget(oldWidget);
    final current = _activeIndex;
    final isCurrentOutOfRange = current != null && current >= widget.tabs.length;
    final isCurrentDisabled = current != null && _isDisabled(current);
    if (isCurrentOutOfRange || isCurrentDisabled) {
      setState(() => _activeIndex = _firstEnabledIndex());
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return Container(
      key: const Key('dl_segmented_control'),
      width: double.infinity,
      padding: const EdgeInsets.all(DlSpacingTokens.p_4),
      decoration: BoxDecoration(
        color: colors.grey.c100,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: List.generate(widget.tabs.length, _buildTab),
      ),
    );
  }

  Widget _buildTab(int index) {
    final colors = context.dlColors;
    final tab = widget.tabs[index];
    final isDisabled = _isDisabled(index);
    final isActive = !isDisabled && _activeIndex == index;

    return Expanded(
      child: GestureDetector(
        key: Key('dl_segmented_control_tab_tap_$index'),
        behavior: HitTestBehavior.translucent,
        onTap: isDisabled ? null : () => _setActiveIndex(index),
        child: Container(
          key: Key('dl_segmented_control_tab_$index'),
          padding: const EdgeInsets.symmetric(
            horizontal: DlSpacingTokens.p_16,
            vertical: DlSpacingTokens.p_4,
          ),
          decoration: BoxDecoration(
            color: isActive ? colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Text(
                  tab.label,
                  key: Key('dl_segmented_control_tab_label_$index'),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _textStyle(
                    colors,
                    isActive: isActive,
                    isDisabled: isDisabled,
                  ),
                ),
              ),
              if (tab.badge != null) ...[
                SizedBox(
                  key: Key('dl_segmented_control_tab_gap_$index'),
                  width: DlSpacingTokens.p_8,
                ),
                tab.badge!,
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _setActiveIndex(int index) {
    if (_activeIndex == index) return;
    HapticFeedback.mediumImpact();
    setState(() => _activeIndex = index);
    widget.onTabChanged?.call(index);
  }

  int? _firstEnabledIndex() {
    for (var i = 0; i < widget.tabs.length; i++) {
      if (!_isDisabled(i)) return i;
    }
    return null;
  }

  bool _isDisabled(int index) {
    return widget.tabs[index].state == DlSegmentedControlTabState.disabled;
  }

  TextStyle _textStyle(
    DlColorPalette colors, {
    required bool isActive,
    required bool isDisabled,
  }) {
    if (isDisabled) {
      return DlTextStyles.textBase.regular.copyWith(color: colors.grey.c300);
    }
    return DlTextStyles.textBase.semiBold.copyWith(
      color: isActive ? colors.black : colors.grey.c500,
    );
  }
}
