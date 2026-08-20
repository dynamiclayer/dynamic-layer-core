import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpButtonLoading(
    WidgetTester tester, {
    required DlButtonLoading child,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: child)),
      ),
    );
  }

  Color dotColor(WidgetTester tester, int index) {
    final dot = tester.widget<Container>(
      find.byKey(Key('dl_loading_dot_$index')),
    );
    final decoration = dot.decoration as BoxDecoration;
    return decoration.color!;
  }

  testWidgets('primary uses black background and white loading dots', (
    tester,
  ) async {
    await pumpButtonLoading(
      tester,
      child: const DlButtonLoading(type: DlButtonType.primary),
    );

    final material = tester.widget<Material>(
      find.byKey(const Key('dl_button_loading_material')),
    );
    expect(material.color, DlColorsLight.black);
    expect(dotColor(tester, 0), DlColorsLight.white);
  });

  testWidgets('secondary uses grey100 background and black loading dots', (
    tester,
  ) async {
    await pumpButtonLoading(
      tester,
      child: const DlButtonLoading(type: DlButtonType.secondary),
    );

    final material = tester.widget<Material>(
      find.byKey(const Key('dl_button_loading_material')),
    );
    expect(material.color, DlColorsLight.grey100);
    expect(dotColor(tester, 0), DlColorsLight.black);
  });

  testWidgets('tertiary has grey200 border and black loading dots', (
    tester,
  ) async {
    await pumpButtonLoading(
      tester,
      child: const DlButtonLoading(type: DlButtonType.tertiary),
    );

    final material = tester.widget<Material>(
      find.byKey(const Key('dl_button_loading_material')),
    );
    final shape = material.shape! as RoundedRectangleBorder;

    expect((shape.side).color, DlColorsLight.grey200);
    expect((shape.side).width, DlBorderWidthTokens.border1);
    expect(dotColor(tester, 0), DlColorsLight.black);
  });

  testWidgets('supports lg, md, sm and xs sizes', (tester) async {
    Future<void> expectHeight(DlButtonSize size, double expected) async {
      await pumpButtonLoading(tester, child: DlButtonLoading(size: size));
      final container = tester.widget<Container>(
        find.byKey(const Key('dl_button_loading_container')),
      );
      final constraints = container.constraints!;
      expect(constraints.minHeight, expected);
    }

    await expectHeight(DlButtonSize.lg, 56);
    await expectHeight(DlButtonSize.md, 48);
    await expectHeight(DlButtonSize.sm, 40);
    await expectHeight(DlButtonSize.xs, 32);
  });

  testWidgets('is non-clickable and has no text or icons', (tester) async {
    await pumpButtonLoading(tester, child: const DlButtonLoading());

    expect(find.byType(InkWell), findsNothing);
    expect(find.byType(Text), findsNothing);
    expect(find.byType(DlPlaceholderIcon), findsNothing);
    expect(find.byType(DlLoadingDots), findsOneWidget);
  });
}
