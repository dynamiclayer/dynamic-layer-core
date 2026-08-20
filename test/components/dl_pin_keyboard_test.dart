import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpPinKey(
    WidgetTester tester, {
    required DlPinKeyboard keyWidget,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: keyWidget)),
      ),
    );
  }

  testWidgets('renders 80x80 grey100 roundedFull with centered texts', (tester) async {
    await pumpPinKey(
      tester,
      keyWidget: const DlPinKeyboard(number: '1', alphabet: 'ABC'),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_pin_keyboard_container')),
    );
    final size = tester.getSize(find.byKey(const Key('dl_pin_keyboard_container')));
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;

    expect(size, const Size(80, 80));
    expect(decoration.color, DlColorsLight.grey100);
    expect(radius.topLeft.x, DlRadiusTokens.roundedFull);

    final number = tester.widget<Text>(find.byKey(const Key('dl_pin_keyboard_number')));
    final alphabet = tester.widget<Text>(
      find.byKey(const Key('dl_pin_keyboard_alphabet')),
    );
    expect(number.style?.fontSize, DlTextStyles.text3Xl.regular.fontSize);
    expect(number.style?.fontWeight, DlTextStyles.text3Xl.regular.fontWeight);
    expect(number.style?.color, DlColorsLight.black);
    expect(alphabet.style?.fontSize, DlTextStyles.textSm.regular.fontSize);
    expect(alphabet.style?.fontWeight, DlTextStyles.textSm.regular.fontWeight);
    expect(alphabet.style?.color, DlColorsLight.grey500);
  });

  testWidgets('alphabet is optional', (tester) async {
    await pumpPinKey(
      tester,
      keyWidget: const DlPinKeyboard(number: '2'),
    );

    expect(find.byKey(const Key('dl_pin_keyboard_number')), findsOneWidget);
    expect(find.byKey(const Key('dl_pin_keyboard_alphabet')), findsNothing);
  });

  testWidgets('pressed state uses grey200 background', (tester) async {
    await pumpPinKey(
      tester,
      keyWidget: const DlPinKeyboard(number: '3', state: DlPinKeyboardState.pressed),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_pin_keyboard_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.grey200);
  });

  testWidgets('tap down/up toggles background between default and pressed', (
    tester,
  ) async {
    await pumpPinKey(
      tester,
      keyWidget: const DlPinKeyboard(number: '4'),
    );

    BoxDecoration decoration() =>
        tester
            .widget<Container>(find.byKey(const Key('dl_pin_keyboard_container')))
            .decoration as BoxDecoration;

    expect(decoration().color, DlColorsLight.grey100);

    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(const Key('dl_pin_keyboard_tap_area'))),
    );
    await tester.pump();
    expect(decoration().color, DlColorsLight.grey200);

    await gesture.up();
    await tester.pump();
    expect(decoration().color, DlColorsLight.grey100);
  });

  testWidgets('icon type shows icon and hides text widgets', (tester) async {
    await pumpPinKey(
      tester,
      keyWidget: const DlPinKeyboard(type: DlPinKeyboardType.icon),
    );

    expect(find.byKey(const Key('dl_pin_keyboard_icon')), findsOneWidget);
    expect(find.byType(DlPlaceholderIcon), findsOneWidget);
    expect(find.byKey(const Key('dl_pin_keyboard_text_column')), findsNothing);
    expect(find.byKey(const Key('dl_pin_keyboard_number')), findsNothing);
    expect(find.byKey(const Key('dl_pin_keyboard_alphabet')), findsNothing);
  });
}
