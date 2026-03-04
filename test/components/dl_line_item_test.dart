import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpLineItem(
    WidgetTester tester, {
    required DlLineItem child,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(
          body: Center(child: SizedBox(width: 360, child: child)),
        ),
      ),
    );
  }

  testWidgets(
    'default type shows title/description with p12 vertical padding',
    (tester) async {
      await pumpLineItem(
        tester,
        child: const DlLineItem(
          title: 'Line item title',
          description: 'Line item description',
        ),
      );

      final padding = tester.widget<Padding>(
        find.byKey(const Key('dl_line_item_content_padding')),
      );
      expect(
        padding.padding,
        const EdgeInsets.symmetric(vertical: DlSpacingTokens.p_12),
      );

      final title = tester.widget<Text>(
        find.byKey(const Key('dl_line_item_title')),
      );
      final description = tester.widget<Text>(
        find.byKey(const Key('dl_line_item_description')),
      );
      expect(
        title.style?.fontWeight,
        DlTextStyles.textBase.semiBold.fontWeight,
      );
      expect(title.style?.color, DlColorsLight.black);
      expect(
        description.style?.fontWeight,
        DlTextStyles.textBase.regular.fontWeight,
      );
      expect(description.style?.color, DlColorsLight.black);

      final gapFinder = find.descendant(
        of: find.byKey(const Key('dl_line_item_text_box')),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is SizedBox && widget.height == DlSpacingTokens.p_8,
        ),
      );
      expect(gapFinder, findsOneWidget);
    },
  );

  testWidgets('description is optional', (tester) async {
    await pumpLineItem(tester, child: const DlLineItem(title: 'Title only'));

    expect(find.byKey(const Key('dl_line_item_title')), findsOneWidget);
    expect(find.byKey(const Key('dl_line_item_description')), findsNothing);
  });

  testWidgets('switch type renders switch next to text content', (
    tester,
  ) async {
    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Switch title',
        description: 'Switch description',
        type: DlLineItemType.switchType,
      ),
    );

    expect(find.byKey(const Key('dl_line_item_switch')), findsOneWidget);
    expect(find.byType(DlSwitch), findsOneWidget);
  });

  testWidgets('button type renders xs secondary button on the right', (
    tester,
  ) async {
    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Button item',
        type: DlLineItemType.button,
        buttonLabel: 'Action',
      ),
    );

    final button = tester.widget<DlButton>(
      find.byKey(const Key('dl_line_item_button')),
    );
    expect(button.type, DlButtonType.secondary);
    expect(button.size, DlButtonSize.xs);
    expect(button.label, 'Action');
  });

  testWidgets('checkbox type renders checkbox on the right', (tester) async {
    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Checkbox item',
        type: DlLineItemType.checkbox,
      ),
    );

    expect(find.byKey(const Key('dl_line_item_checkbox')), findsOneWidget);
    expect(find.byType(DlCheckbox), findsOneWidget);
  });

  testWidgets('checkbox toggles when tapping complete line item', (tester) async {
    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Checkbox item',
        type: DlLineItemType.checkbox,
      ),
    );

    BoxDecoration checkboxInnerDecoration() =>
        tester.widget<Container>(find.byKey(const Key('dl_checkbox_inner'))).decoration
            as BoxDecoration;

    expect(checkboxInnerDecoration().color, DlColorsLight.white);
    await tester.tap(find.byKey(const Key('dl_line_item_tap_area')));
    await tester.pump();
    expect(checkboxInnerDecoration().color, DlColorsLight.black);
  });

  testWidgets('radioButton type renders radio button on the right', (
    tester,
  ) async {
    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Radio item',
        type: DlLineItemType.radioButton,
      ),
    );

    expect(find.byKey(const Key('dl_line_item_radio_button')), findsOneWidget);
    expect(find.byType(DlRadioButton), findsOneWidget);
  });

  testWidgets('radio button toggles when tapping complete line item', (
    tester,
  ) async {
    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Radio item',
        type: DlLineItemType.radioButton,
      ),
    );

    expect(find.byKey(const Key('dl_radio_button_active_dot')), findsNothing);
    await tester.tap(find.byKey(const Key('dl_line_item_tap_area')));
    await tester.pump();
    expect(find.byKey(const Key('dl_radio_button_active_dot')), findsOneWidget);
  });

  testWidgets('chevron type renders placeholder icon on the right', (
    tester,
  ) async {
    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Chevron item',
        type: DlLineItemType.chevron,
      ),
    );

    expect(find.byKey(const Key('dl_line_item_chevron')), findsOneWidget);
    expect(find.byType(DlPlaceholderIcon), findsOneWidget);
  });

  testWidgets('chevron triggers onItemTap when tapping complete line item', (
    tester,
  ) async {
    var tapped = false;
    await pumpLineItem(
      tester,
      child: DlLineItem(
        title: 'Chevron item',
        type: DlLineItemType.chevron,
        onItemTap: () => tapped = true,
      ),
    );

    await tester.tap(find.byKey(const Key('dl_line_item_tap_area')));
    await tester.pump();
    expect(tapped, isTrue);
  });

  testWidgets('disabled state uses grey500 texts and regular title style', (
    tester,
  ) async {
    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Disabled title',
        description: 'Disabled description',
        state: DlLineItemState.disabled,
      ),
    );

    final title = tester.widget<Text>(find.byKey(const Key('dl_line_item_title')));
    final description = tester.widget<Text>(
      find.byKey(const Key('dl_line_item_description')),
    );

    expect(title.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(title.style?.color, DlColorsLight.grey500);
    expect(description.style?.fontWeight, DlTextStyles.textBase.regular.fontWeight);
    expect(description.style?.color, DlColorsLight.grey500);
  });

  testWidgets('disabled checkbox and radio do not toggle on full-row tap', (
    tester,
  ) async {
    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Disabled checkbox',
        type: DlLineItemType.checkbox,
        state: DlLineItemState.disabled,
      ),
    );

    BoxDecoration checkboxInnerDecoration() =>
        tester.widget<Container>(find.byKey(const Key('dl_checkbox_inner'))).decoration
            as BoxDecoration;
    expect(checkboxInnerDecoration().color, DlColorsLight.grey50);
    await tester.tap(find.byKey(const Key('dl_line_item_tap_area')));
    await tester.pump();
    expect(checkboxInnerDecoration().color, DlColorsLight.grey50);

    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Disabled radio',
        type: DlLineItemType.radioButton,
        state: DlLineItemState.disabled,
      ),
    );
    expect(find.byKey(const Key('dl_radio_button_active_dot')), findsNothing);
    await tester.tap(find.byKey(const Key('dl_line_item_tap_area')));
    await tester.pump();
    expect(find.byKey(const Key('dl_radio_button_active_dot')), findsNothing);
  });

  testWidgets('disabled button and chevron use disabled visuals', (tester) async {
    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Disabled button',
        type: DlLineItemType.button,
        state: DlLineItemState.disabled,
        buttonLabel: 'Action',
      ),
    );

    final button = tester.widget<DlButton>(find.byKey(const Key('dl_line_item_button')));
    expect(button.state, DlButtonState.disabled);

    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Disabled chevron',
        type: DlLineItemType.chevron,
        state: DlLineItemState.disabled,
      ),
    );
    final chevronTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_line_item_chevron_theme')),
    );
    expect(chevronTheme.data.color, DlColorsLight.grey400);
  });

  testWidgets('disabled switch is not interactive', (tester) async {
    await pumpLineItem(
      tester,
      child: const DlLineItem(
        title: 'Disabled switch',
        type: DlLineItemType.switchType,
        state: DlLineItemState.disabled,
      ),
    );

    final trackFinder = find.descendant(
      of: find.byKey(const Key('dl_line_item_switch')),
      matching: find.byKey(const Key('dl_switch_track')),
    );
    BoxDecoration trackDecoration() =>
        tester.widget<AnimatedContainer>(trackFinder).decoration as BoxDecoration;

    expect(trackDecoration().color, DlColorsLight.grey200);
    await tester.tap(find.byKey(const Key('dl_line_item_tap_area')));
    await tester.pump();
    expect(trackDecoration().color, DlColorsLight.grey200);
  });

  testWidgets('separator is optional and spans full width', (tester) async {
    await pumpLineItem(
      tester,
      child: const DlLineItem(title: 'With separator', showSeparator: true),
    );
    expect(find.byKey(const Key('dl_line_item_separator')), findsOneWidget);

    await pumpLineItem(
      tester,
      child: const DlLineItem(title: 'Without separator', showSeparator: false),
    );
    expect(find.byKey(const Key('dl_line_item_separator')), findsNothing);
  });
}
