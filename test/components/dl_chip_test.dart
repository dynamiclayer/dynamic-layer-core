import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpChip(
    WidgetTester tester, {
    DlChipState state = DlChipState.defaultState,
    DlChipSize size = DlChipSize.lg,
    String label = 'Chip',
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(
          body: Center(
            child: DlChip(
              label: label,
              state: state,
              size: size,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('lg default uses expected padding and text style', (
    tester,
  ) async {
    await pumpChip(tester, size: DlChipSize.lg);

    final container = tester.widget<Container>(find.byKey(const Key('dl_chip_container')));
    final text = tester.widget<Text>(find.byKey(const Key('dl_chip_text')));
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;

    expect(decoration.color, DlColorsLight.grey100);
    expect(radius.topLeft.x, DlRadiusTokens.roundedFull);
    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_16,
        vertical: DlSpacingTokens.p_8,
      ),
    );
    expect(text.style?.fontSize, DlTextStyles.textBase.semiBold.fontSize);
    expect(text.style?.fontWeight, DlTextStyles.textBase.semiBold.fontWeight);
    expect(text.style?.color, DlColorsLight.black);
  });

  testWidgets('md default uses expected padding and text style', (tester) async {
    await pumpChip(tester, size: DlChipSize.md);

    final container = tester.widget<Container>(find.byKey(const Key('dl_chip_container')));
    final text = tester.widget<Text>(find.byKey(const Key('dl_chip_text')));

    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_12,
        vertical: DlSpacingTokens.p_4,
      ),
    );
    expect(text.style?.fontSize, DlTextStyles.textSm.semiBold.fontSize);
    expect(text.style?.fontWeight, DlTextStyles.textSm.semiBold.fontWeight);
    expect(text.style?.color, DlColorsLight.black);
  });

  testWidgets('sm default uses expected padding and text style', (tester) async {
    await pumpChip(tester, size: DlChipSize.sm);

    final container = tester.widget<Container>(find.byKey(const Key('dl_chip_container')));
    final text = tester.widget<Text>(find.byKey(const Key('dl_chip_text')));

    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_8,
        vertical: DlSpacingTokens.p_2,
      ),
    );
    expect(text.style?.fontSize, DlTextStyles.textXs.semiBold.fontSize);
    expect(text.style?.fontWeight, DlTextStyles.textXs.semiBold.fontWeight);
    expect(text.style?.color, DlColorsLight.black);
  });

  testWidgets('tap toggles default and active styles', (tester) async {
    await pumpChip(tester);

    BoxDecoration decoration() =>
        tester.widget<Container>(find.byKey(const Key('dl_chip_container'))).decoration
            as BoxDecoration;
    Text text() => tester.widget<Text>(find.byKey(const Key('dl_chip_text')));

    expect(decoration().color, DlColorsLight.grey100);
    expect(text().style?.color, DlColorsLight.black);

    await tester.tap(find.byKey(const Key('dl_chip_tap_area')));
    await tester.pump();

    expect(decoration().color, DlColorsLight.black);
    expect(text().style?.color, DlColorsLight.white);
    expect(text().style?.fontWeight, DlTextStyles.textBase.semiBold.fontWeight);

    await tester.tap(find.byKey(const Key('dl_chip_tap_area')));
    await tester.pump();

    expect(decoration().color, DlColorsLight.grey100);
    expect(text().style?.color, DlColorsLight.black);
  });

  testWidgets('disabled lg uses base regular grey500 text and no toggle', (
    tester,
  ) async {
    await pumpChip(tester, state: DlChipState.disabled, size: DlChipSize.lg);

    BoxDecoration decoration() =>
        tester.widget<Container>(find.byKey(const Key('dl_chip_container'))).decoration
            as BoxDecoration;
    Text text() => tester.widget<Text>(find.byKey(const Key('dl_chip_text')));

    expect(decoration().color, DlColorsLight.grey100);
    expect(text().style?.fontSize, DlTextStyles.textBase.regular.fontSize);
    expect(text().style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(text().style?.color, DlColorsLight.grey500);

    await tester.tap(find.byKey(const Key('dl_chip_tap_area')));
    await tester.pump();

    expect(decoration().color, DlColorsLight.grey100);
    expect(text().style?.color, DlColorsLight.grey500);
  });

  testWidgets('disabled md uses sm regular grey500 text', (tester) async {
    await pumpChip(tester, state: DlChipState.disabled, size: DlChipSize.md);

    final text = tester.widget<Text>(find.byKey(const Key('dl_chip_text')));
    expect(text.style?.fontSize, DlTextStyles.textSm.regular.fontSize);
    expect(text.style?.fontWeight, DlTextStyles.textSm.regular.fontWeight);
    expect(text.style?.color, DlColorsLight.grey500);
  });

  testWidgets('disabled sm uses xs regular grey500 text', (tester) async {
    await pumpChip(tester, state: DlChipState.disabled, size: DlChipSize.sm);

    final text = tester.widget<Text>(find.byKey(const Key('dl_chip_text')));
    expect(text.style?.fontSize, DlTextStyles.textXs.regular.fontSize);
    expect(text.style?.fontWeight, DlTextStyles.textXs.regular.fontWeight);
    expect(text.style?.color, DlColorsLight.grey500);
  });

  testWidgets('calls onStateChanged when toggled', (tester) async {
    DlChipState? latestState;
    await tester.pumpWidget(
      MaterialApp(
        theme: DlTheme.light(),
        home: Scaffold(
          body: Center(
            child: DlChip(
              label: 'Chip',
              onStateChanged: (state) => latestState = state,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('dl_chip_tap_area')));
    await tester.pump();
    expect(latestState, DlChipState.active);

    await tester.tap(find.byKey(const Key('dl_chip_tap_area')));
    await tester.pump();
    expect(latestState, DlChipState.defaultState);
  });
}
