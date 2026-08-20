import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpInput(
    WidgetTester tester, {
    required DlInput input,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: input)),
      ),
    );
  }

  testWidgets('uses grey100 background, roundedMd and p16 padding', (
    tester,
  ) async {
    await pumpInput(tester, input: const DlInput(placeholder: 'Placeholder'));

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_input_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;

    expect(decoration.color, DlColorsLight.grey100);
    expect(radius.topLeft.x, DlRadiusTokens.roundedMd);
    expect(container.padding, const EdgeInsets.all(DlSpacingTokens.p_16));
  });

  testWidgets('md size uses p16 horizontal and p12 vertical in default', (
    tester,
  ) async {
    await pumpInput(
      tester,
      input: const DlInput(placeholder: 'Placeholder', size: DlInputSize.md),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_input_container')),
    );
    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_16,
        vertical: DlSpacingTokens.p_12,
      ),
    );
  });

  testWidgets('sm size uses p12 horizontal and p8 vertical in default', (
    tester,
  ) async {
    await pumpInput(
      tester,
      input: const DlInput(placeholder: 'Placeholder', size: DlInputSize.sm),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_input_container')),
    );
    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_12,
        vertical: DlSpacingTokens.p_8,
      ),
    );
  });

  testWidgets('placeholder uses textBase regular and grey500', (tester) async {
    await pumpInput(
      tester,
      input: const DlInput(placeholder: 'Your placeholder'),
    );

    final textField = tester.widget<TextField>(
      find.byKey(const Key('dl_input_text_field')),
    );
    final decoration = textField.decoration!;
    final hintStyle = decoration.hintStyle!;

    expect(decoration.hintText, 'Your placeholder');
    expect(hintStyle.fontSize, DlTextStyles.textBase.regular.fontSize);
    expect(hintStyle.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(hintStyle.color, DlColorsLight.grey500);
    expect(find.byKey(const Key('dl_input_active_placeholder')), findsNothing);
  });

  testWidgets('error type uses red500 placeholder color', (tester) async {
    await pumpInput(
      tester,
      input: const DlInput(
        placeholder: 'Error placeholder',
        type: DlInputType.error,
      ),
    );

    final textField = tester.widget<TextField>(
      find.byKey(const Key('dl_input_text_field')),
    );
    final hintStyle = textField.decoration!.hintStyle!;

    expect(hintStyle.color, DlColorsLight.red500);
    expect(find.byKey(const Key('dl_input_error_helper_text')), findsOneWidget);
  });

  testWidgets('success type uses green500 placeholder color', (tester) async {
    await pumpInput(
      tester,
      input: const DlInput(
        placeholder: 'Success placeholder',
        type: DlInputType.success,
      ),
    );

    final textField = tester.widget<TextField>(
      find.byKey(const Key('dl_input_text_field')),
    );
    final hintStyle = textField.decoration!.hintStyle!;

    expect(hintStyle.color, DlColorsLight.green500);
    expect(find.byKey(const Key('dl_input_error_helper_text')), findsNothing);
  });

  testWidgets(
    'active state shows 2px black stroke and stacked placeholder in textXs regular',
    (tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await pumpInput(
        tester,
        input: DlInput(placeholder: 'Your placeholder', focusNode: focusNode),
      );

      await tester.tap(find.byKey(const Key('dl_input_text_field')));
      await tester.pump();

      final container = tester.widget<Container>(
        find.byKey(const Key('dl_input_container')),
      );
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;

      expect(border.top.width, 2);
      expect(border.top.color, DlColorsLight.black);
      expect(
        container.padding,
        const EdgeInsets.symmetric(
          horizontal: DlSpacingTokens.p_16,
          vertical: DlSpacingTokens.p_8,
        ),
      );
      expect(find.byKey(const Key('dl_input_active_content')), findsOneWidget);

      final activePlaceholder = tester.widget<Text>(
        find.byKey(const Key('dl_input_active_placeholder')),
      );
      expect(activePlaceholder.data, 'Your placeholder');
      expect(
        activePlaceholder.style?.fontSize,
        DlTextStyles.textXs.regular.fontSize,
      );
      expect(
        activePlaceholder.style?.fontWeight,
        DlTextStyles.textXs.regular.fontWeight,
      );
      expect(activePlaceholder.style?.color, DlColorsLight.grey500);

      final textField = tester.widget<TextField>(
        find.byKey(const Key('dl_input_text_field')),
      );
      expect(textField.style?.fontSize, DlTextStyles.textBase.regular.fontSize);
      expect(
        textField.style?.fontWeight,
        DlTextStyles.textBase.regular.fontWeight,
      );
      expect(textField.decoration?.hintText, isNull);
    },
  );

  testWidgets('md size uses p4 vertical in active state', (tester) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    await pumpInput(
      tester,
      input: DlInput(
        placeholder: 'Placeholder',
        size: DlInputSize.md,
        focusNode: focusNode,
      ),
    );

    await tester.tap(find.byKey(const Key('dl_input_text_field')));
    await tester.pump();

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_input_container')),
    );
    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_16,
        vertical: DlSpacingTokens.p_4,
      ),
    );
  });

  testWidgets('sm size uses p0 vertical and p12 horizontal in active state', (
    tester,
  ) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    await pumpInput(
      tester,
      input: DlInput(
        placeholder: 'Placeholder',
        size: DlInputSize.sm,
        focusNode: focusNode,
      ),
    );

    await tester.tap(find.byKey(const Key('dl_input_text_field')));
    await tester.pump();

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_input_container')),
    );
    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_12,
        vertical: DlSpacingTokens.p_0,
      ),
    );
  });

  testWidgets('error type keeps active stacked placeholder red500', (
    tester,
  ) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    await pumpInput(
      tester,
      input: DlInput(
        placeholder: 'Error placeholder',
        type: DlInputType.error,
        focusNode: focusNode,
      ),
    );

    await tester.tap(find.byKey(const Key('dl_input_text_field')));
    await tester.pump();

    final activePlaceholder = tester.widget<Text>(
      find.byKey(const Key('dl_input_active_placeholder')),
    );
    expect(activePlaceholder.style?.color, DlColorsLight.red500);
    expect(find.byKey(const Key('dl_input_error_helper_text')), findsOneWidget);
  });

  testWidgets('success type keeps active stacked placeholder green500', (
    tester,
  ) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    await pumpInput(
      tester,
      input: DlInput(
        placeholder: 'Success placeholder',
        type: DlInputType.success,
        focusNode: focusNode,
      ),
    );

    await tester.tap(find.byKey(const Key('dl_input_text_field')));
    await tester.pump();

    final activePlaceholder = tester.widget<Text>(
      find.byKey(const Key('dl_input_active_placeholder')),
    );
    expect(activePlaceholder.style?.color, DlColorsLight.green500);
    expect(find.byKey(const Key('dl_input_error_helper_text')), findsNothing);
  });

  testWidgets('error type shows fixed circle-alert icon on right side', (
    tester,
  ) async {
    await pumpInput(
      tester,
      input: const DlInput(
        placeholder: 'Error placeholder',
        type: DlInputType.error,
      ),
    );

    final errorIcon = tester.widget<DlAssetIcon>(
      find.byKey(const Key('dl_input_type_icon_error')),
    );
    expect(errorIcon.assetPath, DlIcons.circleAlertAsset);
    expect(errorIcon.color, DlColorsLight.red500);
  });

  testWidgets('success type shows fixed circle-check icon on right side', (
    tester,
  ) async {
    await pumpInput(
      tester,
      input: const DlInput(
        placeholder: 'Success placeholder',
        type: DlInputType.success,
      ),
    );

    final successIcon = tester.widget<DlAssetIcon>(
      find.byKey(const Key('dl_input_type_icon_success')),
    );
    expect(successIcon.assetPath, DlIcons.circleCheckAsset);
    expect(successIcon.color, DlColorsLight.green600);
  });

  testWidgets('fixed type icon overrides optional custom right icon', (
    tester,
  ) async {
    await pumpInput(
      tester,
      input: const DlInput(
        placeholder: 'Error placeholder',
        type: DlInputType.error,
        iconRight: Icon(Icons.close, key: Key('custom_right_icon')),
      ),
    );

    expect(find.byKey(const Key('custom_right_icon')), findsNothing);
    expect(find.byKey(const Key('dl_input_type_icon_error')), findsOneWidget);
  });

  testWidgets(
    'error helper text is configurable and always visible for error type',
    (tester) async {
      final focusNode = FocusNode();
      final controller = TextEditingController();
      addTearDown(focusNode.dispose);
      addTearDown(controller.dispose);

      await pumpInput(
        tester,
        input: DlInput(
          placeholder: 'Error placeholder',
          type: DlInputType.error,
          errorHelperText: 'Custom helper',
          focusNode: focusNode,
          controller: controller,
        ),
      );

      Text helper() => tester.widget<Text>(
        find.byKey(const Key('dl_input_error_helper_text')),
      );

      expect(helper().data, 'Custom helper');
      expect(helper().style?.fontSize, DlTextStyles.textSm.medium.fontSize);
      expect(helper().style?.fontWeight, DlTextStyles.textSm.medium.fontWeight);
      expect(helper().style?.color, DlColorsLight.red500);
      expect(helper().maxLines, isNull);

      await tester.tap(find.byKey(const Key('dl_input_text_field')));
      await tester.pump();
      expect(
        find.byKey(const Key('dl_input_error_helper_text')),
        findsOneWidget,
      );

      await tester.enterText(
        find.byKey(const Key('dl_input_text_field')),
        'abc',
      );
      await tester.pump();
      await tester.tapAt(const Offset(5, 5));
      await tester.pump();
      expect(
        find.byKey(const Key('dl_input_error_helper_text')),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'filled state keeps stacked placeholder and value visible without black stroke',
    (tester) async {
      final focusNode = FocusNode();
      final controller = TextEditingController();
      addTearDown(focusNode.dispose);
      addTearDown(controller.dispose);

      await pumpInput(
        tester,
        input: DlInput(
          placeholder: 'Your placeholder',
          focusNode: focusNode,
          controller: controller,
        ),
      );

      final fieldFinder = find.byKey(const Key('dl_input_text_field'));
      await tester.tap(fieldFinder);
      await tester.pump();
      await tester.enterText(fieldFinder, 'Hello');
      await tester.pump();

      // Unfocus to move from active to filled.
      await tester.tapAt(const Offset(5, 5));
      await tester.pump();

      final container = tester.widget<Container>(
        find.byKey(const Key('dl_input_container')),
      );
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;

      expect(focusNode.hasFocus, isFalse);
      expect(
        find.byKey(const Key('dl_input_active_placeholder')),
        findsOneWidget,
      );
      expect(find.text('Hello'), findsOneWidget);
      expect(border.top.width, 2);
      expect(border.top.color, Colors.transparent);
      expect(
        container.padding,
        const EdgeInsets.symmetric(
          horizontal: DlSpacingTokens.p_16,
          vertical: DlSpacingTokens.p_8,
        ),
      );
    },
  );

  testWidgets('filled returns to default when value becomes empty', (
    tester,
  ) async {
    final focusNode = FocusNode();
    final controller = TextEditingController(text: 'Hello');
    addTearDown(focusNode.dispose);
    addTearDown(controller.dispose);

    await pumpInput(
      tester,
      input: DlInput(
        placeholder: 'Your placeholder',
        focusNode: focusNode,
        controller: controller,
      ),
    );
    await tester.pump();

    // With initial text and no focus, stacked placeholder is visible.
    expect(
      find.byKey(const Key('dl_input_active_placeholder')),
      findsOneWidget,
    );

    final fieldFinder = find.byKey(const Key('dl_input_text_field'));
    await tester.tap(fieldFinder);
    await tester.pump();
    await tester.enterText(fieldFinder, '');
    await tester.pump();
    await tester.tapAt(const Offset(5, 5));
    await tester.pump();

    final textField = tester.widget<TextField>(fieldFinder);
    expect(focusNode.hasFocus, isFalse);
    expect(find.byKey(const Key('dl_input_active_placeholder')), findsNothing);
    expect(textField.decoration?.hintText, 'Your placeholder');
  });

  testWidgets('md size uses p4 vertical in filled state', (tester) async {
    final focusNode = FocusNode();
    final controller = TextEditingController();
    addTearDown(focusNode.dispose);
    addTearDown(controller.dispose);

    await pumpInput(
      tester,
      input: DlInput(
        placeholder: 'Placeholder',
        size: DlInputSize.md,
        focusNode: focusNode,
        controller: controller,
      ),
    );

    final fieldFinder = find.byKey(const Key('dl_input_text_field'));
    await tester.tap(fieldFinder);
    await tester.pump();
    await tester.enterText(fieldFinder, 'Hello');
    await tester.pump();
    await tester.tapAt(const Offset(5, 5));
    await tester.pump();

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_input_container')),
    );
    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_16,
        vertical: DlSpacingTokens.p_4,
      ),
    );
  });

  testWidgets('sm size uses p0 vertical and p12 horizontal in filled state', (
    tester,
  ) async {
    final focusNode = FocusNode();
    final controller = TextEditingController();
    addTearDown(focusNode.dispose);
    addTearDown(controller.dispose);

    await pumpInput(
      tester,
      input: DlInput(
        placeholder: 'Placeholder',
        size: DlInputSize.sm,
        focusNode: focusNode,
        controller: controller,
      ),
    );

    final fieldFinder = find.byKey(const Key('dl_input_text_field'));
    await tester.tap(fieldFinder);
    await tester.pump();
    await tester.enterText(fieldFinder, 'Hello');
    await tester.pump();
    await tester.tapAt(const Offset(5, 5));
    await tester.pump();

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_input_container')),
    );
    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_12,
        vertical: DlSpacingTokens.p_0,
      ),
    );
  });

  testWidgets(
    'first tap focuses input and keeps text field active without second tap',
    (tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await pumpInput(
        tester,
        input: DlInput(placeholder: 'Placeholder', focusNode: focusNode),
      );

      final fieldFinder = find.byKey(const Key('dl_input_text_field'));
      await tester.tap(fieldFinder);
      await tester.pump();

      expect(focusNode.hasFocus, isTrue);
      await tester.enterText(fieldFinder, 'abc');
      await tester.pump();
      expect(find.text('abc'), findsOneWidget);
    },
  );

  testWidgets('renders optional left and right icons with p16 gap', (
    tester,
  ) async {
    await pumpInput(
      tester,
      input: const DlInput(
        placeholder: 'Placeholder',
        iconLeft: Icon(Icons.search, key: Key('left_icon')),
        iconRight: Icon(Icons.close, key: Key('right_icon')),
      ),
    );

    expect(find.byKey(const Key('left_icon')), findsOneWidget);
    expect(find.byKey(const Key('right_icon')), findsOneWidget);
    final leftTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_input_icon_left_theme')),
    );
    final rightTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_input_icon_right_theme')),
    );
    expect(leftTheme.data.color, DlColorsLight.grey500);
    expect(rightTheme.data.color, DlColorsLight.grey500);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.width == DlSpacingTokens.p_16,
      ),
      findsNWidgets(2),
    );
  });

  testWidgets('can focus and enter text like normal input field', (
    tester,
  ) async {
    await pumpInput(tester, input: const DlInput(placeholder: 'Placeholder'));

    final fieldFinder = find.byKey(const Key('dl_input_text_field'));
    await tester.tap(fieldFinder);
    await tester.pump();
    await tester.enterText(fieldFinder, 'Hello');
    await tester.pump();

    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('unfocuses when tapping outside the input field', (tester) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    await pumpInput(
      tester,
      input: DlInput(placeholder: 'Placeholder', focusNode: focusNode),
    );

    final fieldFinder = find.byKey(const Key('dl_input_text_field'));
    await tester.tap(fieldFinder);
    await tester.pump();
    expect(focusNode.hasFocus, isTrue);

    await tester.tapAt(const Offset(5, 5));
    await tester.pump();
    expect(focusNode.hasFocus, isFalse);
  });

  testWidgets('disabled uses grey300 placeholder and is not focusable', (
    tester,
  ) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    await pumpInput(
      tester,
      input: DlInput(
        placeholder: 'Disabled placeholder',
        focusNode: focusNode,
        enabled: false,
      ),
    );

    final textField = tester.widget<TextField>(
      find.byKey(const Key('dl_input_text_field')),
    );
    final hintStyle = textField.decoration!.hintStyle!;

    expect(hintStyle.color, DlColorsLight.grey300);
    expect(textField.enabled, isFalse);

    await tester.tap(find.byKey(const Key('dl_input_text_field')));
    await tester.pump();
    expect(focusNode.hasFocus, isFalse);
  });

  testWidgets('full grey input area is tappable and focuses text field', (
    tester,
  ) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    await pumpInput(
      tester,
      input: DlInput(placeholder: 'Placeholder', focusNode: focusNode),
    );

    expect(focusNode.hasFocus, isFalse);
    await tester.tap(find.byKey(const Key('dl_input_tap_area')));
    await tester.pump();
    expect(focusNode.hasFocus, isTrue);
  });
}
