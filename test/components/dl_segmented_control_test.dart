import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpSegmentedControl(
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

  testWidgets('renders grey100 roundedFull container with p4 padding', (tester) async {
    await pumpSegmentedControl(
      tester,
      child: DlSegmentedControl(
        tabs: const [
          DlSegmentedControlTab(label: 'One'),
          DlSegmentedControlTab(label: 'Two'),
        ],
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_segmented_control')),
    );
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;
    expect(container.padding, const EdgeInsets.all(DlSpacingTokens.p_4));
    expect(decoration.color, DlColorsLight.grey100);
    expect(radius.topLeft.x, 999);
  });

  testWidgets('first enabled tab is active by default', (tester) async {
    await pumpSegmentedControl(
      tester,
      child: DlSegmentedControl(
        tabs: const [
          DlSegmentedControlTab(label: 'One'),
          DlSegmentedControlTab(label: 'Two'),
        ],
      ),
    );

    final tab0 = tester.widget<Container>(find.byKey(const Key('dl_segmented_control_tab_0')));
    final tab1 = tester.widget<Container>(find.byKey(const Key('dl_segmented_control_tab_1')));
    final decoration0 = tab0.decoration as BoxDecoration;
    final decoration1 = tab1.decoration as BoxDecoration;

    expect(decoration0.color, DlColorsLight.white);
    expect(decoration1.color, Colors.transparent);
  });

  testWidgets('tap switches active tab and triggers callback', (tester) async {
    var selected = -1;
    await pumpSegmentedControl(
      tester,
      child: DlSegmentedControl(
        tabs: const [
          DlSegmentedControlTab(label: 'One'),
          DlSegmentedControlTab(label: 'Two'),
          DlSegmentedControlTab(label: 'Three'),
        ],
        onTabChanged: (index) => selected = index,
      ),
    );

    await tester.tap(find.byKey(const Key('dl_segmented_control_tab_tap_2')));
    await tester.pump();

    final tab2 = tester.widget<Container>(find.byKey(const Key('dl_segmented_control_tab_2')));
    final decoration2 = tab2.decoration as BoxDecoration;
    expect(decoration2.color, DlColorsLight.white);
    expect(selected, 2);
  });

  testWidgets('disabled tab uses regular grey300 and is not clickable', (tester) async {
    await pumpSegmentedControl(
      tester,
      child: DlSegmentedControl(
        tabs: const [
          DlSegmentedControlTab(label: 'One'),
          DlSegmentedControlTab(
            label: 'Two',
            state: DlSegmentedControlTabState.disabled,
          ),
          DlSegmentedControlTab(label: 'Three'),
        ],
      ),
    );

    final label = tester.widget<Text>(
      find.byKey(const Key('dl_segmented_control_tab_label_1')),
    );
    expect(label.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(label.style?.color, DlColorsLight.grey300);

    await tester.tap(find.byKey(const Key('dl_segmented_control_tab_tap_1')));
    await tester.pump();
    final tab1 = tester.widget<Container>(find.byKey(const Key('dl_segmented_control_tab_1')));
    final decoration1 = tab1.decoration as BoxDecoration;
    expect(decoration1.color, Colors.transparent);
  });

  testWidgets('supports optional badge with p8 gap between tab elements', (
    tester,
  ) async {
    await pumpSegmentedControl(
      tester,
      child: DlSegmentedControl(
        tabs: const [
          DlSegmentedControlTab(
            label: 'One',
            badge: DlBadge(size: DlBadgeSize.sm),
          ),
          DlSegmentedControlTab(label: 'Two'),
        ],
      ),
    );

    expect(find.byType(DlBadge), findsOneWidget);
    expect(find.byKey(const Key('dl_segmented_control_tab_gap_0')), findsOneWidget);
  });
}
