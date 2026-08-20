import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpRadioButton(
    WidgetTester tester, {
    DlRadioButtonState state = DlRadioButtonState.defaultState,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(
          body: Center(
            child: DlRadioButton(state: state),
          ),
        ),
      ),
    );
  }

  testWidgets('renders 24x24 outer size and 22x22 inner box', (tester) async {
    await pumpRadioButton(tester);

    final outerSize = tester.getSize(find.byKey(const Key('dl_radio_button_outer')));
    final innerSize = tester.getSize(find.byKey(const Key('dl_radio_button_inner')));

    expect(outerSize.width, 24);
    expect(outerSize.height, 24);
    expect(innerSize.width, 22);
    expect(innerSize.height, 22);
  });

  testWidgets('default state uses white background, grey200 border, roundedFull', (
    tester,
  ) async {
    await pumpRadioButton(tester, state: DlRadioButtonState.defaultState);

    final inner = tester.widget<Container>(
      find.byKey(const Key('dl_radio_button_inner')),
    );
    final decoration = inner.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;
    final border = decoration.border as Border;

    expect(decoration.color, DlColorsLight.white);
    expect(radius.topLeft.x, DlRadiusTokens.roundedFull);
    expect(border.top.color, DlColorsLight.grey200);
    expect(border.top.width, DlBorderWidthTokens.border1);
  });

  testWidgets('toggles default to active and active to default on tap', (
    tester,
  ) async {
    await pumpRadioButton(tester, state: DlRadioButtonState.defaultState);

    BoxDecoration decoration() =>
        tester
            .widget<Container>(find.byKey(const Key('dl_radio_button_inner')))
            .decoration as BoxDecoration;

    var border = decoration().border as Border;
    expect(decoration().color, DlColorsLight.white);
    expect(border.top.color, DlColorsLight.grey200);
    expect(find.byKey(const Key('dl_radio_button_active_dot')), findsNothing);

    await tester.tap(find.byKey(const Key('dl_radio_button_tap_area')));
    await tester.pump();

    border = decoration().border as Border;
    expect(decoration().color, DlColorsLight.black);
    expect(border.top.color, Colors.transparent);
    expect(find.byKey(const Key('dl_radio_button_active_dot')), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const Key('dl_radio_button_active_dot'))),
      const Size(10, 10),
    );

    await tester.tap(find.byKey(const Key('dl_radio_button_tap_area')));
    await tester.pump();

    border = decoration().border as Border;
    expect(decoration().color, DlColorsLight.white);
    expect(border.top.color, DlColorsLight.grey200);
    expect(find.byKey(const Key('dl_radio_button_active_dot')), findsNothing);
  });

  testWidgets('disabled state uses grey50 background and is not clickable', (
    tester,
  ) async {
    await pumpRadioButton(tester, state: DlRadioButtonState.disabled);

    BoxDecoration decoration() =>
        tester
            .widget<Container>(find.byKey(const Key('dl_radio_button_inner')))
            .decoration as BoxDecoration;

    var border = decoration().border as Border;
    expect(decoration().color, DlColorsLight.grey50);
    expect(border.top.color, DlColorsLight.grey200);
    expect(find.byKey(const Key('dl_radio_button_active_dot')), findsNothing);

    await tester.tap(find.byKey(const Key('dl_radio_button_tap_area')));
    await tester.pump();

    border = decoration().border as Border;
    expect(decoration().color, DlColorsLight.grey50);
    expect(border.top.color, DlColorsLight.grey200);
    expect(find.byKey(const Key('dl_radio_button_active_dot')), findsNothing);
  });
}
