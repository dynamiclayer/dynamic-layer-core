/// DlTabControl — Usage rules:
/// - A horizontal tab bar. Tabs share the available width equally (each tab
///   is Expanded). Always takes the full width of its parent container.
/// - Use to switch between different content sections on the same screen.
///   Pair with an IndexedStack or conditional content below the tab control.
/// - Each tab can have an optional badge (e.g. DlBadge) shown next to the label.
/// - The first enabled tab is automatically selected on initialization.
/// - Individual tabs can be disabled via DlTabControlTabState.disabled.
/// - onTabChanged fires with the selected tab index when the user switches tabs.
/// - No size variants — one consistent appearance.
/// - Use DlTabControl when there are more than 3 options. For 3 or fewer
///   options, use DlSegmentedControl instead.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundations/tokens/dl_border_width_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlTabControlTabState { defaultState, disabled }

class DlTabControlTab {
  const DlTabControlTab({
    required this.label,
    this.badge,
    this.state = DlTabControlTabState.defaultState,
  });

  final String label;
  final Widget? badge;
  final DlTabControlTabState state;
}

class DlTabControl extends StatefulWidget {
  DlTabControl({
    required this.tabs,
    super.key,
    this.onTabChanged,
  }) : assert(tabs.isNotEmpty, 'tabs must not be empty.');

  final List<DlTabControlTab> tabs;
  final ValueChanged<int>? onTabChanged;

  @override
  State<DlTabControl> createState() => _DlTabControlState();
}

class _DlTabControlState extends State<DlTabControl> {
  int? _activeIndex;

  @override
  void initState() {
    super.initState();
    _activeIndex = _firstEnabledIndex();
  }

  @override
  void didUpdateWidget(covariant DlTabControl oldWidget) {
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
    return Row(
      key: const Key('dl_tab_control'),
      children: List.generate(widget.tabs.length, _buildTab),
    );
  }

  Widget _buildTab(int index) {
    final colors = context.dlColors;
    final tab = widget.tabs[index];
    final isDisabled = _isDisabled(index);
    final isActive = !isDisabled && index == _activeIndex;

    return Expanded(
      child: GestureDetector(
        key: Key('dl_tab_control_tab_tap_$index'),
        behavior: HitTestBehavior.translucent,
        onTap: isDisabled ? null : () => _setActiveIndex(index),
        child: Container(
          key: Key('dl_tab_control_tab_$index'),
          padding: const EdgeInsets.symmetric(
            horizontal: DlSpacingTokens.p_8,
            vertical: DlSpacingTokens.p_16,
          ),
          decoration: BoxDecoration(
            color: colors.white,
            border: Border(
              bottom: BorderSide(
                color: isActive ? colors.black : colors.grey.c200,
                width: DlBorderWidthTokens.border2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  tab.label,
                  key: Key('dl_tab_control_tab_label_$index'),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _textStyle(colors, isActive: isActive, isDisabled: isDisabled),
                ),
              ),
              if (tab.badge != null) ...[
                const SizedBox(width: DlSpacingTokens.p_8),
                tab.badge!,
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _setActiveIndex(int index) {
    if (index == _activeIndex) return;
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
    return widget.tabs[index].state == DlTabControlTabState.disabled;
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
