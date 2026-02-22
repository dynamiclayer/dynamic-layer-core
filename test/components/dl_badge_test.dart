import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpBadge(
    WidgetTester tester, {
    required DlBadge badge,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: badge)),
      ),
    );
  }

  testWidgets('sm renders 8x8 red500 full rounded dot', (tester) async {
    await pumpBadge(tester, badge: const DlBadge(size: DlBadgeSize.sm));

    final decoratedBox = tester.widget<DecoratedBox>(
      find.byKey(const Key('dl_badge_sm_dot')),
    );
    final decoration = decoratedBox.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;
    final size = tester.getSize(find.byKey(const Key('dl_badge_sm_dot')));

    expect(decoration.color, DlColorsLight.red500);
    expect(radius.topLeft.x, DlRadiusTokens.roundedFull);
    expect(size.width, 8);
    expect(size.height, 8);
  });

  testWidgets('md renders textXs semibold with red500 background', (
    tester,
  ) async {
    await pumpBadge(
      tester,
      badge: const DlBadge(size: DlBadgeSize.md, value: '9'),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_badge_md_container')),
    );
    final text = tester.widget<Text>(find.byKey(const Key('dl_badge_md_text')));
    final decoration = container.decoration as BoxDecoration;

    expect(decoration.color, DlColorsLight.red500);
    expect(container.constraints?.minWidth, 16);
    expect(
      container.padding,
      const EdgeInsets.symmetric(horizontal: DlSpacingTokens.p_4),
    );
    expect(text.data, '9');
    expect(text.style?.fontSize, DlTextStyles.textXs.semiBold.fontSize);
    expect(text.style?.fontWeight, DlTextStyles.textXs.semiBold.fontWeight);
  });

  testWidgets('md badge grows automatically when text is longer', (
    tester,
  ) async {
    await pumpBadge(
      tester,
      badge: const DlBadge(size: DlBadgeSize.md, value: '9'),
    );
    final shortWidth = tester
        .getSize(find.byKey(const Key('dl_badge_md_container')))
        .width;

    await pumpBadge(
      tester,
      badge: const DlBadge(size: DlBadgeSize.md, value: '999'),
    );
    final longWidth = tester
        .getSize(find.byKey(const Key('dl_badge_md_container')))
        .width;

    expect(longWidth, greaterThan(shortWidth));
  });
}
