import 'package:dynamic_layer_core/dynamic_layer_core.dart';
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
}
