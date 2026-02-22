import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const buttonA = DlButton(label: 'Button A', onPressed: null);
  const buttonB = DlButton(label: 'Button B', onPressed: null);

  Future<void> pumpDock(
    WidgetTester tester, {
    required DlButtonDock dock,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(
          body: Center(child: SizedBox(width: 320, child: dock)),
        ),
      ),
    );
  }

  testWidgets('renders full width container with top separator', (
    tester,
  ) async {
    await pumpDock(tester, dock: DlButtonDock(buttons: const [buttonA]));

    final size = tester.getSize(
      find.byKey(const Key('dl_button_dock_container')),
    );
    expect(size.width, 320);
    expect(find.byType(DlSeparator), findsOneWidget);
  });

  testWidgets('can hide separator', (tester) async {
    await pumpDock(
      tester,
      dock: DlButtonDock(buttons: const [buttonA], showSeparator: false),
    );

    expect(find.byType(DlSeparator), findsNothing);
  });

  testWidgets('renders as many buttons as provided', (tester) async {
    await pumpDock(
      tester,
      dock: DlButtonDock(buttons: const [buttonA, buttonB]),
    );

    expect(find.text('Button A'), findsOneWidget);
    expect(find.text('Button B'), findsOneWidget);
  });

  testWidgets('supports vertical direction', (tester) async {
    await pumpDock(
      tester,
      dock: DlButtonDock(
        buttons: const [buttonA, buttonB],
        direction: Axis.vertical,
      ),
    );

    final flex = tester.widget<Flex>(
      find.byKey(const Key('dl_button_dock_buttons')),
    );
    expect(flex.direction, Axis.vertical);
  });

  testWidgets('uses p16 gap and forces fullWidth on dock buttons', (
    tester,
  ) async {
    await pumpDock(
      tester,
      dock: DlButtonDock(buttons: const [buttonA, buttonB]),
    );

    final flex = tester.widget<Flex>(
      find.byKey(const Key('dl_button_dock_buttons')),
    );
    expect(flex.spacing, DlSpacingTokens.p_16);

    final buttons = tester.widgetList<DlButton>(find.byType(DlButton)).toList();
    expect(buttons.length, 2);
    expect(buttons.every((button) => button.fullWidth), isTrue);
  });
}
