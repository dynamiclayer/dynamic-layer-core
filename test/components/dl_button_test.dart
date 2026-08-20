import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpButton(
    WidgetTester tester, {
    required DlButton button,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(
          body: Center(child: button),
        ),
      ),
    );
  }

  testWidgets('renders primary default style', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Button field',
        onPressed: () {},
      ),
    );

    expect(find.text('Button field'), findsOneWidget);

    final material = tester.widget<Material>(find.byKey(const Key('dl_button_material')));
    expect(material.color, DlColorsLight.black);

    final text = tester.widget<Text>(find.text('Button field'));
    expect(text.style?.color, DlColorsLight.white);
    expect(text.style?.fontWeight, DlTypographyTokens.weightSemibold);
  });

  testWidgets('renders secondary default style', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Button field',
        type: DlButtonType.secondary,
        onPressed: () {},
      ),
    );

    final material = tester.widget<Material>(find.byKey(const Key('dl_button_material')));
    expect(material.color, DlColorsLight.grey100);

    final text = tester.widget<Text>(find.text('Button field'));
    expect(text.style?.color, DlColorsLight.black);
    expect(text.style?.fontWeight, DlTypographyTokens.weightSemibold);
  });

  testWidgets('renders tertiary default style with border', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Button field',
        type: DlButtonType.tertiary,
        onPressed: () {},
      ),
    );

    final material = tester.widget<Material>(find.byKey(const Key('dl_button_material')));
    expect(material.color, DlColorsLight.white);

    final shape = material.shape as RoundedRectangleBorder;
    expect(shape.side.width, DlBorderWidthTokens.border1);
    expect(shape.side.color, DlColorsLight.grey200);

    final text = tester.widget<Text>(find.text('Button field'));
    expect(text.style?.color, DlColorsLight.black);
  });

  testWidgets('renders ghost default style with semibold black label', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Button field',
        type: DlButtonType.ghost,
        onPressed: () {},
      ),
    );

    final material = tester.widget<Material>(find.byKey(const Key('dl_button_material')));
    expect(material.type, MaterialType.transparency);
    expect(material.color, isNull);

    final shape = material.shape as RoundedRectangleBorder;
    expect(shape.side, BorderSide.none);

    final text = tester.widget<Text>(find.text('Button field'));
    expect(text.style?.color, DlColorsLight.black);
    expect(text.style?.decoration, TextDecoration.none);
    expect(text.style?.fontWeight, DlTypographyTokens.weightSemibold);
  });

  testWidgets('ghost pressed uses grey100 background', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Ghost',
        type: DlButtonType.ghost,
        onPressed: () {},
      ),
    );

    final gesture = await tester.startGesture(
      tester.getCenter(find.text('Ghost')),
    );
    await tester.pump();

    final material = tester.widget<Material>(find.byKey(const Key('dl_button_material')));
    expect(material.color, DlColorsLight.grey100);

    await gesture.up();
    await tester.pump();

    final releasedMaterial = tester.widget<Material>(
      find.byKey(const Key('dl_button_material')),
    );
    expect(releasedMaterial.type, MaterialType.transparency);
    expect(releasedMaterial.color, isNull);
  });

  testWidgets('ghost disabled keeps transparent background and grey500 text', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Ghost disabled',
        type: DlButtonType.ghost,
        state: DlButtonState.disabled,
        onPressed: () {},
        iconLeft: const DlPlaceholderIcon(),
      ),
    );

    final material = tester.widget<Material>(find.byKey(const Key('dl_button_material')));
    expect(material.type, MaterialType.transparency);
    expect(material.color, isNull);

    final text = tester.widget<Text>(find.text('Ghost disabled'));
    expect(text.style?.color, DlColorsLight.grey500);

    final leftIconTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_button_icon_left_theme')),
    );
    expect(leftIconTheme.data.color, DlColorsLight.grey500);
  });

  testWidgets('changes to pressed style while pressing default button', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Press me',
        onPressed: () {},
      ),
    );

    final gesture = await tester.startGesture(
      tester.getCenter(find.text('Press me')),
    );
    await tester.pump();

    final material = tester.widget<Material>(find.byKey(const Key('dl_button_material')));
    expect(material.color, DlColorsLight.grey700);

    await gesture.up();
    await tester.pump();

    final releasedMaterial = tester.widget<Material>(
      find.byKey(const Key('dl_button_material')),
    );
    expect(releasedMaterial.color, DlColorsLight.black);
  });

  testWidgets('secondary changes to pressed style while pressing', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Press me',
        type: DlButtonType.secondary,
        onPressed: () {},
      ),
    );

    final gesture = await tester.startGesture(
      tester.getCenter(find.text('Press me')),
    );
    await tester.pump();

    final material = tester.widget<Material>(find.byKey(const Key('dl_button_material')));
    expect(material.color, DlColorsLight.grey200);

    await gesture.up();
    await tester.pump();

    final releasedMaterial = tester.widget<Material>(
      find.byKey(const Key('dl_button_material')),
    );
    expect(releasedMaterial.color, DlColorsLight.grey100);
  });

  testWidgets('tertiary changes to pressed style while pressing', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Press me',
        type: DlButtonType.tertiary,
        onPressed: () {},
      ),
    );

    final gesture = await tester.startGesture(
      tester.getCenter(find.text('Press me')),
    );
    await tester.pump();

    final material = tester.widget<Material>(find.byKey(const Key('dl_button_material')));
    expect(material.color, DlColorsLight.grey100);
    final pressedShape = material.shape as RoundedRectangleBorder;
    expect(pressedShape.side.color, DlColorsLight.grey200);

    await gesture.up();
    await tester.pump();

    final releasedMaterial = tester.widget<Material>(
      find.byKey(const Key('dl_button_material')),
    );
    expect(releasedMaterial.color, DlColorsLight.white);
    final releasedShape = releasedMaterial.shape as RoundedRectangleBorder;
    expect(releasedShape.side.color, DlColorsLight.grey200);
  });

  testWidgets('renders disabled style and blocks tap', (tester) async {
    var tapped = false;
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Disabled',
        state: DlButtonState.disabled,
        onPressed: () {
          tapped = true;
        },
      ),
    );

    final material = tester.widget<Material>(find.byKey(const Key('dl_button_material')));
    expect(material.color, DlColorsLight.grey100);

    final text = tester.widget<Text>(find.text('Disabled'));
    expect(text.style?.color, DlColorsLight.grey600);

    await tester.tap(find.text('Disabled'));
    await tester.pump();
    expect(tapped, isFalse);
  });

  testWidgets('tertiary disabled uses white background and grey500 foreground', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Disabled tertiary',
        type: DlButtonType.tertiary,
        state: DlButtonState.disabled,
        onPressed: () {},
        iconLeft: const DlPlaceholderIcon(),
      ),
    );

    final material = tester.widget<Material>(find.byKey(const Key('dl_button_material')));
    expect(material.color, DlColorsLight.white);

    final shape = material.shape as RoundedRectangleBorder;
    expect(shape.side.color, DlColorsLight.grey200);

    final text = tester.widget<Text>(find.text('Disabled tertiary'));
    expect(text.style?.color, DlColorsLight.grey500);

    final leftIconTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_button_icon_left_theme')),
    );
    expect(leftIconTheme.data.color, DlColorsLight.grey500);
  });

  testWidgets('applies icon color equal to label color', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Icon Button',
        state: DlButtonState.disabled,
        onPressed: () {},
        iconLeft: const Icon(Icons.add),
        iconRight: const Icon(Icons.arrow_forward),
      ),
    );

    final leftIconTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_button_icon_left_theme')),
    );
    final rightIconTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_button_icon_right_theme')),
    );
    expect(leftIconTheme.data.color, DlColorsLight.grey600);
    expect(rightIconTheme.data.color, DlColorsLight.grey600);
  });

  testWidgets('uses expected size and padding for lg', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Sizing',
        onPressed: () {},
      ),
    );

    final container = tester.widget<Container>(
      find.descendant(
        of: find.byKey(const Key('dl_button_material')),
        matching: find.byType(Container),
      ),
    );

    expect(container.constraints?.minHeight, 56);
    expect(
      container.padding,
      const EdgeInsets.fromLTRB(
        DlSpacingTokens.p_24,
        DlSpacingTokens.p_16,
        DlSpacingTokens.p_24,
        DlSpacingTokens.p_16,
      ),
    );
  });

  testWidgets('uses expected size and padding for md', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Sizing md',
        size: DlButtonSize.md,
        onPressed: () {},
      ),
    );

    final container = tester.widget<Container>(
      find.descendant(
        of: find.byKey(const Key('dl_button_material')),
        matching: find.byType(Container),
      ),
    );

    expect(container.constraints?.minHeight, 48);
    expect(
      container.padding,
      const EdgeInsets.fromLTRB(
        DlSpacingTokens.p_16,
        DlSpacingTokens.p_12,
        DlSpacingTokens.p_16,
        DlSpacingTokens.p_12,
      ),
    );
  });

  testWidgets('supports md size for all button types', (tester) async {
    for (final type in DlButtonType.values) {
      await pumpButton(
        tester,
        button: DlButton(
          label: 'Type ${type.name}',
          type: type,
          size: DlButtonSize.md,
          onPressed: () {},
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byKey(const Key('dl_button_material')),
          matching: find.byType(Container),
        ),
      );
      expect(container.constraints?.minHeight, 48);
    }
  });

  testWidgets('uses expected size and padding for sm', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Sizing sm',
        size: DlButtonSize.sm,
        onPressed: () {},
      ),
    );

    final container = tester.widget<Container>(
      find.descendant(
        of: find.byKey(const Key('dl_button_material')),
        matching: find.byType(Container),
      ),
    );

    expect(container.constraints?.minHeight, 40);
    expect(
      container.padding,
      const EdgeInsets.fromLTRB(
        DlSpacingTokens.p_16,
        DlSpacingTokens.p_8,
        DlSpacingTokens.p_16,
        DlSpacingTokens.p_8,
      ),
    );
  });

  testWidgets('supports sm size for all button types', (tester) async {
    for (final type in DlButtonType.values) {
      await pumpButton(
        tester,
        button: DlButton(
          label: 'Type ${type.name}',
          type: type,
          size: DlButtonSize.sm,
          onPressed: () {},
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byKey(const Key('dl_button_material')),
          matching: find.byType(Container),
        ),
      );
      expect(container.constraints?.minHeight, 40);
    }
  });

  testWidgets('uses expected size and padding for xs', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Sizing xs',
        size: DlButtonSize.xs,
        onPressed: () {},
      ),
    );

    final container = tester.widget<Container>(
      find.descendant(
        of: find.byKey(const Key('dl_button_material')),
        matching: find.byType(Container),
      ),
    );

    expect(container.constraints?.minHeight, 32);
    expect(
      container.padding,
      const EdgeInsets.fromLTRB(
        DlSpacingTokens.p_12,
        DlSpacingTokens.p_4,
        DlSpacingTokens.p_12,
        DlSpacingTokens.p_4,
      ),
    );
  });

  testWidgets('uses xs gap token for icons', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label: 'Gap xs',
        size: DlButtonSize.xs,
        iconLeft: const DlPlaceholderIcon(),
        iconRight: const DlPlaceholderIcon(),
        onPressed: () {},
      ),
    );

    final gaps = tester
        .widgetList<SizedBox>(
          find.descendant(
            of: find.byKey(const Key('dl_button_material')),
            matching: find.byType(SizedBox),
          ),
        )
        .where((box) => box.width != null)
        .toList();

    expect(gaps, isNotEmpty);
    expect(gaps.any((box) => box.width == DlSpacingTokens.p_4), isTrue);
  });

  testWidgets('supports xs size for all button types', (tester) async {
    for (final type in DlButtonType.values) {
      await pumpButton(
        tester,
        button: DlButton(
          label: 'Type ${type.name}',
          type: type,
          size: DlButtonSize.xs,
          onPressed: () {},
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byKey(const Key('dl_button_material')),
          matching: find.byType(Container),
        ),
      );
      expect(container.constraints?.minHeight, 32);
    }
  });

  testWidgets('limits label to one line with ellipsis', (tester) async {
    await pumpButton(
      tester,
      button: DlButton(
        label:
            'This is a very long button label that should never wrap to a second line in the component.',
        onPressed: () {},
      ),
    );

    final text = tester.widget<Text>(
      find.text(
        'This is a very long button label that should never wrap to a second line in the component.',
      ),
    );

    expect(text.maxLines, 1);
    expect(text.overflow, TextOverflow.ellipsis);
    expect(text.softWrap, isFalse);
  });
}
