import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpCheckbox(
    WidgetTester tester, {
    DlCheckboxState state = DlCheckboxState.defaultState,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(
          body: Center(
            child: DlCheckbox(state: state),
          ),
        ),
      ),
    );
  }

  testWidgets('renders 24x24 outer size and 22x22 inner box', (tester) async {
    await pumpCheckbox(tester);

    final outerSize = tester.getSize(find.byKey(const Key('dl_checkbox_outer')));
    final innerSize = tester.getSize(find.byKey(const Key('dl_checkbox_inner')));

    expect(outerSize.width, 24);
    expect(outerSize.height, 24);
    expect(innerSize.width, 22);
    expect(innerSize.height, 22);
  });

  testWidgets('default state uses white background, grey200 border, rounded', (
    tester,
  ) async {
    await pumpCheckbox(tester, state: DlCheckboxState.defaultState);

    final inner = tester.widget<Container>(find.byKey(const Key('dl_checkbox_inner')));
    final decoration = inner.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;
    final border = decoration.border as Border;

    expect(decoration.color, DlColorsLight.white);
    expect(radius.topLeft.x, DlRadiusTokens.rounded);
    expect(border.top.color, DlColorsLight.grey200);
    expect(border.top.width, DlBorderWidthTokens.border1);
  });

  testWidgets('toggles default to active and active to default on tap', (
    tester,
  ) async {
    await pumpCheckbox(tester, state: DlCheckboxState.defaultState);

    BoxDecoration decoration() =>
        tester.widget<Container>(find.byKey(const Key('dl_checkbox_inner'))).decoration
            as BoxDecoration;

    var border = decoration().border as Border;
    expect(decoration().color, DlColorsLight.white);
    expect(border.top.color, DlColorsLight.grey200);
    expect(find.byKey(const Key('dl_checkbox_checkmark')), findsNothing);

    await tester.tap(find.byKey(const Key('dl_checkbox_tap_area')));
    await tester.pump();

    border = decoration().border as Border;
    expect(decoration().color, DlColorsLight.black);
    expect(border.top.color, Colors.transparent);
    expect(find.byKey(const Key('dl_checkbox_checkmark')), findsOneWidget);

    await tester.tap(find.byKey(const Key('dl_checkbox_tap_area')));
    await tester.pump();

    border = decoration().border as Border;
    expect(decoration().color, DlColorsLight.white);
    expect(border.top.color, DlColorsLight.grey200);
    expect(find.byKey(const Key('dl_checkbox_checkmark')), findsNothing);
  });

  testWidgets('disabled state uses grey50 background and is not clickable', (
    tester,
  ) async {
    await pumpCheckbox(tester, state: DlCheckboxState.disabled);

    BoxDecoration decoration() =>
        tester.widget<Container>(find.byKey(const Key('dl_checkbox_inner'))).decoration
            as BoxDecoration;

    var border = decoration().border as Border;
    expect(decoration().color, DlColorsLight.grey50);
    expect(border.top.color, DlColorsLight.grey200);
    expect(find.byKey(const Key('dl_checkbox_checkmark')), findsNothing);

    await tester.tap(find.byKey(const Key('dl_checkbox_tap_area')));
    await tester.pump();

    border = decoration().border as Border;
    expect(decoration().color, DlColorsLight.grey50);
    expect(border.top.color, DlColorsLight.grey200);
    expect(find.byKey(const Key('dl_checkbox_checkmark')), findsNothing);
  });
}
