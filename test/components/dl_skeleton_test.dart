import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpSkeleton(
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

  testWidgets('supports custom width, height and rounded values', (tester) async {
    await pumpSkeleton(
      tester,
      child: const DlSkeleton(
        width: 220,
        height: 32,
        rounded: DlRadiusTokens.roundedFull,
      ),
    );

    final container = tester.widget<Container>(find.byKey(const Key('dl_skeleton')));
    final size = tester.getSize(find.byKey(const Key('dl_skeleton')));
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;

    expect(size, const Size(220, 32));
    expect(radius.topLeft.x, DlRadiusTokens.roundedFull);
  });

  testWidgets('animates color between grey50 and grey100 in loop', (tester) async {
    await pumpSkeleton(
      tester,
      child: const DlSkeleton(width: 180, height: 20),
    );

    BoxDecoration decoration() =>
        tester.widget<Container>(find.byKey(const Key('dl_skeleton'))).decoration
            as BoxDecoration;

    expect(decoration().color, DlColorsLight.grey50);

    await tester.pump(const Duration(milliseconds: 800));
    expect(decoration().color, DlColorsLight.grey100);

    await tester.pump(const Duration(milliseconds: 800));
    expect(decoration().color, DlColorsLight.grey50);
  });
}
