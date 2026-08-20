import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpIconButton(
    WidgetTester tester, {
    required DlButtonIcon button,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: button)),
      ),
    );
  }

  testWidgets('renders primary default style', (tester) async {
    await pumpIconButton(
      tester,
      button: DlButtonIcon(icon: const Icon(Icons.add), onPressed: () {}),
    );

    final material = tester.widget<Material>(
      find.byKey(const Key('dl_button_icon_material')),
    );
    expect(material.color, DlColorsLight.black);

    final iconTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_button_icon_theme')),
    );
    expect(iconTheme.data.color, DlColorsLight.white);
  });

  testWidgets('renders secondary default style', (tester) async {
    await pumpIconButton(
      tester,
      button: DlButtonIcon(
        icon: const Icon(Icons.add),
        type: DlButtonType.secondary,
        onPressed: () {},
      ),
    );

    final material = tester.widget<Material>(
      find.byKey(const Key('dl_button_icon_material')),
    );
    expect(material.color, DlColorsLight.grey100);

    final iconTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_button_icon_theme')),
    );
    expect(iconTheme.data.color, DlColorsLight.black);
  });

  testWidgets('renders tertiary default style with border', (tester) async {
    await pumpIconButton(
      tester,
      button: DlButtonIcon(
        icon: const Icon(Icons.add),
        type: DlButtonType.tertiary,
        onPressed: () {},
      ),
    );

    final material = tester.widget<Material>(
      find.byKey(const Key('dl_button_icon_material')),
    );
    expect(material.color, DlColorsLight.white);

    final shape = material.shape as RoundedRectangleBorder;
    expect(shape.side.width, DlBorderWidthTokens.border1);
    expect(shape.side.color, DlColorsLight.grey200);
  });

  testWidgets('renders ghost default style with transparent material', (
    tester,
  ) async {
    await pumpIconButton(
      tester,
      button: DlButtonIcon(
        icon: const Icon(Icons.add),
        type: DlButtonType.ghost,
        onPressed: () {},
      ),
    );

    final material = tester.widget<Material>(
      find.byKey(const Key('dl_button_icon_material')),
    );
    expect(material.type, MaterialType.transparency);
    expect(material.color, isNull);

    final iconTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_button_icon_theme')),
    );
    expect(iconTheme.data.color, DlColorsLight.black);
  });

  testWidgets('changes to pressed style while pressing default button', (
    tester,
  ) async {
    await pumpIconButton(
      tester,
      button: DlButtonIcon(icon: const Icon(Icons.add), onPressed: () {}),
    );

    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(Icon)),
    );
    await tester.pump();

    final material = tester.widget<Material>(
      find.byKey(const Key('dl_button_icon_material')),
    );
    expect(material.color, DlColorsLight.grey700);

    await gesture.up();
    await tester.pump();

    final releasedMaterial = tester.widget<Material>(
      find.byKey(const Key('dl_button_icon_material')),
    );
    expect(releasedMaterial.color, DlColorsLight.black);
  });

  testWidgets('ghost pressed uses grey100 background and resets on release', (
    tester,
  ) async {
    await pumpIconButton(
      tester,
      button: DlButtonIcon(
        icon: const Icon(Icons.add),
        type: DlButtonType.ghost,
        onPressed: () {},
      ),
    );

    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(Icon)),
    );
    await tester.pump();

    final material = tester.widget<Material>(
      find.byKey(const Key('dl_button_icon_material')),
    );
    expect(material.color, DlColorsLight.grey100);

    await gesture.up();
    await tester.pump();

    final releasedMaterial = tester.widget<Material>(
      find.byKey(const Key('dl_button_icon_material')),
    );
    expect(releasedMaterial.type, MaterialType.transparency);
    expect(releasedMaterial.color, isNull);
  });

  testWidgets('disabled blocks tap and uses disabled color', (tester) async {
    var tapped = false;

    await pumpIconButton(
      tester,
      button: DlButtonIcon(
        icon: const Icon(Icons.add),
        state: DlButtonState.disabled,
        onPressed: () {
          tapped = true;
        },
      ),
    );

    final material = tester.widget<Material>(
      find.byKey(const Key('dl_button_icon_material')),
    );
    expect(material.color, DlColorsLight.grey100);

    final iconTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_button_icon_theme')),
    );
    expect(iconTheme.data.color, DlColorsLight.grey600);

    await tester.tap(find.byType(Icon));
    await tester.pump();
    expect(tapped, isFalse);
  });

  testWidgets('uses expected lg size and padding', (tester) async {
    await pumpIconButton(
      tester,
      button: DlButtonIcon(icon: const Icon(Icons.add), onPressed: () {}),
    );

    final sizeBox = tester.widget<SizedBox>(
      find.byKey(const Key('dl_button_icon_size_box')),
    );
    final padding = tester.widget<Padding>(
      find.byKey(const Key('dl_button_icon_padding')),
    );

    expect(sizeBox.width, 56);
    expect(sizeBox.height, 56);
    expect(padding.padding, const EdgeInsets.all(DlSpacingTokens.p_16));
  });

  testWidgets('supports md, sm and xs sizes', (tester) async {
    final expected = <DlButtonSize, double>{
      DlButtonSize.md: 48,
      DlButtonSize.sm: 40,
      DlButtonSize.xs: 32,
    };

    for (final entry in expected.entries) {
      await pumpIconButton(
        tester,
        button: DlButtonIcon(
          icon: const Icon(Icons.add),
          size: entry.key,
          onPressed: () {},
        ),
      );

      final sizeBox = tester.widget<SizedBox>(
        find.byKey(const Key('dl_button_icon_size_box')),
      );

      expect(sizeBox.width, entry.value);
      expect(sizeBox.height, entry.value);
    }
  });
}
