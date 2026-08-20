import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpAlert(
    WidgetTester tester, {
    required DlAlert alert,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(
          body: Center(child: SizedBox(width: 343, child: alert)),
        ),
      ),
    );
  }

  testWidgets('renders token styles and surface for alert', (tester) async {
    await pumpAlert(
      tester,
      alert: const DlAlert(
        title: 'Information',
        description: 'This is an informational message.',
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_alert_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final title = tester.widget<Text>(find.byKey(const Key('dl_alert_title')));
    final description = tester.widget<Text>(
      find.byKey(const Key('dl_alert_description')),
    );

    expect(decoration.color, DlColorsLight.violet50);
    expect(
      decoration.borderRadius,
      BorderRadius.circular(DlRadiusTokens.roundedLg),
    );
    expect(decoration.border, isNull);
    expect(title.style?.fontWeight, DlTextStyles.textBase.semiBold.fontWeight);
    expect(
      description.style?.fontWeight,
      DlTextStyles.textBase.regular.fontWeight,
    );
  });

  testWidgets('renders variant-specific leading asset icons and backgrounds', (
    tester,
  ) async {
    final cases = <DlAlertVariant, ({String iconPath, Color iconColor, Color backgroundColor})>{
      DlAlertVariant.info: (
        iconPath: DlIcons.infoAsset,
        iconColor: DlColorsLight.violet500,
        backgroundColor: DlColorsLight.violet50,
      ),
      DlAlertVariant.success: (
        iconPath: DlIcons.circleCheckAsset,
        iconColor: DlColorsLight.green600,
        backgroundColor: DlColorsLight.green50,
      ),
      DlAlertVariant.warning: (
        iconPath: DlIcons.alertTriangleFilledAsset,
        iconColor: DlColorsLight.yellow500,
        backgroundColor: DlColorsLight.yellow50,
      ),
      DlAlertVariant.error: (
        iconPath: DlIcons.circleAlertAsset,
        iconColor: DlColorsLight.red500,
        backgroundColor: DlColorsLight.red50,
      ),
    };

    for (final entry in cases.entries) {
      await pumpAlert(
        tester,
        alert: DlAlert(title: entry.key.name, variant: entry.key),
      );

      final leadingIcon = tester.widget<DlAssetIcon>(
        find.byKey(const Key('dl_alert_variant_icon')),
      );
      final container = tester.widget<Container>(
        find.byKey(const Key('dl_alert_container')),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(leadingIcon.assetPath, entry.value.iconPath);
      expect(leadingIcon.color, entry.value.iconColor);
      expect(decoration.color, entry.value.backgroundColor);
      expect(decoration.border, isNull);
    }
  });

  testWidgets('does not render description when omitted', (tester) async {
    await pumpAlert(tester, alert: const DlAlert(title: 'Only title'));

    expect(find.byKey(const Key('dl_alert_description')), findsNothing);
  });

  testWidgets('renders close button only when onClose is provided', (
    tester,
  ) async {
    await pumpAlert(tester, alert: const DlAlert(title: 'No close'));
    expect(find.byKey(const Key('dl_alert_close_button')), findsNothing);

    var tapped = false;
    await pumpAlert(
      tester,
      alert: DlAlert(title: 'With close', onClose: () => tapped = true),
    );
    expect(find.byKey(const Key('dl_alert_close_button')), findsOneWidget);
    final closeIcon = tester.widget<DlAssetIcon>(
      find.byKey(const Key('dl_alert_close_icon')),
    );
    expect(closeIcon.assetPath, DlIcons.circleXAsset);
    expect(closeIcon.color, DlColorsLight.black);

    await tester.tap(find.byKey(const Key('dl_alert_close_button')));
    await tester.pump();
    expect(tapped, isTrue);
    expect(find.byKey(const Key('dl_alert_container')), findsNothing);
  });
}
