import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpMessageDock(
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

  testWidgets('renders white dock with optional separator', (tester) async {
    await pumpMessageDock(
      tester,
      child: const DlMessageDock(),
    );

    final dock = tester.widget<Container>(find.byKey(const Key('dl_message_dock')));
    expect(dock.color, DlColorsLight.white);
    expect(find.byKey(const Key('dl_message_dock_separator')), findsOneWidget);

    await pumpMessageDock(
      tester,
      child: const DlMessageDock(showSeparator: false),
    );
    expect(find.byKey(const Key('dl_message_dock_separator')), findsNothing);
  });

  testWidgets('content has p16 outer padding and p8 gap between elements', (
    tester,
  ) async {
    await pumpMessageDock(
      tester,
      child: const DlMessageDock(),
    );

    final padding = tester.widget<Padding>(find.byType(Padding).first);
    expect(padding.padding, const EdgeInsets.all(DlSpacingTokens.p_16));

    final gapFinder = find.descendant(
      of: find.byKey(const Key('dl_message_dock_content')),
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.width == DlSpacingTokens.p_8,
      ),
    );
    expect(gapFinder, findsOneWidget);
  });

  testWidgets('message input uses grey100 roundedMd and text box p12 with placeholder style', (
    tester,
  ) async {
    await pumpMessageDock(
      tester,
      child: const DlMessageDock(placeholder: 'Write message'),
    );

    final inputContainer = tester.widget<Container>(
      find.byKey(const Key('dl_message_dock_input_container')),
    );
    final textBox = tester.widget<Padding>(
      find.byKey(const Key('dl_message_dock_input_text_box')),
    );
    final decoration = inputContainer.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;
    expect(decoration.color, DlColorsLight.grey100);
    expect(radius.topLeft.x, DlRadiusTokens.roundedMd);
    expect(textBox.padding, const EdgeInsets.all(DlSpacingTokens.p_12));

    final textField = tester.widget<TextField>(
      find.byKey(const Key('dl_message_dock_input')),
    );
    final hintStyle = textField.decoration?.hintStyle;
    expect(textField.decoration?.hintText, 'Write message');
    expect(hintStyle?.fontSize, DlTextStyles.textBase.regular.fontSize);
    expect(hintStyle?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(hintStyle?.color, DlColorsLight.grey500);
  });

  testWidgets('message input grows when text becomes multiline', (tester) async {
    await pumpMessageDock(
      tester,
      child: const SizedBox(
        width: 360,
        child: DlMessageDock(),
      ),
    );

    final inputContainerFinder = find.byKey(const Key('dl_message_dock_input_container'));
    final inputFinder = find.byKey(const Key('dl_message_dock_input'));

    final beforeHeight = tester.getSize(inputContainerFinder).height;
    await tester.enterText(inputFinder, 'Line 1\nLine 2');
    await tester.pump();
    final afterHeight = tester.getSize(inputContainerFinder).height;

    expect(afterHeight, greaterThan(beforeHeight));
  });

  testWidgets('shows 48x48 action box with primary xs button after first character', (
    tester,
  ) async {
    await pumpMessageDock(
      tester,
      child: const DlMessageDock(),
    );

    expect(find.byKey(const Key('dl_message_dock_action_box')), findsNothing);

    await tester.enterText(find.byKey(const Key('dl_message_dock_input')), 'a');
    await tester.pump();

    final actionBoxSize = tester.getSize(find.byKey(const Key('dl_message_dock_action_box')));
    expect(actionBoxSize, const Size(48, 48));

    final actionButton = tester.widget<DlButtonIcon>(
      find.byKey(const Key('dl_message_dock_action_button')),
    );
    expect(actionButton.type, DlButtonType.primary);
    expect(actionButton.size, DlButtonSize.xs);
    expect(actionButton.onPressed, isNotNull);
  });

  testWidgets('secondary icon button stays bottom-aligned when input grows', (
    tester,
  ) async {
    await pumpMessageDock(
      tester,
      child: const SizedBox(
        width: 360,
        child: DlMessageDock(),
      ),
    );

    await tester.enterText(
      find.byKey(const Key('dl_message_dock_input')),
      'Line 1\nLine 2\nLine 3\nLine 4',
    );
    await tester.pump();

    final iconBottom =
        tester.getBottomRight(find.byKey(const Key('dl_message_dock_icon_button'))).dy;
    final inputBottom =
        tester.getBottomRight(find.byKey(const Key('dl_message_dock_input_container'))).dy;

    expect((iconBottom - inputBottom).abs(), lessThanOrEqualTo(1.0));
  });

  testWidgets('left and right actions are clickable via callbacks', (tester) async {
    var leftTapped = 0;
    var rightTapped = 0;

    await pumpMessageDock(
      tester,
      child: DlMessageDock(
        onIconPressed: () => leftTapped++,
        onActionPressed: () => rightTapped++,
      ),
    );

    await tester.tap(find.byKey(const Key('dl_message_dock_icon_button')));
    await tester.pump();
    expect(leftTapped, 1);

    await tester.enterText(find.byKey(const Key('dl_message_dock_input')), 'a');
    await tester.pump();
    await tester.tap(find.byKey(const Key('dl_message_dock_action_box')));
    await tester.pump();
    expect(rightTapped, 1);
  });

  testWidgets('onSend returns trimmed text and clears input by default', (tester) async {
    String? sentText;

    await pumpMessageDock(
      tester,
      child: DlMessageDock(
        onSend: (text) => sentText = text,
      ),
    );

    await tester.enterText(find.byKey(const Key('dl_message_dock_input')), '  Hello  ');
    await tester.pump();
    await tester.tap(find.byKey(const Key('dl_message_dock_action_box')));
    await tester.pump();

    final input = tester.widget<TextField>(find.byKey(const Key('dl_message_dock_input')));
    expect(sentText, 'Hello');
    expect(input.controller?.text ?? '', isEmpty);
  });

  testWidgets('clearOnSend false keeps message text', (tester) async {
    await pumpMessageDock(
      tester,
      child: const DlMessageDock(clearOnSend: false),
    );

    await tester.enterText(find.byKey(const Key('dl_message_dock_input')), 'Keep me');
    await tester.pump();
    await tester.tap(find.byKey(const Key('dl_message_dock_action_box')));
    await tester.pump();

    final input = tester.widget<TextField>(find.byKey(const Key('dl_message_dock_input')));
    expect(input.controller?.text, 'Keep me');
  });

  testWidgets('spaces-only text does not show action button', (tester) async {
    await pumpMessageDock(
      tester,
      child: const DlMessageDock(),
    );

    await tester.enterText(find.byKey(const Key('dl_message_dock_input')), '   ');
    await tester.pump();
    expect(find.byKey(const Key('dl_message_dock_action_box')), findsNothing);
  });
}
