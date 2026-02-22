import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
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

    expect(decoration.color, DlColorsLight.white);
    expect(
      decoration.borderRadius,
      BorderRadius.circular(DlRadiusTokens.roundedLg),
    );
    expect((decoration.border as Border).top.color, DlColorsLight.grey200);
    expect(title.style?.fontWeight, DlTextStyles.textBase.semiBold.fontWeight);
    expect(
      description.style?.fontWeight,
      DlTextStyles.textBase.regular.fontWeight,
    );
  });

  testWidgets('renders variant-specific leading asset icons', (tester) async {
    final cases = <DlAlertVariant, String>{
      DlAlertVariant.info: DlIcons.infoAsset,
      DlAlertVariant.success: DlIcons.circleCheckAsset,
      DlAlertVariant.warning: DlIcons.alertTriangleFilledAsset,
      DlAlertVariant.error: DlIcons.circleAlertAsset,
    };

    for (final entry in cases.entries) {
      await pumpAlert(
        tester,
        alert: DlAlert(title: entry.key.name, variant: entry.key),
      );

      final leadingIcon = tester.widget<DlAssetIcon>(
        find.byKey(const Key('dl_alert_variant_icon')),
      );
      expect(leadingIcon.assetPath, entry.value);
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
