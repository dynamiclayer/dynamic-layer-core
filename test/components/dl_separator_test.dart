import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('horizontal separator fills available width and is 1px high', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DlTheme.light(),
        home: Scaffold(
          body: Center(child: SizedBox(width: 80, child: const DlSeparator())),
        ),
      ),
    );

    final size = tester.getSize(find.byKey(const Key('dl_separator_line')));
    expect(size.width, 80);
    expect(size.height, 1);

    final box = tester.widget<DecoratedBox>(
      find.descendant(
        of: find.byKey(const Key('dl_separator_line')),
        matching: find.byType(DecoratedBox),
      ),
    );
    final decoration = box.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.grey200);
  });

  testWidgets('vertical separator fills available height and is 1px wide', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DlTheme.light(),
        home: Scaffold(
          body: Center(
            child: SizedBox(
              height: 80,
              child: const DlSeparator(
                orientation: DlSeparatorOrientation.vertical,
              ),
            ),
          ),
        ),
      ),
    );

    final size = tester.getSize(find.byKey(const Key('dl_separator_line')));
    expect(size.width, 1);
    expect(size.height, 80);
  });
}
