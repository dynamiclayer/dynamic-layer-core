import 'package:flutter/material.dart';

import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';

class DlPagination extends StatefulWidget {
  const DlPagination({
    required this.count,
    super.key,
    this.initialIndex = 0,
    this.onChanged,
    this.selectedDotColor,
    this.unselectedDotColor,
  }) : assert(count > 0, 'count must be greater than 0'),
       assert(initialIndex >= 0, 'initialIndex must be >= 0'),
       assert(initialIndex < count, 'initialIndex must be smaller than count');

  final int count;
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final Color? selectedDotColor;
  final Color? unselectedDotColor;

  @override
  State<DlPagination> createState() => _DlPaginationState();
}

class _DlPaginationState extends State<DlPagination> {
  static const int _unselectedAlpha = 102; // 40%
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('dl_pagination_row'),
      mainAxisSize: MainAxisSize.min,
      children: _buildItems(context),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    final colors = context.dlColors;
    final selectedColor = widget.selectedDotColor ?? colors.black;
    final unselectedColor =
        widget.unselectedDotColor ?? colors.black.withAlpha(_unselectedAlpha);

    return List.generate(widget.count * 2 - 1, (index) {
      if (index.isOdd) {
        return const SizedBox(width: DlSpacingTokens.p_4);
      }

      final itemIndex = index ~/ 2;
      final isSelected = itemIndex == _selectedIndex;
      final dotColor = isSelected ? selectedColor : unselectedColor;

      return GestureDetector(
        key: Key('dl_pagination_item_$itemIndex'),
        behavior: HitTestBehavior.translucent,
        onTap: () => _select(itemIndex),
        child: SizedBox(
          width: 12,
          height: 12,
          child: Center(
            child: Container(
              key: Key('dl_pagination_dot_$itemIndex'),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ),
        ),
      );
    });
  }

  void _select(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    widget.onChanged?.call(index);
  }
}
