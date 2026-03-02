import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpBottomNavigation(
    WidgetTester tester, {
    required DlBottomNavigation bottomNavigation,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: bottomNavigation),
      ),
    );
  }

  DlBottomNavigation buildBottomNavigation({
    ValueChanged<int>? onTabChanged,
    bool showSeparator = true,
  }) {
    return DlBottomNavigation(
      tabs: const [
        DlBottomNavigationTab(text: 'Home'),
        DlBottomNavigationTab(text: 'Search'),
        DlBottomNavigationTab(text: 'Profile'),
      ],
      onTabChanged: onTabChanged,
      showSeparator: showSeparator,
    );
  }

  testWidgets('shows optional top separator and tabs container', (
    tester,
  ) async {
    await pumpBottomNavigation(
      tester,
      bottomNavigation: buildBottomNavigation(),
    );
    expect(
      find.byKey(const Key('dl_bottom_navigation_separator')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('dl_bottom_navigation_tabs_container')),
      findsOneWidget,
    );

    await pumpBottomNavigation(
      tester,
      bottomNavigation: buildBottomNavigation(showSeparator: false),
    );
    expect(
      find.byKey(const Key('dl_bottom_navigation_separator')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('dl_bottom_navigation_tabs_container')),
      findsOneWidget,
    );
  });

  testWidgets('renders tabs with height 64 and icon box 24x24', (tester) async {
    await pumpBottomNavigation(
      tester,
      bottomNavigation: buildBottomNavigation(),
    );

    expect(
      tester
          .getSize(find.byKey(const Key('dl_bottom_navigation_tab_0')))
          .height,
      64,
    );
    expect(
      tester.getSize(
        find.byKey(const Key('dl_bottom_navigation_tab_icon_box_0')),
      ),
      const Size(24, 24),
    );
  });

  testWidgets('tab uses vertical p8 and horizontal p0 with internal p8 gap', (
    tester,
  ) async {
    await pumpBottomNavigation(
      tester,
      bottomNavigation: buildBottomNavigation(),
    );

    final tab = tester.widget<Container>(
      find.byKey(const Key('dl_bottom_navigation_tab_0')),
    );
    expect(
      tab.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_0,
        vertical: DlSpacingTokens.p_8,
      ),
    );

    final gapFinder = find.descendant(
      of: find.byKey(const Key('dl_bottom_navigation_tab_0')),
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == DlSpacingTokens.p_8,
      ),
    );
    expect(gapFinder, findsOneWidget);
  });

  testWidgets('first tab is active, others default', (tester) async {
    await pumpBottomNavigation(
      tester,
      bottomNavigation: buildBottomNavigation(),
    );

    final text0 = tester.widget<Text>(
      find.byKey(const Key('dl_bottom_navigation_tab_text_0')),
    );
    final text1 = tester.widget<Text>(
      find.byKey(const Key('dl_bottom_navigation_tab_text_1')),
    );
    expect(text0.maxLines, 1);
    expect(text0.overflow, TextOverflow.ellipsis);
    expect(text0.style?.color, DlColorsLight.black);
    expect(text1.style?.color, DlColorsLight.grey400);

    final iconTheme0 = tester.widget<IconTheme>(
      find.descendant(
        of: find.byKey(const Key('dl_bottom_navigation_tab_icon_box_0')),
        matching: find.byType(IconTheme),
      ),
    );
    final iconTheme1 = tester.widget<IconTheme>(
      find.descendant(
        of: find.byKey(const Key('dl_bottom_navigation_tab_icon_box_1')),
        matching: find.byType(IconTheme),
      ),
    );
    expect(iconTheme0.data.color, DlColorsLight.black);
    expect(iconTheme1.data.color, DlColorsLight.grey400);
  });

  testWidgets('tap changes active tab and triggers callback', (tester) async {
    var selected = -1;
    await pumpBottomNavigation(
      tester,
      bottomNavigation: buildBottomNavigation(
        onTabChanged: (index) => selected = index,
      ),
    );

    await tester.tap(find.byKey(const Key('dl_bottom_navigation_tab_tap_2')));
    await tester.pump();

    final text0 = tester.widget<Text>(
      find.byKey(const Key('dl_bottom_navigation_tab_text_0')),
    );
    final text2 = tester.widget<Text>(
      find.byKey(const Key('dl_bottom_navigation_tab_text_2')),
    );
    expect(text0.style?.color, DlColorsLight.grey400);
    expect(text2.style?.color, DlColorsLight.black);
    expect(selected, 2);
  });

  testWidgets('supports optional badge and optional text', (tester) async {
    await pumpBottomNavigation(
      tester,
      bottomNavigation: DlBottomNavigation(
        tabs: const [
          DlBottomNavigationTab(
            badge: DlBadge(size: DlBadgeSize.sm),
            text: 'Inbox',
          ),
          DlBottomNavigationTab(),
        ],
      ),
    );

    expect(find.byType(DlBadge), findsOneWidget);
    expect(
      find.byKey(const Key('dl_bottom_navigation_tab_text_0')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('dl_bottom_navigation_tab_text_1')),
      findsNothing,
    );
  });

  testWidgets('md badge uses right +8 and top +4 offset', (tester) async {
    await pumpBottomNavigation(
      tester,
      bottomNavigation: DlBottomNavigation(
        tabs: const [
          DlBottomNavigationTab(
            text: 'Inbox',
            badge: DlBadge(size: DlBadgeSize.md, value: '8'),
          ),
        ],
      ),
    );

    final badgePositioned = tester.widget<Positioned>(
      find.byKey(const Key('dl_bottom_navigation_tab_badge_position_0')),
    );
    expect(badgePositioned.top, -4);
    expect(badgePositioned.right, -8);
  });

  testWidgets('supports controlled selectedIndex from parent', (tester) async {
    await pumpBottomNavigation(
      tester,
      bottomNavigation: DlBottomNavigation(
        selectedIndex: 2,
        tabs: const [
          DlBottomNavigationTab(text: 'Home'),
          DlBottomNavigationTab(text: 'Search'),
          DlBottomNavigationTab(text: 'Profile'),
        ],
      ),
    );

    final text0 = tester.widget<Text>(
      find.byKey(const Key('dl_bottom_navigation_tab_text_0')),
    );
    final text2 = tester.widget<Text>(
      find.byKey(const Key('dl_bottom_navigation_tab_text_2')),
    );
    expect(text0.style?.color, DlColorsLight.grey400);
    expect(text2.style?.color, DlColorsLight.black);
  });

  testWidgets(
    'controlled mode emits callback and updates when parent changes selectedIndex',
    (tester) async {
      var selectedIndex = 0;
      await tester.pumpWidget(
        MaterialApp(
          theme: DlTheme.light(),
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: DlBottomNavigation(
                  selectedIndex: selectedIndex,
                  tabs: const [
                    DlBottomNavigationTab(text: 'Home'),
                    DlBottomNavigationTab(text: 'Search'),
                    DlBottomNavigationTab(text: 'Profile'),
                  ],
                  onTabChanged: (index) =>
                      setState(() => selectedIndex = index),
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('dl_bottom_navigation_tab_tap_2')));
      await tester.pump();

      final text2 = tester.widget<Text>(
        find.byKey(const Key('dl_bottom_navigation_tab_text_2')),
      );
      expect(text2.style?.color, DlColorsLight.black);
    },
  );
}
