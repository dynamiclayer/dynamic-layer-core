import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpSearchField(
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

  testWidgets('renders roundedFull with fixed left icon and placeholder', (
    tester,
  ) async {
    await pumpSearchField(
      tester,
      child: const DlSearchField(placeholder: 'Search'),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_search_field_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;
    final textField = tester.widget<TextField>(
      find.byKey(const Key('dl_search_field_text_field')),
    );

    expect(radius.topLeft.x, DlRadiusTokens.roundedFull);
    expect(decoration.color, DlColorsLight.grey100);
    expect(find.byKey(const Key('dl_search_field_icon')), findsOneWidget);
    expect(textField.decoration?.hintText, 'Search');
    expect(textField.decoration?.hintStyle?.color, DlColorsLight.grey500);
  });

  testWidgets('active focus shows 2px black border and unfocus on outside tap', (
    tester,
  ) async {
    await pumpSearchField(
      tester,
      child: const Scaffold(
        body: Column(
          children: [
            DlSearchField(placeholder: 'Search'),
            SizedBox(height: 40),
            Text('Outside'),
          ],
        ),
      ),
    );

    BoxDecoration decoration() =>
        tester
            .widget<Container>(find.byKey(const Key('dl_search_field_container')))
            .decoration as BoxDecoration;

    expect((decoration().border as Border).top.color, Colors.transparent);
    await tester.tap(find.byKey(const Key('dl_search_field_tap_area')));
    await tester.pump();
    expect((decoration().border as Border).top.color, DlColorsLight.black);

    await tester.tap(find.text('Outside'));
    await tester.pump();
    expect((decoration().border as Border).top.color, Colors.transparent);
  });

  testWidgets('disabled uses grey300 placeholder and is not focusable', (tester) async {
    await pumpSearchField(
      tester,
      child: const DlSearchField(
        placeholder: 'Search',
        enabled: false,
      ),
    );

    final textField = tester.widget<TextField>(
      find.byKey(const Key('dl_search_field_text_field')),
    );
    final hintStyle = textField.decoration!.hintStyle!;
    final searchIcon = tester.widget<DlAssetIcon>(
      find.byKey(const Key('dl_search_field_icon')),
    );
    expect(hintStyle.color, DlColorsLight.grey300);
    expect(searchIcon.color, DlColorsLight.grey300);

    await tester.tap(find.byKey(const Key('dl_search_field_tap_area')));
    await tester.pump();
    final decoration = tester
            .widget<Container>(find.byKey(const Key('dl_search_field_container')))
            .decoration
        as BoxDecoration;
    expect((decoration.border as Border).top.color, Colors.transparent);
  });

  testWidgets('shows clear icon after first character and clears text on tap', (
    tester,
  ) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);

    await pumpSearchField(
      tester,
      child: DlSearchField(
        placeholder: 'Search',
        controller: controller,
      ),
    );

    expect(find.byKey(const Key('dl_search_field_clear_icon')), findsNothing);

    await tester.enterText(find.byKey(const Key('dl_search_field_text_field')), 'a');
    await tester.pump();
    expect(find.byKey(const Key('dl_search_field_clear_icon')), findsOneWidget);
    expect(controller.text, 'a');

    await tester.tap(find.byKey(const Key('dl_search_field_clear_icon_tap')));
    await tester.pump();
    expect(controller.text, isEmpty);
    expect(find.byKey(const Key('dl_search_field_clear_icon')), findsNothing);
  });

  testWidgets('size md uses p12 vertical padding', (tester) async {
    await pumpSearchField(
      tester,
      child: const DlSearchField(
        placeholder: 'Search',
        size: DlSearchFieldSize.md,
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_search_field_container')),
    );
    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_16,
        vertical: DlSpacingTokens.p_12,
      ),
    );
  });

  testWidgets('size sm uses p8 vertical padding', (tester) async {
    await pumpSearchField(
      tester,
      child: const DlSearchField(
        placeholder: 'Search',
        size: DlSearchFieldSize.sm,
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_search_field_container')),
    );
    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_16,
        vertical: DlSpacingTokens.p_8,
      ),
    );
  });
}
