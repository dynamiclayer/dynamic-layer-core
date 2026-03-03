import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpMessage(
    WidgetTester tester, {
    required DlMessage child,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: child)),
      ),
    );
  }

  testWidgets('message type uses grey100 box with p12 and roundedMd', (
    tester,
  ) async {
    await pumpMessage(
      tester,
      child: const DlMessage(
        type: DlMessageType.message,
        author: 'Author',
        message: 'Hello message',
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_message_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;

    expect(container.padding, const EdgeInsets.all(DlSpacingTokens.p_12));
    expect(decoration.color, DlColorsLight.grey100);
    expect(radius.topLeft.x, DlRadiusTokens.roundedMd);
  });

  testWidgets('message type shows optional author and regular message text', (
    tester,
  ) async {
    await pumpMessage(
      tester,
      child: const DlMessage(
        type: DlMessageType.message,
        author: 'Joshua',
        message: 'How are you?',
      ),
    );

    final author = tester.widget<Text>(
      find.byKey(const Key('dl_message_author')),
    );
    final message = tester.widget<Text>(
      find.byKey(const Key('dl_message_text')),
    );

    expect(author.data, 'Joshua');
    expect(author.style?.fontWeight, DlTextStyles.textBase.semiBold.fontWeight);
    expect(author.style?.color, DlColorsLight.black);

    expect(message.data, 'How are you?');
    expect(message.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(message.style?.color, DlColorsLight.black);
  });

  testWidgets('message type hides author when not provided', (tester) async {
    await pumpMessage(
      tester,
      child: const DlMessage(
        type: DlMessageType.message,
        message: 'Only message',
      ),
    );

    expect(find.byKey(const Key('dl_message_author')), findsNothing);
    expect(find.byKey(const Key('dl_message_text')), findsOneWidget);
  });

  testWidgets('ownMessage type uses grey800 and white regular message', (
    tester,
  ) async {
    await pumpMessage(
      tester,
      child: const DlMessage(
        type: DlMessageType.ownMessage,
        author: 'Ignored',
        message: 'My own message',
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_message_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final message = tester.widget<Text>(
      find.byKey(const Key('dl_message_text')),
    );

    expect(decoration.color, DlColorsLight.grey800);
    expect(message.style?.color, DlColorsLight.white);
    expect(find.byKey(const Key('dl_message_author')), findsNothing);
  });

  testWidgets('message width is limited to max 240', (tester) async {
    await pumpMessage(
      tester,
      child: const DlMessage(
        type: DlMessageType.message,
        message:
            'This is a very long message that should wrap and never exceed two hundred and forty pixels in width.',
      ),
    );

    final width = tester
        .getSize(find.byKey(const Key('dl_message_container')))
        .width;
    expect(width <= 240, isTrue);
  });

  testWidgets('response state for message shows grey200 box under author', (
    tester,
  ) async {
    await pumpMessage(
      tester,
      child: const DlMessage(
        type: DlMessageType.message,
        state: DlMessageState.response,
        author: 'Joshua',
        responseTitle: 'Response Author',
        responseMessage: 'Response message',
        message: 'Main message',
      ),
    );

    final responseBox = tester.widget<Container>(
      find.byKey(const Key('dl_message_response_box')),
    );
    final responseDecoration = responseBox.decoration as BoxDecoration;
    final responseTitle = tester.widget<Text>(
      find.byKey(const Key('dl_message_response_title')),
    );
    final responseText = tester.widget<Text>(
      find.byKey(const Key('dl_message_response_text')),
    );

    expect(responseBox.padding, const EdgeInsets.all(DlSpacingTokens.p_12));
    expect(responseDecoration.color, DlColorsLight.grey200);
    expect(
      (responseDecoration.borderRadius as BorderRadius).topLeft.x,
      DlRadiusTokens.rounded,
    );
    expect(
      responseTitle.style?.fontWeight,
      DlTextStyles.textXs.semiBold.fontWeight,
    );
    expect(responseTitle.style?.color, DlColorsLight.black);
    expect(
      responseText.style?.fontWeight,
      DlTextStyles.textXs.regular.fontWeight,
    );
    expect(responseText.style?.color, DlColorsLight.black);

    final authorTopLeft = tester.getTopLeft(
      find.byKey(const Key('dl_message_author')),
    );
    final responseTopLeft = tester.getTopLeft(
      find.byKey(const Key('dl_message_response_box')),
    );
    final messageTopLeft = tester.getTopLeft(
      find.byKey(const Key('dl_message_text')),
    );
    expect(authorTopLeft.dy <= responseTopLeft.dy, isTrue);
    expect(responseTopLeft.dy <= messageTopLeft.dy, isTrue);

    final p4Gaps = find.descendant(
      of: find.byKey(const Key('dl_message_container')),
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == DlSpacingTokens.p_4,
      ),
    );
    expect(p4Gaps, findsNWidgets(2));
  });

  testWidgets('response state for ownMessage shows grey700 box above message', (
    tester,
  ) async {
    await pumpMessage(
      tester,
      child: const DlMessage(
        type: DlMessageType.ownMessage,
        state: DlMessageState.response,
        responseTitle: 'Response Author',
        responseMessage: 'Response message',
        message: 'Own main message',
      ),
    );

    final responseBox = tester.widget<Container>(
      find.byKey(const Key('dl_message_response_box')),
    );
    final responseDecoration = responseBox.decoration as BoxDecoration;
    final responseTitle = tester.widget<Text>(
      find.byKey(const Key('dl_message_response_title')),
    );
    final responseText = tester.widget<Text>(
      find.byKey(const Key('dl_message_response_text')),
    );

    expect(responseDecoration.color, DlColorsLight.grey700);
    expect(responseTitle.style?.color, DlColorsLight.white);
    expect(responseText.style?.color, DlColorsLight.white);

    final responseTopLeft = tester.getTopLeft(
      find.byKey(const Key('dl_message_response_box')),
    );
    final messageTopLeft = tester.getTopLeft(
      find.byKey(const Key('dl_message_text')),
    );
    expect(responseTopLeft.dy <= messageTopLeft.dy, isTrue);

    final p4Gaps = find.descendant(
      of: find.byKey(const Key('dl_message_container')),
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == DlSpacingTokens.p_4,
      ),
    );
    expect(p4Gaps, findsOneWidget);
  });
}
