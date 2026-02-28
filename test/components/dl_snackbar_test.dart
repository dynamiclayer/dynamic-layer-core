import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpSnackbar(
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

  testWidgets('renders white background, grey200 border and roundedMd', (
    tester,
  ) async {
    await pumpSnackbar(
      tester,
      child: const DlSnackbar(label: 'Saved successfully'),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_snackbar')),
    );
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;
    final border = decoration.border! as Border;

    expect(decoration.color, DlColorsLight.white);
    expect(border.top.color, DlColorsLight.grey200);
    expect(border.top.width, DlBorderWidthTokens.border1);
    expect(radius.topLeft.x, DlRadiusTokens.roundedMd);
  });

  testWidgets('uses p12 top/bottom/left and p20 right padding', (tester) async {
    await pumpSnackbar(
      tester,
      child: const DlSnackbar(label: 'Saved successfully'),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_snackbar')),
    );
    expect(
      container.padding,
      const EdgeInsets.fromLTRB(
        DlSpacingTokens.p_12,
        DlSpacingTokens.p_12,
        DlSpacingTokens.p_20,
        DlSpacingTokens.p_12,
      ),
    );
  });

  testWidgets('renders success icon and label with p8 gap', (tester) async {
    await pumpSnackbar(
      tester,
      child: const DlSnackbar(label: 'Saved successfully'),
    );

    final icon = tester.widget<DlAssetIcon>(
      find.byKey(const Key('dl_snackbar_icon')),
    );
    expect(icon.assetPath, DlIcons.circleCheckAsset);
    expect(icon.color, DlColorsLight.green600);

    final label = tester.widget<Text>(
      find.byKey(const Key('dl_snackbar_label')),
    );
    expect(label.style?.fontSize, DlTextStyles.textBase.semiBold.fontSize);
    expect(label.style?.fontWeight, DlTextStyles.textBase.semiBold.fontWeight);
    expect(label.style?.color, DlColorsLight.black);

    final gapFinder = find.descendant(
      of: find.byKey(const Key('dl_snackbar')),
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.width == DlSpacingTokens.p_8,
      ),
    );
    expect(gapFinder, findsOneWidget);
  });

  testWidgets('supports error, warning and information icons', (tester) async {
    Future<void> expectIconForType(
      DlSnackbarType type,
      String iconPath,
      Color color,
    ) async {
      await pumpSnackbar(
        tester,
        child: DlSnackbar(label: 'Message', type: type),
      );
      final icon = tester.widget<DlAssetIcon>(
        find.byKey(const Key('dl_snackbar_icon')),
      );
      expect(icon.assetPath, iconPath);
      expect(icon.color, color);
    }

    await expectIconForType(
      DlSnackbarType.error,
      DlIcons.circleAlertAsset,
      DlColorsLight.red500,
    );
    await expectIconForType(
      DlSnackbarType.warning,
      DlIcons.alertTriangleFilledAsset,
      DlColorsLight.yellow500,
    );
    await expectIconForType(
      DlSnackbarType.information,
      DlIcons.infoAsset,
      DlColorsLight.violet500,
    );
  });

  testWidgets('snackbar width hugs its content in stretched layout', (
    tester,
  ) async {
    await pumpSnackbar(
      tester,
      child: const SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [DlSnackbar(label: 'Short')],
        ),
      ),
    );

    final snackbarWidth = tester
        .getSize(find.byKey(const Key('dl_snackbar')))
        .width;
    expect(snackbarWidth, lessThan(400));
  });
}
