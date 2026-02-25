import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpOtpInput(
    WidgetTester tester, {
    DlOTPInput? input,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(
          body: Center(
            child: input ?? const DlOTPInput(),
          ),
        ),
      ),
    );
  }

  testWidgets('md renders 48x48 with grey100 and roundedMd', (tester) async {
    await pumpOtpInput(tester);

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_otp_input_container')),
    );
    final size = tester.getSize(find.byKey(const Key('dl_otp_input_container')));
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;

    expect(size.width, 48);
    expect(size.height, 48);
    expect(decoration.color, DlColorsLight.grey100);
    expect(radius.topLeft.x, DlRadiusTokens.roundedMd);
  });

  testWidgets('lg renders 56x56 and sm renders 40x40', (tester) async {
    await pumpOtpInput(
      tester,
      input: const DlOTPInput(size: DlOtpInputSize.lg),
    );
    var size = tester.getSize(find.byKey(const Key('dl_otp_input_container')));
    expect(size.width, 56);
    expect(size.height, 56);

    await pumpOtpInput(
      tester,
      input: const DlOTPInput(size: DlOtpInputSize.sm),
    );
    size = tester.getSize(find.byKey(const Key('dl_otp_input_container')));
    expect(size.width, 40);
    expect(size.height, 40);
  });

  testWidgets('error state uses red50 background and red500 2px border', (tester) async {
    await pumpOtpInput(tester, input: const DlOTPInput(state: DlOtpInputState.error));

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_otp_input_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final border = decoration.border as Border;

    expect(decoration.color, DlColorsLight.red50);
    expect(border.top.width, 2);
    expect(border.top.color, DlColorsLight.red500);
  });

  testWidgets('success state uses green50 background and green500 2px border', (
    tester,
  ) async {
    await pumpOtpInput(
      tester,
      input: const DlOTPInput(state: DlOtpInputState.success),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_otp_input_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final border = decoration.border as Border;

    expect(decoration.color, DlColorsLight.green50);
    expect(border.top.width, 2);
    expect(border.top.color, DlColorsLight.green500);
  });

  testWidgets('error and success states use red500 and green500 text colors', (
    tester,
  ) async {
    await pumpOtpInput(
      tester,
      input: const DlOTPInput(state: DlOtpInputState.error),
    );
    await tester.tap(find.byKey(const Key('dl_otp_input_tap_area')));
    await tester.pump();
    await tester.enterText(find.byKey(const Key('dl_otp_input_text_field')), '7');
    await tester.pump();

    var field = tester.widget<TextField>(find.byKey(const Key('dl_otp_input_text_field')));
    expect(field.style?.color, DlColorsLight.red500);

    await pumpOtpInput(
      tester,
      input: const DlOTPInput(state: DlOtpInputState.success),
    );
    await tester.tap(find.byKey(const Key('dl_otp_input_tap_area')));
    await tester.pump();
    await tester.enterText(find.byKey(const Key('dl_otp_input_text_field')), '7');
    await tester.pump();

    field = tester.widget<TextField>(find.byKey(const Key('dl_otp_input_text_field')));
    expect(field.style?.color, DlColorsLight.green500);
  });

  testWidgets('error and success use matching cursor and mask dot colors', (
    tester,
  ) async {
    await pumpOtpInput(
      tester,
      input: const DlOTPInput(state: DlOtpInputState.error),
    );
    await tester.tap(find.byKey(const Key('dl_otp_input_text_field')));
    await tester.pump();
    await tester.enterText(find.byKey(const Key('dl_otp_input_text_field')), '8');
    await tester.pump();
    var field = tester.widget<TextField>(find.byKey(const Key('dl_otp_input_text_field')));
    expect(field.cursorColor, DlColorsLight.red500);
    await tester.pump(const Duration(milliseconds: 600));
    var dot = tester.widget<Container>(find.byKey(const Key('dl_otp_input_mask_dot')));
    var decoration = dot.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.red500);

    await pumpOtpInput(
      tester,
      input: const DlOTPInput(state: DlOtpInputState.success),
    );
    await tester.tap(find.byKey(const Key('dl_otp_input_tap_area')));
    await tester.pump();
    await tester.enterText(find.byKey(const Key('dl_otp_input_text_field')), '8');
    await tester.pump();
    field = tester.widget<TextField>(find.byKey(const Key('dl_otp_input_text_field')));
    expect(field.cursorColor, DlColorsLight.green500);
    await tester.pump(const Duration(milliseconds: 600));
    dot = tester.widget<Container>(find.byKey(const Key('dl_otp_input_mask_dot')));
    decoration = dot.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.green500);
  });

  testWidgets('whole area tap focuses and shows black 2px active border', (
    tester,
  ) async {
    await pumpOtpInput(
      tester,
      input: DlOTPInput(
        onChanged: (_) {},
      ),
    );

    await tester.tap(find.byKey(const Key('dl_otp_input_tap_area')));
    await tester.pump();

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_otp_input_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final border = decoration.border as Border;
    expect(border.top.width, 2);
    expect(border.top.color, DlColorsLight.black);
  });

  testWidgets('accepts only one digit and masks to 10x10 black dot', (tester) async {
    await pumpOtpInput(tester);

    final fieldFinder = find.byKey(const Key('dl_otp_input_text_field'));
    await tester.tap(fieldFinder);
    await tester.pump();
    await tester.enterText(fieldFinder, '12');
    await tester.pump();

    // Only one character should remain due to input formatters.
    final textField = tester.widget<TextField>(fieldFinder);
    expect(textField.controller?.text, '1');

    // Initially visible character, mask dot not shown immediately.
    expect(find.byKey(const Key('dl_otp_input_mask_dot')), findsNothing);

    await tester.pump(const Duration(milliseconds: 600));
    expect(find.byKey(const Key('dl_otp_input_mask_dot')), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const Key('dl_otp_input_mask_dot'))),
      const Size(10, 10),
    );
  });

  testWidgets('tap outside unfocuses and returns to default border', (tester) async {
    await pumpOtpInput(tester);

    final fieldFinder = find.byKey(const Key('dl_otp_input_text_field'));
    await tester.tap(fieldFinder);
    await tester.pump();

    await tester.tapAt(const Offset(5, 5));
    await tester.pump();

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_otp_input_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final border = decoration.border as Border;
    expect(border.top.color, Colors.transparent);
  });

  testWidgets('disabled state is not clickable and shows grey500 hyphen textBase regular', (
    tester,
  ) async {
    await pumpOtpInput(
      tester,
      input: const DlOTPInput(state: DlOtpInputState.disabled),
    );

    final text = tester.widget<Text>(find.byKey(const Key('dl_otp_input_disabled_text')));
    final container = tester.widget<Container>(
      find.byKey(const Key('dl_otp_input_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final border = decoration.border as Border;

    expect(text.data, '-');
    expect(text.style?.fontSize, DlTextStyles.textBase.regular.fontSize);
    expect(text.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(text.style?.color, DlColorsLight.grey500);
    expect(find.byKey(const Key('dl_otp_input_text_field')), findsNothing);
    expect(border.top.color, Colors.transparent);

    await tester.tap(find.byKey(const Key('dl_otp_input_tap_area')));
    await tester.pump();
    expect(border.top.color, Colors.transparent);
    expect(decoration.color, DlColorsLight.grey100);
  });
}
