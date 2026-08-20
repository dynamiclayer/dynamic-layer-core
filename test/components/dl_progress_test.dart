import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpProgress(
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

  testWidgets('renders 8px height grey200 roundedFull track', (tester) async {
    await pumpProgress(
      tester,
      child: const SizedBox(width: 300, child: DlProgress()),
    );

    final progress = tester.widget<Container>(find.byKey(const Key('dl_progress')));
    final size = tester.getSize(find.byKey(const Key('dl_progress')));
    final decoration = progress.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;

    expect(size.height, 8);
    expect(size.width, 300);
    expect(decoration.color, DlColorsLight.grey200);
    expect(radius.topLeft.x, DlRadiusTokens.roundedFull);
  });

  testWidgets('value percentage controls black fill width', (tester) async {
    await pumpProgress(
      tester,
      child: const SizedBox(width: 200, child: DlProgress(value: 60)),
    );

    final fillSize = tester.getSize(find.byKey(const Key('dl_progress_fill')));
    final fill = tester.widget<Container>(find.byKey(const Key('dl_progress_fill')));

    expect(fillSize.width, 120);
    expect(fill.color, DlColorsLight.black);
  });
}
