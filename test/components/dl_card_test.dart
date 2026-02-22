import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpCard(
    WidgetTester tester, {
    required DlCard card,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: card)),
      ),
    );
  }

  testWidgets('renders required icon and title', (tester) async {
    await pumpCard(
      tester,
      card: const DlCard(
        icon: Icon(Icons.star, key: Key('test_icon')),
        title: 'Card title',
      ),
    );

    expect(find.byKey(const Key('test_icon')), findsOneWidget);
    expect(find.byKey(const Key('dl_card_title')), findsOneWidget);
    expect(find.text('Card title'), findsOneWidget);
    expect(find.byKey(const Key('dl_card_description')), findsNothing);
  });

  testWidgets('uses grey100 background, roundedLg and p12 padding', (tester) async {
    await pumpCard(
      tester,
      card: const DlCard(
        icon: Icon(Icons.star),
        title: 'Card title',
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_card_container')),
    );
    final decoration = container.decoration as BoxDecoration;

    expect(decoration.color, DlColorsLight.grey100);
    expect(
      decoration.borderRadius,
      BorderRadius.circular(DlRadiusTokens.roundedLg),
    );
    expect(container.padding, const EdgeInsets.all(DlSpacingTokens.p_12));
  });

  testWidgets('title and description use textSm styles with black color', (
    tester,
  ) async {
    await pumpCard(
      tester,
      card: const DlCard(
        icon: Icon(Icons.star),
        title: 'Card title',
        description: 'Card description',
      ),
    );

    final title = tester.widget<Text>(find.byKey(const Key('dl_card_title')));
    final description = tester.widget<Text>(
      find.byKey(const Key('dl_card_description')),
    );

    expect(title.style?.fontSize, DlTextStyles.textSm.semiBold.fontSize);
    expect(title.style?.fontWeight, DlTextStyles.textSm.semiBold.fontWeight);
    expect(title.style?.color, DlColorsLight.black);
    expect(title.maxLines, 1);
    expect(title.overflow, TextOverflow.ellipsis);

    expect(
      description.style?.fontSize,
      DlTextStyles.textSm.regular.fontSize,
    );
    expect(
      description.style?.fontWeight,
      DlTextStyles.textSm.regular.fontWeight,
    );
    expect(description.style?.color, DlColorsLight.black);
    expect(description.maxLines, 1);
    expect(description.overflow, TextOverflow.ellipsis);
  });

  testWidgets('keeps p12 gap between icon and text container', (tester) async {
    await pumpCard(
      tester,
      card: const DlCard(
        icon: Icon(Icons.star),
        title: 'Card title',
      ),
    );

    final gap = tester.widget<SizedBox>(
      find.byWidgetPredicate(
        (widget) =>
            widget is SizedBox && widget.width == DlSpacingTokens.p_12,
      ),
    );

    expect(gap.width, DlSpacingTokens.p_12);
  });

  testWidgets('lg uses p16 padding and vertical layout with p16 gap', (tester) async {
    await pumpCard(
      tester,
      card: const DlCard(
        icon: Icon(Icons.star),
        title: 'Card title',
        description: 'Card description',
        size: DlCardSize.lg,
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_card_container')),
    );
    expect(container.padding, const EdgeInsets.all(DlSpacingTokens.p_16));

    expect(find.byKey(const Key('dl_card_content_column')), findsOneWidget);
    expect(find.byKey(const Key('dl_card_content_row')), findsNothing);

    final gap = tester.widget<SizedBox>(
      find.byWidgetPredicate(
        (widget) =>
            widget is SizedBox && widget.height == DlSpacingTokens.p_16,
      ),
    );
    expect(gap.height, DlSpacingTokens.p_16);
  });

  testWidgets('uses grey200 while pressed and returns to grey100 on release', (
    tester,
  ) async {
    await pumpCard(
      tester,
      card: const DlCard(
        icon: const Icon(Icons.star),
        title: 'Card title',
      ),
    );

    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(const Key('dl_card_tap_area'))),
    );
    await tester.pump();

    var container = tester.widget<Container>(find.byKey(const Key('dl_card_container')));
    var decoration = container.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.grey200);

    await gesture.up();
    await tester.pump();

    container = tester.widget<Container>(find.byKey(const Key('dl_card_container')));
    decoration = container.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.grey100);
  });

  testWidgets('toggles active border when enableActiveState is true', (
    tester,
  ) async {
    await pumpCard(
      tester,
      card: const DlCard(
        icon: Icon(Icons.star),
        title: 'Card title',
        enableActiveState: true,
      ),
    );

    BoxDecoration decoration() =>
        tester.widget<Container>(find.byKey(const Key('dl_card_container'))).decoration
            as BoxDecoration;

    expect(decoration().border, isNotNull);
    expect((decoration().border as Border).top.width, DlBorderWidthTokens.border2);
    expect((decoration().border as Border).top.color, Colors.transparent);

    await tester.tap(find.byKey(const Key('dl_card_tap_area')));
    await tester.pump();

    expect((decoration().border as Border).top.width, DlBorderWidthTokens.border2);
    expect((decoration().border as Border).top.color, DlColorsLight.black);

    await tester.tap(find.byKey(const Key('dl_card_tap_area')));
    await tester.pump();

    expect((decoration().border as Border).top.width, DlBorderWidthTokens.border2);
    expect((decoration().border as Border).top.color, Colors.transparent);
  });

  testWidgets('disabled state uses grey500 for icon, title and description', (
    tester,
  ) async {
    await pumpCard(
      tester,
      card: const DlCard(
        icon: DlPlaceholderIcon(key: Key('test_icon')),
        title: 'Card title',
        description: 'Card description',
        state: DlCardState.disabled,
      ),
    );

    final title = tester.widget<Text>(find.byKey(const Key('dl_card_title')));
    final description = tester.widget<Text>(
      find.byKey(const Key('dl_card_description')),
    );
    final iconTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_card_icon_theme')),
    );

    expect(title.style?.color, DlColorsLight.grey500);
    expect(description.style?.color, DlColorsLight.grey500);
    expect(iconTheme.data.color, DlColorsLight.grey500);
  });

  testWidgets('disabled state is not clickable', (tester) async {
    await pumpCard(
      tester,
      card: const DlCard(
        icon: const DlPlaceholderIcon(),
        title: 'Card title',
        state: DlCardState.disabled,
        enableActiveState: true,
      ),
    );

    await tester.tap(find.byKey(const Key('dl_card_tap_area')));
    await tester.pump();

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_card_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final border = decoration.border as Border;

    expect(border.top.color, Colors.transparent);
  });
}
