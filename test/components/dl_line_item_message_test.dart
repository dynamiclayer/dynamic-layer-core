import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpLineItemMessage(
    WidgetTester tester, {
    required DlLineItemMessage child,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 360,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('uses required spacing and base layout', (tester) async {
    await pumpLineItemMessage(
      tester,
      child: const DlLineItemMessage(
        title: 'Emma Johnson',
        time: '17:32',
        message: 'See you at the station.',
      ),
    );

    final padding = tester.widget<Padding>(
      find.byKey(const Key('dl_line_item_message_padding')),
    );
    expect(
      padding.padding,
      const EdgeInsets.symmetric(vertical: DlSpacingTokens.p_16),
    );

    final avatarRight = tester.getTopRight(find.byKey(const Key('dl_line_item_message_avatar')));
    final textLeft = tester.getTopLeft(find.byKey(const Key('dl_line_item_message_text_box')));
    expect(textLeft.dx - avatarRight.dx, DlSpacingTokens.p_16);

    final gapFinder = find.descendant(
      of: find.byKey(const Key('dl_line_item_message_text_box')),
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == DlSpacingTokens.p_4,
      ),
    );
    expect(gapFinder, findsOneWidget);
  });

  testWidgets('default state text styles are correct', (tester) async {
    await pumpLineItemMessage(
      tester,
      child: const DlLineItemMessage(
        title: 'A very very long title that should ellipsize in one line',
        time: '17:32',
        message: 'Message preview text.',
      ),
    );

    final title = tester.widget<Text>(find.byKey(const Key('dl_line_item_message_title')));
    expect(title.maxLines, 1);
    expect(title.overflow, TextOverflow.ellipsis);
    expect(title.style?.fontWeight, DlTextStyles.textBase.semiBold.fontWeight);
    expect(title.style?.color, DlColorsLight.black);

    final time = tester.widget<Text>(find.byKey(const Key('dl_line_item_message_time')));
    expect(time.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(time.style?.color, DlColorsLight.grey500);

    final body = tester.widget<Text>(find.byKey(const Key('dl_line_item_message_body')));
    expect(body.maxLines, 2);
    expect(body.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(body.style?.color, DlColorsLight.grey500);
  });

  testWidgets('new state uses black semibold message text', (tester) async {
    await pumpLineItemMessage(
      tester,
      child: const DlLineItemMessage(
        title: 'Emma Johnson',
        time: '17:32',
        message: 'Unread message preview',
        state: DlLineItemMessageState.newState,
      ),
    );

    final body = tester.widget<Text>(find.byKey(const Key('dl_line_item_message_body')));
    expect(body.style?.fontWeight, DlTextStyles.textBase.semiBold.fontWeight);
    expect(body.style?.color, DlColorsLight.black);
    expect(find.byKey(const Key('dl_line_item_message_new_row')), findsOneWidget);
    expect(find.byKey(const Key('dl_line_item_message_badge')), findsOneWidget);

    final rowGapFinder = find.descendant(
      of: find.byKey(const Key('dl_line_item_message_new_row')),
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.width == DlSpacingTokens.p_16,
      ),
    );
    expect(rowGapFinder, findsOneWidget);
  });

  testWidgets('disabled state makes every text base regular grey500', (tester) async {
    await pumpLineItemMessage(
      tester,
      child: const DlLineItemMessage(
        title: 'Emma Johnson',
        time: '17:32',
        message: 'Disabled message preview',
        state: DlLineItemMessageState.disabled,
      ),
    );

    final title = tester.widget<Text>(find.byKey(const Key('dl_line_item_message_title')));
    final time = tester.widget<Text>(find.byKey(const Key('dl_line_item_message_time')));
    final body = tester.widget<Text>(find.byKey(const Key('dl_line_item_message_body')));

    expect(title.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(time.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(body.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);

    expect(title.style?.color, DlColorsLight.grey500);
    expect(time.style?.color, DlColorsLight.grey500);
    expect(body.style?.color, DlColorsLight.grey500);
  });

  testWidgets('supports custom avatar and optional separator', (tester) async {
    await pumpLineItemMessage(
      tester,
      child: const DlLineItemMessage(
        title: 'Emma Johnson',
        time: '17:32',
        message: 'Message preview text.',
        avatar: DlAvatar(type: DlAvatarType.initials, initials: 'DL'),
        showSeparator: false,
      ),
    );

    expect(find.byKey(const Key('dl_avatar_initials')), findsOneWidget);
    expect(find.byKey(const Key('dl_line_item_message_separator')), findsNothing);
  });

  testWidgets('supports custom badge in new state', (tester) async {
    await pumpLineItemMessage(
      tester,
      child: const DlLineItemMessage(
        title: 'Emma Johnson',
        time: '17:32',
        message: 'Unread message preview',
        state: DlLineItemMessageState.newState,
        badge: DlBadge(size: DlBadgeSize.md, value: '9'),
      ),
    );

    expect(find.byKey(const Key('dl_line_item_message_badge')), findsOneWidget);
    expect(find.byKey(const Key('dl_badge_md_text')), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
  });
}
