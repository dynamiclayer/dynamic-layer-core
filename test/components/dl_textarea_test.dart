import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpTextarea(
    WidgetTester tester, {
    required Widget child,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: child),
      ),
    );
  }

  testWidgets('renders full width, 132 height, grey100 and roundedMd', (
    tester,
  ) async {
    await pumpTextarea(
      tester,
      child: const Center(
        child: SizedBox(
          width: 320,
          child: DlTextarea(placeholder: 'Write here'),
        ),
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_textarea_container')),
    );
    final size = tester.getSize(find.byKey(const Key('dl_textarea_container')));
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;

    expect(size.width, 320);
    expect(size.height, 132);
    expect(container.padding, isNull);
    expect(decoration.color, DlColorsLight.grey100);
    expect(radius.topLeft.x, DlRadiusTokens.roundedMd);
  });

  testWidgets('placeholder uses textBase regular with grey500', (tester) async {
    await pumpTextarea(
      tester,
      child: const DlTextarea(placeholder: 'Placeholder'),
    );

    final textField = tester.widget<TextField>(find.byKey(const Key('dl_textarea_field')));
    final decoration = textField.decoration!;
    final hintStyle = decoration.hintStyle!;

    expect(decoration.hintText, 'Placeholder');
    expect(
      decoration.contentPadding,
      const EdgeInsets.only(
        left: DlSpacingTokens.p_16,
        right: DlSpacingTokens.p_16,
        top: DlSpacingTokens.p_16,
      ),
    );
    expect(hintStyle.fontSize, DlTextStyles.textBase.regular.fontSize);
    expect(hintStyle.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(hintStyle.color, DlColorsLight.grey500);
  });

  testWidgets('disabled placeholder uses grey300 like DlInput', (tester) async {
    await pumpTextarea(
      tester,
      child: const DlTextarea(
        placeholder: 'Disabled placeholder',
        enabled: false,
      ),
    );

    final textField = tester.widget<TextField>(find.byKey(const Key('dl_textarea_field')));
    final hintStyle = textField.decoration!.hintStyle!;
    expect(hintStyle.color, DlColorsLight.grey300);
  });

  testWidgets('typing uses black text style', (tester) async {
    await pumpTextarea(
      tester,
      child: const DlTextarea(placeholder: 'Type'),
    );

    await tester.tap(find.byKey(const Key('dl_textarea_tap_area')));
    await tester.pump();
    await tester.enterText(find.byKey(const Key('dl_textarea_field')), 'Hello');
    await tester.pump();

    final textField = tester.widget<TextField>(find.byKey(const Key('dl_textarea_field')));
    expect(textField.style?.color, DlColorsLight.black);
    expect(textField.style?.fontSize, DlTextStyles.textBase.regular.fontSize);
    expect(textField.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
  });

  testWidgets('field is multi-line and scrollable', (tester) async {
    await pumpTextarea(
      tester,
      child: const DlTextarea(placeholder: 'Type'),
    );

    final textField = tester.widget<TextField>(find.byKey(const Key('dl_textarea_field')));
    expect(textField.maxLines, isNull);
    expect(textField.expands, isTrue);
  });

  testWidgets('gets active black 2px border on focus and clears on outside tap', (
    tester,
  ) async {
    await pumpTextarea(
      tester,
      child: const Scaffold(
        body: Column(
          children: [
            DlTextarea(placeholder: 'Type'),
            SizedBox(height: 40),
            Text('Outside'),
          ],
        ),
      ),
    );

    BoxDecoration decoration() =>
        tester
            .widget<Container>(find.byKey(const Key('dl_textarea_container')))
            .decoration as BoxDecoration;

    expect((decoration().border as Border).top.color, Colors.transparent);
    expect((decoration().border as Border).top.width, 2);

    await tester.tap(find.byKey(const Key('dl_textarea_tap_area')));
    await tester.pump();
    expect((decoration().border as Border).top.color, DlColorsLight.black);
    expect((decoration().border as Border).top.width, 2);

    await tester.tap(find.text('Outside'));
    await tester.pump();
    expect((decoration().border as Border).top.color, Colors.transparent);
  });

  testWidgets('submit action unfocuses textarea', (tester) async {
    await pumpTextarea(
      tester,
      child: const DlTextarea(placeholder: 'Type'),
    );

    await tester.tap(find.byKey(const Key('dl_textarea_tap_area')));
    await tester.pump();
    await tester.enterText(find.byKey(const Key('dl_textarea_field')), 'Hello');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    final decoration = tester
            .widget<Container>(find.byKey(const Key('dl_textarea_container')))
            .decoration
        as BoxDecoration;
    final border = decoration.border as Border;
    expect(border.top.color, Colors.transparent);
  });
}
