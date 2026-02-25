import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpTooltip(
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

  testWidgets('renders dark box with roundedMd, p16/p8 and white text', (
    tester,
  ) async {
    await pumpTooltip(
      tester,
      child: const DlTooltip(label: 'Tooltip text'),
    );

    final container = tester.widget<Container>(find.byKey(const Key('dl_tooltip_box')));
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;
    final label = tester.widget<Text>(find.byKey(const Key('dl_tooltip_label')));

    expect(container.padding, const EdgeInsets.symmetric(
      horizontal: DlSpacingTokens.p_16,
      vertical: DlSpacingTokens.p_8,
    ));
    expect(decoration.color, const Color(0xFF1F1F1F));
    expect(radius.topLeft.x, DlRadiusTokens.roundedMd);
    expect(label.style?.fontSize, DlTextStyles.textBase.regular.fontSize);
    expect(label.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(label.style?.color, const Color(0xFFFFFFFF));
  });

  testWidgets('renders centered arrow with 20x10 size', (tester) async {
    await pumpTooltip(
      tester,
      child: const DlTooltip(label: 'Tooltip text'),
    );

    final customPaint = tester.widget<CustomPaint>(
      find.byKey(const Key('dl_tooltip_arrow')),
    );
    final size = tester.getSize(find.byKey(const Key('dl_tooltip_arrow')));

    expect(customPaint.painter, isNotNull);
    expect(size, const Size(20, 10));
  });

  testWidgets('renders top direction with arrow above box', (tester) async {
    await pumpTooltip(
      tester,
      child: const DlTooltip(
        label: 'Tooltip text',
        direction: DlTooltipDirection.top,
      ),
    );

    final arrowY = tester.getTopLeft(find.byKey(const Key('dl_tooltip_arrow'))).dy;
    final boxY = tester.getTopLeft(find.byKey(const Key('dl_tooltip_box'))).dy;
    expect(arrowY, lessThan(boxY));
    expect(tester.getSize(find.byKey(const Key('dl_tooltip_arrow'))), const Size(20, 10));
  });

  testWidgets('renders left direction with arrow on left side', (tester) async {
    await pumpTooltip(
      tester,
      child: const DlTooltip(
        label: 'Tooltip text',
        direction: DlTooltipDirection.left,
      ),
    );

    final arrowX = tester.getTopLeft(find.byKey(const Key('dl_tooltip_arrow'))).dx;
    final boxX = tester.getTopLeft(find.byKey(const Key('dl_tooltip_box'))).dx;
    expect(arrowX, lessThan(boxX));
    expect(tester.getSize(find.byKey(const Key('dl_tooltip_arrow'))), const Size(10, 20));
  });

  testWidgets('renders right direction with arrow on right side', (tester) async {
    await pumpTooltip(
      tester,
      child: const DlTooltip(
        label: 'Tooltip text',
        direction: DlTooltipDirection.right,
      ),
    );

    final arrowX = tester.getTopLeft(find.byKey(const Key('dl_tooltip_arrow'))).dx;
    final boxX = tester.getTopLeft(find.byKey(const Key('dl_tooltip_box'))).dx;
    expect(arrowX, greaterThan(boxX));
    expect(tester.getSize(find.byKey(const Key('dl_tooltip_arrow'))), const Size(10, 20));
  });
}
