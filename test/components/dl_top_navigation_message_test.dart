import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpTopNavigationMessage(
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

  testWidgets('renders md-style layout with left/right 56x56 icon boxes', (
    tester,
  ) async {
    await pumpTopNavigationMessage(
      tester,
      child: const DlTopNavigationMessage(title: 'Messages'),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_top_navigation_message')),
    );
    expect(container.color, DlColorsLight.white);

    final leftSize = tester.getSize(
      find.byKey(const Key('dl_top_navigation_message_left_icon_box')),
    );
    final rightSize = tester.getSize(
      find.byKey(const Key('dl_top_navigation_message_right_icon_box')),
    );
    expect(leftSize, const Size(56, 56));
    expect(rightSize, const Size(56, 56));
  });

  testWidgets('renders left-aligned avatar + title with p16 gap', (tester) async {
    await pumpTopNavigationMessage(
      tester,
      child: const DlTopNavigationMessage(title: 'Message title'),
    );

    final title = tester.widget<Text>(
      find.byKey(const Key('dl_top_navigation_message_title')),
    );
    expect(title.textAlign, TextAlign.left);
    expect(title.maxLines, 1);
    expect(title.overflow, TextOverflow.ellipsis);
    expect(title.style?.fontSize, DlTextStyles.textBase.semiBold.fontSize);
    expect(title.style?.fontWeight, DlTextStyles.textBase.semiBold.fontWeight);
    expect(title.style?.color, DlColorsLight.black);

    final avatarX = tester.getTopLeft(
      find.byKey(const Key('dl_top_navigation_message_avatar')),
    ).dx;
    final titleX = tester.getTopLeft(
      find.byKey(const Key('dl_top_navigation_message_title')),
    ).dx;
    expect(titleX, greaterThan(avatarX));
  });

  testWidgets('supports custom avatar and clickable icon boxes', (tester) async {
    var leftTap = false;
    var rightTap = false;

    await pumpTopNavigationMessage(
      tester,
      child: DlTopNavigationMessage(
        title: 'Messages',
        avatar: const DlAvatar(type: DlAvatarType.initials, initials: 'DL'),
        iconLeft: const DlPlaceholderIcon(),
        iconRight: const DlPlaceholderIcon(),
        onIconLeftTap: () => leftTap = true,
        onIconRightTap: () => rightTap = true,
      ),
    );

    expect(find.byType(DlAvatar), findsOneWidget);
    expect(find.byKey(const Key('dl_top_navigation_message_left_icon')), findsOneWidget);
    expect(find.byKey(const Key('dl_top_navigation_message_right_icon')), findsOneWidget);

    await tester.tap(find.byKey(const Key('dl_top_navigation_message_left_icon_tap')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('dl_top_navigation_message_right_icon_tap')));
    await tester.pump();
    expect(leftTap, isTrue);
    expect(rightTap, isTrue);
  });

  testWidgets('shows separator by default and can hide it', (tester) async {
    await pumpTopNavigationMessage(
      tester,
      child: const DlTopNavigationMessage(title: 'Messages'),
    );
    expect(find.byKey(const Key('dl_top_navigation_message_separator')), findsOneWidget);

    await pumpTopNavigationMessage(
      tester,
      child: const DlTopNavigationMessage(
        title: 'Messages',
        showSeparator: false,
      ),
    );
    expect(find.byKey(const Key('dl_top_navigation_message_separator')), findsNothing);
  });
}
