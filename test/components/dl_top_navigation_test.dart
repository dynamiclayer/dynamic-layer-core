import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpTopNavigation(
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

  testWidgets('renders white container with left and right 56x56 icon boxes', (
    tester,
  ) async {
    await pumpTopNavigation(
      tester,
      child: const DlTopNavigation(title: 'Title'),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_top_navigation')),
    );
    expect(container.color, DlColorsLight.white);

    final leftSize = tester.getSize(
      find.byKey(const Key('dl_top_navigation_left_icon_box')),
    );
    final rightSize = tester.getSize(
      find.byKey(const Key('dl_top_navigation_right_icon_box')),
    );
    expect(leftSize, const Size(56, 56));
    expect(rightSize, const Size(56, 56));
    expect(find.byKey(const ValueKey('dl_top_navigation_icon_empty')), findsNWidgets(2));
  });

  testWidgets('renders centered title with textBase semiBold black and ellipsis', (
    tester,
  ) async {
    await pumpTopNavigation(
      tester,
      child: const DlTopNavigation(title: 'Very long very long very long title'),
    );

    final title = tester.widget<Text>(find.byKey(const Key('dl_top_navigation_title')));
    expect(title.textAlign, TextAlign.center);
    expect(title.maxLines, 1);
    expect(title.overflow, TextOverflow.ellipsis);
    expect(title.style?.fontSize, DlTextStyles.textBase.semiBold.fontSize);
    expect(title.style?.fontWeight, DlTextStyles.textBase.semiBold.fontWeight);
    expect(title.style?.color, DlColorsLight.black);
  });

  testWidgets('shows separator by default and can hide it via bool', (tester) async {
    await pumpTopNavigation(
      tester,
      child: const DlTopNavigation(title: 'Title'),
    );
    expect(find.byKey(const Key('dl_top_navigation_separator')), findsOneWidget);

    await pumpTopNavigation(
      tester,
      child: const DlTopNavigation(
        title: 'Title',
        showSeparator: false,
      ),
    );
    expect(find.byKey(const Key('dl_top_navigation_separator')), findsNothing);
  });

  testWidgets('lg has no white background and uses p16 vertical wrapper', (
    tester,
  ) async {
    await pumpTopNavigation(
      tester,
      child: const DlTopNavigation(
        title: 'Title',
        size: DlTopNavigationSize.lg,
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_top_navigation')),
    );
    expect(container.color, isNull);

    final padding = tester.widget<Padding>(
      find.byKey(const Key('dl_top_navigation_lg_padding')),
    );
    expect(
      padding.padding,
      const EdgeInsets.symmetric(vertical: DlSpacingTokens.p_16),
    );
  });

  testWidgets('lg uses text4Xl bold and keeps right icon boxes adjacent', (
    tester,
  ) async {
    await pumpTopNavigation(
      tester,
      child: const DlTopNavigation(
        title: 'Title',
        size: DlTopNavigationSize.lg,
      ),
    );

    final title = tester.widget<Text>(find.byKey(const Key('dl_top_navigation_title')));
    expect(title.style?.fontSize, DlTextStyles.text4Xl.bold.fontSize);
    expect(title.style?.fontWeight, DlTextStyles.text4Xl.bold.fontWeight);

    final leftBoxX = tester.getTopLeft(find.byKey(const Key('dl_top_navigation_left_icon_box'))).dx;
    final rightBoxX =
        tester.getTopLeft(find.byKey(const Key('dl_top_navigation_right_icon_box'))).dx;
    final leftBoxWidth =
        tester.getSize(find.byKey(const Key('dl_top_navigation_left_icon_box'))).width;
    final titleX = tester.getTopLeft(find.byKey(const Key('dl_top_navigation_title'))).dx;
    expect(leftBoxX, greaterThan(titleX));
    expect(rightBoxX, greaterThan(leftBoxX));
    expect(rightBoxX, leftBoxX + leftBoxWidth);
  });

  testWidgets('supports optional DlButtonIcon icons with onPressed', (
    tester,
  ) async {
    var leftTapped = false;
    var rightTapped = false;

    await pumpTopNavigation(
      tester,
      child: DlTopNavigation(
        title: 'Title',
        iconLeft: DlButtonIcon(
          icon: const DlPlaceholderIcon(),
          type: DlButtonType.ghost,
          size: DlButtonSize.sm,
          onPressed: () => leftTapped = true,
        ),
        iconRight: DlButtonIcon(
          icon: const DlPlaceholderIcon(),
          type: DlButtonType.ghost,
          size: DlButtonSize.sm,
          onPressed: () => rightTapped = true,
        ),
      ),
    );

    expect(find.byType(DlButtonIcon), findsNWidgets(2));

    await tester.tap(find.byType(DlButtonIcon).first);
    await tester.pump();
    await tester.tap(find.byType(DlButtonIcon).last);
    await tester.pump();

    expect(leftTapped, isTrue);
    expect(rightTapped, isTrue);
  });
}
