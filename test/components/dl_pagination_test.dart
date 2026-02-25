import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpPagination(
    WidgetTester tester, {
    required DlPagination pagination,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: pagination)),
      ),
    );
  }

  testWidgets('renders count items with 12x12 boxes and 8x8 centered dots', (
    tester,
  ) async {
    await pumpPagination(
      tester,
      pagination: const DlPagination(count: 4),
    );

    for (var i = 0; i < 4; i++) {
      expect(find.byKey(Key('dl_pagination_item_$i')), findsOneWidget);
      expect(find.byKey(Key('dl_pagination_dot_$i')), findsOneWidget);
      expect(
        tester.getSize(find.byKey(Key('dl_pagination_item_$i'))),
        const Size(12, 12),
      );
      expect(
        tester.getSize(find.byKey(Key('dl_pagination_dot_$i'))),
        const Size(8, 8),
      );
    }

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SizedBox && widget.width == DlSpacingTokens.p_4,
      ),
      findsNWidgets(3),
    );
  });

  testWidgets('selected dot is black and unselected dots are black 40% opacity', (
    tester,
  ) async {
    await pumpPagination(
      tester,
      pagination: const DlPagination(count: 3, initialIndex: 1),
    );

    BoxDecoration dotDecoration(int index) =>
        tester.widget<Container>(find.byKey(Key('dl_pagination_dot_$index'))).decoration
            as BoxDecoration;

    expect(dotDecoration(1).color, DlColorsLight.black);
    expect(
      dotDecoration(0).color,
      DlColorsLight.black.withAlpha(102),
    );
    expect(
      dotDecoration(2).color,
      DlColorsLight.black.withAlpha(102),
    );
  });

  testWidgets('tap changes selection from old to new dot', (tester) async {
    var changedTo = -1;
    await pumpPagination(
      tester,
      pagination: DlPagination(
        count: 4,
        onChanged: (value) => changedTo = value,
      ),
    );

    BoxDecoration dotDecoration(int index) =>
        tester.widget<Container>(find.byKey(Key('dl_pagination_dot_$index'))).decoration
            as BoxDecoration;

    expect(dotDecoration(0).color, DlColorsLight.black);
    expect(dotDecoration(2).color, DlColorsLight.black.withAlpha(102));

    await tester.tap(find.byKey(const Key('dl_pagination_item_2')));
    await tester.pump();

    expect(changedTo, 2);
    expect(dotDecoration(2).color, DlColorsLight.black);
    expect(dotDecoration(0).color, DlColorsLight.black.withAlpha(102));
  });
}
