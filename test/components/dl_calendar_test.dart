import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpCalendar(
    WidgetTester tester, {
    required Widget child,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: child)),
      ),
    );
  }

  testWidgets('calendar item is square with centered base medium text', (tester) async {
    await pumpCalendar(
      tester,
      child: const DlCalendarItem(label: '15', size: 64),
    );

    final size = tester.getSize(find.byKey(const Key('dl_calendar_item')));
    expect(size, const Size(64, 64));

    final text = tester.widget<Text>(find.byKey(const Key('dl_calendar_item_text')));
    expect(text.style?.fontWeight, DlTextStyles.textBase.medium.fontWeight);
    expect(text.style?.color, DlColorsLight.black);
  });

  testWidgets('calendar item supports optional price below day number', (tester) async {
    await pumpCalendar(
      tester,
      child: const DlCalendarItem(
        label: '15',
        price: '\$199',
      ),
    );

    final price = tester.widget<Text>(find.byKey(const Key('dl_calendar_item_price')));
    expect(price.data, '\$199');
    expect(price.style?.fontWeight, DlTextStyles.textXs.regular.fontWeight);
    expect(price.style?.color, DlColorsLight.grey500);
  });

  testWidgets('calendar item state colors match specification', (tester) async {
    const cases = [
      (DlCalendarItemState.defaultState, DlColorsLight.white, DlColorsLight.black),
      (DlCalendarItemState.select, DlColorsLight.grey100, DlColorsLight.black),
      (DlCalendarItemState.active, DlColorsLight.black, DlColorsLight.white),
      (DlCalendarItemState.unselect, DlColorsLight.white, DlColorsLight.grey500),
      (DlCalendarItemState.disabled, DlColorsLight.white, DlColorsLight.grey300),
    ];

    for (final testCase in cases) {
      await pumpCalendar(
        tester,
        child: DlCalendarItem(label: '1', state: testCase.$1),
      );

      final surface = tester.widget<DecoratedBox>(
        find.byKey(const Key('dl_calendar_item_surface')),
      );
      final text = tester.widget<Text>(find.byKey(const Key('dl_calendar_item_text')));
      final surfaceDecoration = surface.decoration as BoxDecoration;

      expect(surfaceDecoration.color, testCase.$2);
      expect(text.style?.color, testCase.$3);
    }
  });

  testWidgets('calendar fills width and has p8 gap between date rows', (tester) async {
    await pumpCalendar(
      tester,
      child: const SizedBox(
        width: 350,
        child: DlCalendar(
          items: [
            DlCalendarItemData(label: '1'),
            DlCalendarItemData(label: '2'),
            DlCalendarItemData(label: '3'),
            DlCalendarItemData(label: '4'),
            DlCalendarItemData(label: '5'),
            DlCalendarItemData(label: '6'),
            DlCalendarItemData(label: '7'),
            DlCalendarItemData(label: '8'),
          ],
        ),
      ),
    );

    final calendarSize = tester.getSize(find.byKey(const Key('dl_calendar')));
    expect(calendarSize.width, 350);

    final firstItemSize = tester.getSize(find.byKey(const Key('dl_calendar_item_0')));
    expect(firstItemSize.width, closeTo(50, 0.001));
    expect(firstItemSize.height, closeTo(50, 0.001));

    final firstItemTopLeft = tester.getTopLeft(find.byKey(const Key('dl_calendar_item_0')));
    final seventhItemTopLeft = tester.getTopLeft(find.byKey(const Key('dl_calendar_item_6')));
    final eighthItemTopLeft = tester.getTopLeft(find.byKey(const Key('dl_calendar_item_7')));

    expect(seventhItemTopLeft.dy, firstItemTopLeft.dy);
    expect(
      eighthItemTopLeft.dy - firstItemTopLeft.dy,
      closeTo(50 + DlSpacingTokens.p_8, 0.001),
    );
  });

  testWidgets('month constructor auto-generates month grid items', (tester) async {
    await pumpCalendar(
      tester,
      child: SizedBox(
        width: 350,
        child: DlCalendar.month(
          year: 2026,
          month: 2,
          initialStartDay: 10,
          initialEndDay: 16,
          disabledDays: {27, 28},
          pricesByDay: {10: '\$180'},
        ),
      ),
    );

    expect(find.byKey(const Key('dl_calendar_item_0')), findsOneWidget);
    expect(find.byKey(const Key('dl_calendar_item_27')), findsOneWidget); // 28 cells
    expect(find.byKey(const Key('dl_calendar_item_28')), findsNothing);

    expect(find.text('10'), findsWidgets);
    expect(find.text('\$180'), findsOneWidget);
  });

  testWidgets('tapping default item changes it to active', (tester) async {
    await pumpCalendar(
      tester,
      child: const DlCalendar(
        items: [
          DlCalendarItemData(label: '1', state: DlCalendarItemState.defaultState),
        ],
      ),
    );

    Text itemText() => tester.widget<Text>(
      find.descendant(
        of: find.byKey(const Key('dl_calendar_item_0')),
        matching: find.byKey(const Key('dl_calendar_item_text')),
      ),
    );

    expect(itemText().style?.color, DlColorsLight.black);
    await tester.tap(find.byKey(const Key('dl_calendar_item_0')));
    await tester.pump();
    expect(itemText().style?.color, DlColorsLight.white);
  });

  testWidgets('select state stays only between two active items', (tester) async {
    await pumpCalendar(
      tester,
      child: const DlCalendar(
        items: [
          DlCalendarItemData(label: '1', state: DlCalendarItemState.defaultState),
          DlCalendarItemData(label: '2', state: DlCalendarItemState.defaultState),
          DlCalendarItemData(label: '3', state: DlCalendarItemState.defaultState),
          DlCalendarItemData(label: '4', state: DlCalendarItemState.defaultState),
        ],
      ),
    );

    Future<void> tapIndex(int index) async {
      await tester.tap(find.byKey(Key('dl_calendar_item_$index')));
      await tester.pump();
    }

    Color textColorAt(int index) {
      final text = tester.widget<Text>(
        find.descendant(
          of: find.byKey(Key('dl_calendar_item_$index')),
          matching: find.byKey(const Key('dl_calendar_item_text')),
        ),
      );
      return text.style!.color!;
    }

    Color itemBackgroundAt(int index) {
      final surface = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(Key('dl_calendar_item_$index')),
          matching: find.byKey(const Key('dl_calendar_item_surface')),
        ),
      );
      return (surface.decoration as BoxDecoration).color!;
    }

    await tapIndex(0);
    await tapIndex(3);

    expect(textColorAt(0), DlColorsLight.white); // active
    expect(textColorAt(3), DlColorsLight.white); // active
    expect(itemBackgroundAt(1), DlColorsLight.grey100); // select
    expect(itemBackgroundAt(2), DlColorsLight.grey100); // select
  });

  testWidgets('tapping select item promotes it to active', (tester) async {
    await pumpCalendar(
      tester,
      child: const DlCalendar(
        items: [
          DlCalendarItemData(label: '1', state: DlCalendarItemState.defaultState),
          DlCalendarItemData(label: '2', state: DlCalendarItemState.defaultState),
          DlCalendarItemData(label: '3', state: DlCalendarItemState.defaultState),
          DlCalendarItemData(label: '4', state: DlCalendarItemState.defaultState),
        ],
      ),
    );

    Future<void> tapIndex(int index) async {
      await tester.tap(find.byKey(Key('dl_calendar_item_$index')));
      await tester.pump();
    }

    Color itemBackgroundAt(int index) {
      final surface = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(Key('dl_calendar_item_$index')),
          matching: find.byKey(const Key('dl_calendar_item_surface')),
        ),
      );
      return (surface.decoration as BoxDecoration).color!;
    }

    await tapIndex(0);
    await tapIndex(3);
    expect(itemBackgroundAt(1), DlColorsLight.grey100); // select

    await tapIndex(1); // tap select -> should become active
    expect(itemBackgroundAt(1), DlColorsLight.black); // active
  });

  testWidgets(
    'when range exists and tapping after right active shifts range end',
    (tester) async {
      await pumpCalendar(
        tester,
        child: DlCalendar(
          items: List.generate(
            20,
            (index) => DlCalendarItemData(
              label: '${index + 1}',
              state: switch (index + 1) {
                6 => DlCalendarItemState.active,
                7 || 8 || 9 || 10 || 11 || 12 || 13 => DlCalendarItemState.select,
                14 => DlCalendarItemState.active,
                _ => DlCalendarItemState.defaultState,
              },
            ),
          ),
        ),
      );

      Color itemBackgroundAt(int index) {
        final surface = tester.widget<DecoratedBox>(
          find.descendant(
            of: find.byKey(Key('dl_calendar_item_$index')),
            matching: find.byKey(const Key('dl_calendar_item_surface')),
          ),
        );
        return (surface.decoration as BoxDecoration).color!;
      }

      await tester.tap(find.byKey(const Key('dl_calendar_item_14'))); // label 15
      await tester.pump();

      expect(itemBackgroundAt(5), DlColorsLight.black); // 6 active
      expect(itemBackgroundAt(13), DlColorsLight.grey100); // 14 becomes select
      expect(itemBackgroundAt(14), DlColorsLight.black); // 15 active
    },
  );

  testWidgets('active item fills edge gaps with grey near select items', (tester) async {
    await pumpCalendar(
      tester,
      child: const DlCalendar(
        items: [
          DlCalendarItemData(label: '1', state: DlCalendarItemState.active),
          DlCalendarItemData(label: '2', state: DlCalendarItemState.select),
          DlCalendarItemData(label: '3', state: DlCalendarItemState.select),
          DlCalendarItemData(label: '4', state: DlCalendarItemState.active),
        ],
      ),
    );

    final firstActiveRightGap = find.descendant(
      of: find.byKey(const Key('dl_calendar_item_0')),
      matching: find.byKey(const Key('dl_calendar_item_gap_fill_right')),
    );
    final secondActiveLeftGap = find.descendant(
      of: find.byKey(const Key('dl_calendar_item_3')),
      matching: find.byKey(const Key('dl_calendar_item_gap_fill_left')),
    );

    expect(firstActiveRightGap, findsOneWidget);
    expect(secondActiveLeftGap, findsOneWidget);
  });

  testWidgets(
    'when range exists and tapping before left active shifts range start',
    (tester) async {
      await pumpCalendar(
        tester,
        child: DlCalendar(
          items: List.generate(
            20,
            (index) => DlCalendarItemData(
              label: '${index + 1}',
              state: switch (index + 1) {
                6 => DlCalendarItemState.active,
                7 || 8 || 9 || 10 || 11 || 12 || 13 => DlCalendarItemState.select,
                14 => DlCalendarItemState.active,
                _ => DlCalendarItemState.defaultState,
              },
            ),
          ),
        ),
      );

      Color itemBackgroundAt(int index) {
        final surface = tester.widget<DecoratedBox>(
          find.descendant(
            of: find.byKey(Key('dl_calendar_item_$index')),
            matching: find.byKey(const Key('dl_calendar_item_surface')),
          ),
        );
        return (surface.decoration as BoxDecoration).color!;
      }

      await tester.tap(find.byKey(const Key('dl_calendar_item_4'))); // label 5
      await tester.pump();

      expect(itemBackgroundAt(4), DlColorsLight.black); // 5 active
      expect(itemBackgroundAt(5), DlColorsLight.grey100); // 6 becomes select
      expect(itemBackgroundAt(13), DlColorsLight.black); // 14 stays active
    },
  );

  testWidgets(
    'when two actives exist tapping one active keeps only tapped active',
    (tester) async {
      await pumpCalendar(
        tester,
        child: DlCalendar(
          items: List.generate(
            20,
            (index) => DlCalendarItemData(
              label: '${index + 1}',
              state: switch (index + 1) {
                8 => DlCalendarItemState.active,
                9 || 10 || 11 || 12 || 13 || 14 || 15 => DlCalendarItemState.select,
                16 => DlCalendarItemState.active,
                _ => DlCalendarItemState.defaultState,
              },
            ),
          ),
        ),
      );

      Color itemBackgroundAt(int index) {
        final surface = tester.widget<DecoratedBox>(
          find.descendant(
            of: find.byKey(Key('dl_calendar_item_$index')),
            matching: find.byKey(const Key('dl_calendar_item_surface')),
          ),
        );
        return (surface.decoration as BoxDecoration).color!;
      }

      await tester.tap(find.byKey(const Key('dl_calendar_item_7'))); // label 8
      await tester.pump();

      expect(itemBackgroundAt(7), DlColorsLight.black); // 8 active
      expect(itemBackgroundAt(8), DlColorsLight.white); // 9 default
      expect(itemBackgroundAt(15), DlColorsLight.white); // 16 default
    },
  );

  testWidgets(
    'tapping remaining single active clears all active/select states',
    (tester) async {
      await pumpCalendar(
        tester,
        child: DlCalendar(
          items: List.generate(
            20,
            (index) => DlCalendarItemData(
              label: '${index + 1}',
              state: switch (index + 1) {
                6 => DlCalendarItemState.active,
                7 || 8 || 9 || 10 || 11 || 12 || 13 => DlCalendarItemState.select,
                14 => DlCalendarItemState.active,
                _ => DlCalendarItemState.defaultState,
              },
            ),
          ),
        ),
      );

      Color itemBackgroundAt(int index) {
        final surface = tester.widget<DecoratedBox>(
          find.descendant(
            of: find.byKey(Key('dl_calendar_item_$index')),
            matching: find.byKey(const Key('dl_calendar_item_surface')),
          ),
        );
        return (surface.decoration as BoxDecoration).color!;
      }

      await tester.tap(find.byKey(const Key('dl_calendar_item_5'))); // label 6
      await tester.pump();
      expect(itemBackgroundAt(5), DlColorsLight.black); // 6 active
      expect(itemBackgroundAt(6), DlColorsLight.white); // 7 default
      expect(itemBackgroundAt(13), DlColorsLight.white); // 14 default

      await tester.tap(find.byKey(const Key('dl_calendar_item_5'))); // label 6 again
      await tester.pump();
      expect(itemBackgroundAt(5), DlColorsLight.white); // no active anymore
      expect(itemBackgroundAt(6), DlColorsLight.white); // no select
      expect(itemBackgroundAt(13), DlColorsLight.white); // no active
    },
  );
}
