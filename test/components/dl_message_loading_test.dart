import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpMessageLoading(
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

  Color dotColor(WidgetTester tester, int index) {
    final dot = tester.widget<Container>(
      find.byKey(Key('dl_message_loading_dot_$index')),
    );
    final decoration = dot.decoration as BoxDecoration;
    return decoration.color!;
  }

  testWidgets('message loading has grey100, roundedMd, and p8/p12 padding', (
    tester,
  ) async {
    await pumpMessageLoading(tester, child: const DlMessageLoading());

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_message_loading')),
    );
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;

    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_8,
        vertical: DlSpacingTokens.p_12,
      ),
    );
    expect(decoration.color, DlColorsLight.grey100);
    expect(radius.topLeft.x, DlRadiusTokens.roundedMd);
  });

  testWidgets('dots are 8x8 with p8 spacing', (tester) async {
    await pumpMessageLoading(tester, child: const DlMessageLoadingDots());

    expect(
      tester.getSize(find.byKey(const Key('dl_message_loading_dot_0'))),
      const Size(8, 8),
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_message_loading_dot_1'))),
      const Size(8, 8),
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_message_loading_dot_2'))),
      const Size(8, 8),
    );

    final gapFinder = find.descendant(
      of: find.byKey(const Key('dl_message_loading_dots')),
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.width == DlSpacingTokens.p_8,
      ),
    );
    expect(gapFinder, findsNWidgets(2));
  });

  testWidgets('dot colors rotate through expected 3-phase loop', (
    tester,
  ) async {
    const step = Duration(milliseconds: 300);
    await pumpMessageLoading(
      tester,
      child: const DlMessageLoadingDots(stepDuration: step),
    );

    // Phase 1: [300, 400, 500]
    expect(dotColor(tester, 0), DlColorsLight.grey300);
    expect(dotColor(tester, 1), DlColorsLight.grey400);
    expect(dotColor(tester, 2), DlColorsLight.grey500);

    // Phase 2: [500, 300, 400]
    await tester.pump(step);
    expect(dotColor(tester, 0), DlColorsLight.grey500);
    expect(dotColor(tester, 1), DlColorsLight.grey300);
    expect(dotColor(tester, 2), DlColorsLight.grey400);

    // Phase 3: [400, 500, 300]
    await tester.pump(step);
    expect(dotColor(tester, 0), DlColorsLight.grey400);
    expect(dotColor(tester, 1), DlColorsLight.grey500);
    expect(dotColor(tester, 2), DlColorsLight.grey300);

    // Back to Phase 1
    await tester.pump(step);
    expect(dotColor(tester, 0), DlColorsLight.grey300);
    expect(dotColor(tester, 1), DlColorsLight.grey400);
    expect(dotColor(tester, 2), DlColorsLight.grey500);
  });
}
