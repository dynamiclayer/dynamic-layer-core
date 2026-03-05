import 'package:flutter/material.dart';

import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlCalendarItemState { defaultState, select, active, unselect, disabled }

class DlCalendarItemData {
  const DlCalendarItemData({
    required this.label,
    this.state = DlCalendarItemState.defaultState,
    this.price,
  });

  final String label;
  final DlCalendarItemState state;
  final String? price;
}

class DlCalendar extends StatelessWidget {
  const DlCalendar({
    required List<DlCalendarItemData> items,
    super.key,
  }) : _resolvedItems = items;

  DlCalendar.month({
    required int year,
    required int month,
    super.key,
    int? initialStartDay,
    int? initialEndDay,
    Set<int> disabledDays = const {},
    Map<int, String> pricesByDay = const {},
  }) : _resolvedItems = _buildMonthItems(
         year: year,
         month: month,
         initialStartDay: initialStartDay,
         initialEndDay: initialEndDay,
         disabledDays: disabledDays,
         pricesByDay: pricesByDay,
       );

  final List<DlCalendarItemData> _resolvedItems;

  @override
  Widget build(BuildContext context) => _DlCalendarBody(items: _resolvedItems);

  static List<DlCalendarItemData> _buildMonthItems({
    required int year,
    required int month,
    required int? initialStartDay,
    required int? initialEndDay,
    required Set<int> disabledDays,
    required Map<int, String> pricesByDay,
  }) {
    final firstDayOfMonth = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;

    final leadingUnselectCount = firstDayOfMonth.weekday % 7;
    final totalCells = (((leadingUnselectCount + daysInMonth) / 7).ceil()) * 7;
    final trailingUnselectCount = totalCells - leadingUnselectCount - daysInMonth;

    final sortedRange = [initialStartDay, initialEndDay].whereType<int>().toList()..sort();
    final hasRange = sortedRange.length == 2;
    final rangeStart = hasRange ? sortedRange.first : null;
    final rangeEnd = hasRange ? sortedRange.last : null;

    final items = <DlCalendarItemData>[];

    final previousMonthLastDay = DateTime(year, month, 0).day;
    for (var i = 0; i < leadingUnselectCount; i++) {
      final day = previousMonthLastDay - leadingUnselectCount + i + 1;
      items.add(
        DlCalendarItemData(
          label: '$day',
          state: DlCalendarItemState.unselect,
        ),
      );
    }

    for (var day = 1; day <= daysInMonth; day++) {
      final isDisabled = disabledDays.contains(day);
      DlCalendarItemState state;
      if (isDisabled) {
        state = DlCalendarItemState.disabled;
      } else if (hasRange && day == rangeStart) {
        state = DlCalendarItemState.active;
      } else if (hasRange && day == rangeEnd) {
        state = DlCalendarItemState.active;
      } else if (hasRange && day > rangeStart! && day < rangeEnd!) {
        state = DlCalendarItemState.select;
      } else if (initialStartDay != null && day == initialStartDay) {
        state = DlCalendarItemState.active;
      } else {
        state = DlCalendarItemState.defaultState;
      }

      items.add(
        DlCalendarItemData(
          label: '$day',
          state: state,
          price: pricesByDay[day],
        ),
      );
    }

    for (var day = 1; day <= trailingUnselectCount; day++) {
      items.add(
        DlCalendarItemData(
          label: '$day',
          state: DlCalendarItemState.unselect,
        ),
      );
    }

    return items;
  }
}

class _DlCalendarBody extends StatefulWidget {
  const _DlCalendarBody({
    required this.items,
  });

  final List<DlCalendarItemData> items;

  @override
  State<_DlCalendarBody> createState() => _DlCalendarBodyState();
}

class _DlCalendarBodyState extends State<_DlCalendarBody> {
  late List<DlCalendarItemState> _states;

  @override
  void initState() {
    super.initState();
    _states = widget.items.map((item) => item.state).toList(growable: false);
    _normalizeRangeSelection();
  }

  @override
  void didUpdateWidget(covariant _DlCalendarBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _states = widget.items.map((item) => item.state).toList(growable: false);
      _normalizeRangeSelection();
    }
  }

  void _handleTap(int index) {
    final currentState = _states[index];
    if (currentState == DlCalendarItemState.unselect ||
        currentState == DlCalendarItemState.disabled) {
      return;
    }

    final activeIndices = _activeIndices()..sort();

    if (currentState == DlCalendarItemState.active) {
      if (activeIndices.length == 2) {
        setState(() {
          for (var i = 0; i < _states.length; i++) {
            if (i == index) {
              _states[i] = DlCalendarItemState.active;
            } else if (_states[i] == DlCalendarItemState.active ||
                _states[i] == DlCalendarItemState.select) {
              _states[i] = DlCalendarItemState.defaultState;
            }
          }
        });
      } else if (activeIndices.length == 1) {
        setState(() {
          for (var i = 0; i < _states.length; i++) {
            if (_states[i] == DlCalendarItemState.active ||
                _states[i] == DlCalendarItemState.select) {
              _states[i] = DlCalendarItemState.defaultState;
            }
          }
        });
      }
      return;
    }

    if (activeIndices.length == 2) {
      final left = activeIndices.first;
      final right = activeIndices.last;

      setState(() {
        if (index > right) {
          _states[right] = DlCalendarItemState.select;
          _states[index] = DlCalendarItemState.active;
        } else if (index < left) {
          _states[left] = DlCalendarItemState.select;
          _states[index] = DlCalendarItemState.active;
        } else {
          final distanceToLeft = (index - left).abs();
          final distanceToRight = (right - index).abs();
          if (distanceToLeft <= distanceToRight) {
            _states[left] = DlCalendarItemState.select;
            _states[index] = DlCalendarItemState.active;
          } else {
            _states[right] = DlCalendarItemState.select;
            _states[index] = DlCalendarItemState.active;
          }
        }
        _normalizeRangeSelection();
      });
      return;
    }

    if (activeIndices.isEmpty) {
      setState(() {
        _states[index] = DlCalendarItemState.active;
      });
      return;
    }

    if (activeIndices.length == 1) {
      setState(() {
        _states[index] = DlCalendarItemState.active;
        _normalizeRangeSelection();
      });
      return;
    }

    setState(() {
      _states[index] = DlCalendarItemState.active;
    });
  }

  List<int> _activeIndices() {
    final indices = <int>[];
    for (var i = 0; i < _states.length; i++) {
      if (_states[i] == DlCalendarItemState.active) {
        indices.add(i);
      }
    }
    return indices;
  }

  void _normalizeRangeSelection() {
    for (var i = 0; i < _states.length; i++) {
      if (_states[i] == DlCalendarItemState.select) {
        _states[i] = DlCalendarItemState.defaultState;
      }
    }

    final activeIndices = _activeIndices()..sort();
    if (activeIndices.length < 2) return;

    final keep = activeIndices.take(2).toList();
    for (var i = 2; i < activeIndices.length; i++) {
      _states[activeIndices[i]] = DlCalendarItemState.defaultState;
    }

    final start = keep.first;
    final end = keep.last;
    for (var i = start + 1; i < end; i++) {
      if (_states[i] == DlCalendarItemState.defaultState) {
        _states[i] = DlCalendarItemState.select;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : 48.0 * 7;
        final itemSize = availableWidth / 7;

        return SizedBox(
          key: const Key('dl_calendar'),
          width: availableWidth,
          child: Wrap(
            spacing: 0,
            runSpacing: DlSpacingTokens.p_8,
            children: [
              for (var index = 0; index < widget.items.length; index++)
                DlCalendarItem(
                  key: Key('dl_calendar_item_$index'),
                  label: widget.items[index].label,
                  state: _states[index],
                  price: widget.items[index].price,
                  connectLeft: _shouldConnectLeft(index),
                  connectRight: _shouldConnectRight(index),
                  fillGapLeftWithGrey: _shouldFillGapLeftWithGrey(index),
                  fillGapRightWithGrey: _shouldFillGapRightWithGrey(index),
                  size: itemSize,
                  onTap: () => _handleTap(index),
                ),
            ],
          ),
        );
      },
    );
  }

  bool _isRangeFilledState(DlCalendarItemState state) =>
      state == DlCalendarItemState.active || state == DlCalendarItemState.select;

  bool _shouldConnectLeft(int index) {
    if (index % 7 == 0) return false;
    if (_states[index] == DlCalendarItemState.active) return false;
    return _isRangeFilledState(_states[index]) && _isRangeFilledState(_states[index - 1]);
  }

  bool _shouldConnectRight(int index) {
    if (index % 7 == 6 || index == _states.length - 1) return false;
    if (_states[index] == DlCalendarItemState.active) return false;
    return _isRangeFilledState(_states[index]) && _isRangeFilledState(_states[index + 1]);
  }

  bool _shouldFillGapLeftWithGrey(int index) {
    if (index % 7 == 0) return false;
    return _states[index] == DlCalendarItemState.active &&
        _states[index - 1] == DlCalendarItemState.select;
  }

  bool _shouldFillGapRightWithGrey(int index) {
    if (index % 7 == 6 || index == _states.length - 1) return false;
    return _states[index] == DlCalendarItemState.active &&
        _states[index + 1] == DlCalendarItemState.select;
  }
}

class DlCalendarItem extends StatelessWidget {
  const DlCalendarItem({
    required this.label,
    super.key,
    this.state = DlCalendarItemState.defaultState,
    this.price,
    this.connectLeft = false,
    this.connectRight = false,
    this.fillGapLeftWithGrey = false,
    this.fillGapRightWithGrey = false,
    this.size = 48,
    this.onTap,
  });

  final String label;
  final DlCalendarItemState state;
  final String? price;
  final bool connectLeft;
  final bool connectRight;
  final bool fillGapLeftWithGrey;
  final bool fillGapRightWithGrey;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final bg = _backgroundColor(colors);
    final connectWidth = size / 2;
    final roundedRadius = BorderRadius.circular(DlRadiusTokens.roundedMd);
    final greyFillColor = colors.grey.c100;

    return GestureDetector(
      key: const Key('dl_calendar_item_tap'),
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        key: const Key('dl_calendar_item'),
        width: size,
        height: size,
        child: Stack(
          children: [
            if (connectLeft)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: connectWidth,
                child: ColoredBox(
                  key: const Key('dl_calendar_item_connect_left'),
                  color: bg,
                ),
              ),
            if (fillGapLeftWithGrey)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: connectWidth,
                child: ColoredBox(
                  key: const Key('dl_calendar_item_gap_fill_left'),
                  color: greyFillColor,
                ),
              ),
            if (connectRight)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: connectWidth,
                child: ColoredBox(
                  key: const Key('dl_calendar_item_connect_right'),
                  color: bg,
                ),
              ),
            if (fillGapRightWithGrey)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: connectWidth,
                child: ColoredBox(
                  key: const Key('dl_calendar_item_gap_fill_right'),
                  color: greyFillColor,
                ),
              ),
            Positioned.fill(
              child: DecoratedBox(
                key: const Key('dl_calendar_item_surface'),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: roundedRadius,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      key: const Key('dl_calendar_item_text'),
                      style: DlTextStyles.textBase.medium.copyWith(
                        color: _textColor(colors),
                      ),
                    ),
                    if (price != null) ...[
                      Text(
                        price!,
                        key: const Key('dl_calendar_item_price'),
                        style: DlTextStyles.textXs.regular.copyWith(color: colors.grey.c500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _backgroundColor(DlColorPalette colors) {
    switch (state) {
      case DlCalendarItemState.defaultState:
      case DlCalendarItemState.unselect:
      case DlCalendarItemState.disabled:
        return colors.white;
      case DlCalendarItemState.select:
        return colors.grey.c100;
      case DlCalendarItemState.active:
        return colors.black;
    }
  }

  Color _textColor(DlColorPalette colors) {
    switch (state) {
      case DlCalendarItemState.defaultState:
      case DlCalendarItemState.select:
        return colors.black;
      case DlCalendarItemState.active:
        return colors.white;
      case DlCalendarItemState.unselect:
        return colors.grey.c500;
      case DlCalendarItemState.disabled:
        return colors.grey.c300;
    }
  }
}
