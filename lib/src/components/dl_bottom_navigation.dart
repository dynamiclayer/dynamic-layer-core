import 'package:flutter/material.dart';

import '../foundations/icons/dl_icons.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';
import 'dl_badge.dart';
import 'dl_separator.dart';

class DlBottomNavigationTab {
  const DlBottomNavigationTab({this.text, this.icon, this.badge});

  final String? text;
  final Widget? icon;
  final Widget? badge;
}

class DlBottomNavigation extends StatefulWidget {
  DlBottomNavigation({
    required this.tabs,
    super.key,
    this.onTabChanged,
    this.showSeparator = true,
    this.selectedIndex,
  }) : assert(tabs.isNotEmpty, 'tabs must not be empty.'),
       assert(
         selectedIndex == null ||
             (selectedIndex >= 0 && selectedIndex < tabs.length),
         'selectedIndex must be within tabs bounds.',
       );

  final List<DlBottomNavigationTab> tabs;
  final ValueChanged<int>? onTabChanged;
  final bool showSeparator;
  final int? selectedIndex;

  @override
  State<DlBottomNavigation> createState() => _DlBottomNavigationState();
}

class _DlBottomNavigationState extends State<DlBottomNavigation> {
  int _internalActiveIndex = 0;

  int get _effectiveActiveIndex => widget.selectedIndex ?? _internalActiveIndex;
  bool get _isControlled => widget.selectedIndex != null;

  @override
  void didUpdateWidget(covariant DlBottomNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isControlled && _internalActiveIndex >= widget.tabs.length) {
      setState(() => _internalActiveIndex = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return Container(
      key: const Key('dl_bottom_navigation'),
      width: double.infinity,
      color: colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.showSeparator)
            const DlSeparator(key: Key('dl_bottom_navigation_separator')),
          Container(
            key: const Key('dl_bottom_navigation_tabs_container'),
            color: colors.white,
            child: Row(children: List.generate(widget.tabs.length, _buildTab)),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index) {
    final colors = context.dlColors;
    final tab = widget.tabs[index];
    final isActive = index == _effectiveActiveIndex;
    final foregroundColor = isActive ? colors.black : colors.grey.c400;

    return Expanded(
      child: GestureDetector(
        key: Key('dl_bottom_navigation_tab_tap_$index'),
        behavior: HitTestBehavior.translucent,
        onTap: () => _setActiveIndex(index),
        child: Container(
          key: Key('dl_bottom_navigation_tab_$index'),
          height: 64,
          padding: const EdgeInsets.symmetric(
            horizontal: DlSpacingTokens.p_0,
            vertical: DlSpacingTokens.p_8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIconBox(tab, foregroundColor, index),
              if (tab.text != null) ...[
                const SizedBox(height: DlSpacingTokens.p_8),
                Text(
                  tab.text!,
                  key: Key('dl_bottom_navigation_tab_text_$index'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: DlTextStyles.textXs.bold.copyWith(
                    color: foregroundColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconBox(DlBottomNavigationTab tab, Color color, int index) {
    return SizedBox(
      key: Key('dl_bottom_navigation_tab_icon_box_$index'),
      width: 24,
      height: 24,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: IconTheme(
              data: IconThemeData(color: color),
              child: tab.icon ?? const DlPlaceholderIcon(size: 24),
            ),
          ),
          if (tab.badge != null)
            Positioned(
              key: Key('dl_bottom_navigation_tab_badge_position_$index'),
              top: _badgeTopOffset(tab.badge),
              right: _badgeRightOffset(tab.badge),
              child: tab.badge!,
            ),
        ],
      ),
    );
  }

  double _badgeTopOffset(Widget? badge) {
    if (badge is DlBadge && badge.size == DlBadgeSize.md) return -4;
    return 0;
  }

  double _badgeRightOffset(Widget? badge) {
    if (badge is DlBadge && badge.size == DlBadgeSize.md) return -8;
    return 0;
  }

  void _setActiveIndex(int index) {
    if (index == _effectiveActiveIndex) return;
    if (!_isControlled) {
      setState(() => _internalActiveIndex = index);
    }
    widget.onTabChanged?.call(index);
  }
}
