import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpTabControl(
    WidgetTester tester, {
    required Widget child,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: child),
      ),
    );
  }

  testWidgets('renders count tabs in one row', (tester) async {
    await pumpTabControl(
      tester,
      child: DlTabControl(
        tabs: const [
          DlTabControlTab(label: 'Tab 1'),
          DlTabControlTab(label: 'Tab 2'),
          DlTabControlTab(label: 'Tab 3'),
        ],
      ),
    );

    expect(find.byKey(const Key('dl_tab_control_tab_0')), findsOneWidget);
    expect(find.byKey(const Key('dl_tab_control_tab_1')), findsOneWidget);
    expect(find.byKey(const Key('dl_tab_control_tab_2')), findsOneWidget);
  });

  testWidgets('first tab is active by default', (tester) async {
    await pumpTabControl(
      tester,
      child: DlTabControl(
        tabs: const [
          DlTabControlTab(label: 'Tab 1'),
          DlTabControlTab(label: 'Tab 2'),
          DlTabControlTab(label: 'Tab 3'),
        ],
      ),
    );

    final tab0 = tester.widget<Container>(find.byKey(const Key('dl_tab_control_tab_0')));
    final tab1 = tester.widget<Container>(find.byKey(const Key('dl_tab_control_tab_1')));
    final tab0Border = (tab0.decoration as BoxDecoration).border! as Border;
    final tab1Border = (tab1.decoration as BoxDecoration).border! as Border;

    expect(tab0Border.bottom.color, DlColorsLight.black);
    expect(tab1Border.bottom.color, DlColorsLight.grey200);

    final label0 = tester.widget<Text>(find.byKey(const Key('dl_tab_control_tab_label_0')));
    final label1 = tester.widget<Text>(find.byKey(const Key('dl_tab_control_tab_label_1')));
    expect(label0.style?.color, DlColorsLight.black);
    expect(label1.style?.color, DlColorsLight.grey500);
  });

  testWidgets('tap changes active tab and deactivates previous', (tester) async {
    await pumpTabControl(
      tester,
      child: DlTabControl(
        tabs: const [
          DlTabControlTab(label: 'Tab 1'),
          DlTabControlTab(label: 'Tab 2'),
          DlTabControlTab(label: 'Tab 3'),
        ],
      ),
    );

    await tester.tap(find.byKey(const Key('dl_tab_control_tab_tap_2')));
    await tester.pump();

    final tab0 = tester.widget<Container>(find.byKey(const Key('dl_tab_control_tab_0')));
    final tab2 = tester.widget<Container>(find.byKey(const Key('dl_tab_control_tab_2')));
    final tab0Border = (tab0.decoration as BoxDecoration).border! as Border;
    final tab2Border = (tab2.decoration as BoxDecoration).border! as Border;

    expect(tab0Border.bottom.color, DlColorsLight.grey200);
    expect(tab2Border.bottom.color, DlColorsLight.black);
  });

  testWidgets('supports optional badges per tab', (tester) async {
    await pumpTabControl(
      tester,
      child: DlTabControl(
        tabs: const [
          DlTabControlTab(label: 'Tab 1', badge: DlBadge(size: DlBadgeSize.sm)),
          DlTabControlTab(label: 'Tab 2'),
          DlTabControlTab(label: 'Tab 3', badge: DlBadge(size: DlBadgeSize.md, value: '3')),
        ],
      ),
    );

    expect(find.byType(DlBadge), findsNWidgets(2));
  });

  testWidgets('disabled tab uses textBase regular grey300 and is not clickable', (
    tester,
  ) async {
    await pumpTabControl(
      tester,
      child: DlTabControl(
        tabs: const [
          DlTabControlTab(label: 'A'),
          DlTabControlTab(label: 'B', state: DlTabControlTabState.disabled),
          DlTabControlTab(label: 'C'),
        ],
      ),
    );

    final disabledLabel = tester.widget<Text>(
      find.byKey(const Key('dl_tab_control_tab_label_1')),
    );
    expect(disabledLabel.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(disabledLabel.style?.color, DlColorsLight.grey300);

    final beforeTab0 = tester.widget<Container>(
      find.byKey(const Key('dl_tab_control_tab_0')),
    );
    final beforeTab1 = tester.widget<Container>(
      find.byKey(const Key('dl_tab_control_tab_1')),
    );
    final beforeTab0Border = (beforeTab0.decoration as BoxDecoration).border! as Border;
    final beforeTab1Border = (beforeTab1.decoration as BoxDecoration).border! as Border;
    expect(beforeTab0Border.bottom.color, DlColorsLight.black);
    expect(beforeTab1Border.bottom.color, DlColorsLight.grey200);

    await tester.tap(find.byKey(const Key('dl_tab_control_tab_tap_1')));
    await tester.pump();

    final afterTab0 = tester.widget<Container>(
      find.byKey(const Key('dl_tab_control_tab_0')),
    );
    final afterTab1 = tester.widget<Container>(
      find.byKey(const Key('dl_tab_control_tab_1')),
    );
    final afterTab0Border = (afterTab0.decoration as BoxDecoration).border! as Border;
    final afterTab1Border = (afterTab1.decoration as BoxDecoration).border! as Border;
    expect(afterTab0Border.bottom.color, DlColorsLight.black);
    expect(afterTab1Border.bottom.color, DlColorsLight.grey200);
  });

  testWidgets('if first tab is disabled, first enabled tab becomes active', (tester) async {
    await pumpTabControl(
      tester,
      child: DlTabControl(
        tabs: const [
          DlTabControlTab(label: 'A', state: DlTabControlTabState.disabled),
          DlTabControlTab(label: 'B'),
          DlTabControlTab(label: 'C'),
        ],
      ),
    );

    final tab0 = tester.widget<Container>(find.byKey(const Key('dl_tab_control_tab_0')));
    final tab1 = tester.widget<Container>(find.byKey(const Key('dl_tab_control_tab_1')));
    final tab0Border = (tab0.decoration as BoxDecoration).border! as Border;
    final tab1Border = (tab1.decoration as BoxDecoration).border! as Border;
    expect(tab0Border.bottom.color, DlColorsLight.grey200);
    expect(tab1Border.bottom.color, DlColorsLight.black);
  });

  testWidgets('calls onTabChanged with selected index', (tester) async {
    var selectedIndex = -1;

    await pumpTabControl(
      tester,
      child: DlTabControl(
        tabs: const [
          DlTabControlTab(label: 'One'),
          DlTabControlTab(label: 'Two'),
        ],
        onTabChanged: (index) => selectedIndex = index,
      ),
    );

    await tester.tap(find.byKey(const Key('dl_tab_control_tab_tap_1')));
    await tester.pump();
    expect(selectedIndex, 1);
  });
}
