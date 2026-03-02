import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpBottomSheet(
    WidgetTester tester, {
    required DlBottomSheet bottomSheet,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: bottomSheet),
      ),
    );
  }

  DlBottomSheet buildSheet({
    Widget? contentMedia,
    String? contentTitle = 'Content title',
    String? contentDescription = 'Content description',
    List<DlButton> buttons = const [],
  }) {
    return DlBottomSheet(
      headerTitle: 'Bottom Sheet Title',
      contentTitle: contentTitle,
      contentDescription: contentDescription,
      buttons: buttons,
      contentMedia: contentMedia,
    );
  }

  testWidgets('uses top rounded3Xl container shape', (tester) async {
    await pumpBottomSheet(tester, bottomSheet: buildSheet());

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_bottom_sheet')),
    );
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius! as BorderRadius;

    expect(radius.topLeft.x, DlRadiusTokens.rounded3Xl);
    expect(radius.topRight.x, DlRadiusTokens.rounded3Xl);
  });

  testWidgets('header has centered title, side 56x56 boxes and right icon', (
    tester,
  ) async {
    await pumpBottomSheet(tester, bottomSheet: buildSheet());

    expect(
      tester.getSize(find.byKey(const Key('dl_bottom_sheet_header_left_box'))),
      const Size(56, 56),
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_bottom_sheet_header_right_box'))),
      const Size(56, 56),
    );

    final headerTitle = tester.widget<Text>(
      find.byKey(const Key('dl_bottom_sheet_header_title')),
    );
    expect(headerTitle.textAlign, TextAlign.center);
    expect(headerTitle.maxLines, 1);
    expect(headerTitle.overflow, TextOverflow.ellipsis);
    expect(
      headerTitle.style?.fontSize,
      DlTextStyles.textBase.semiBold.fontSize,
    );
    final rightIcon = tester.widget<DlAssetIcon>(find.byType(DlAssetIcon));
    expect(rightIcon.assetPath, DlIcons.xAsset);
  });

  testWidgets('right header box is tappable', (tester) async {
    await pumpBottomSheet(tester, bottomSheet: buildSheet());
    await tester.tap(find.byKey(const Key('dl_bottom_sheet_header_right_tap')));
    await tester.pump();
    expect(find.byKey(const Key('dl_bottom_sheet')), findsOneWidget);
  });

  testWidgets('content uses required paddings and text styles', (tester) async {
    await pumpBottomSheet(tester, bottomSheet: buildSheet());

    final content = tester.widget<Container>(
      find.byKey(const Key('dl_bottom_sheet_content')),
    );
    expect(
      content.padding,
      const EdgeInsets.only(
        top: DlSpacingTokens.p_32,
        left: DlSpacingTokens.p_16,
        right: DlSpacingTokens.p_16,
      ),
    );

    final sheetWidth = tester
        .getSize(find.byKey(const Key('dl_bottom_sheet')))
        .width;
    final mediaSize = tester.getSize(
      find.byKey(const Key('dl_bottom_sheet_media')),
    );
    expect(mediaSize.height, 120);
    expect(mediaSize.width, sheetWidth - (DlSpacingTokens.p_16 * 2));

    final textBox = tester.widget<Padding>(
      find.byKey(const Key('dl_bottom_sheet_text_box')),
    );
    expect(
      textBox.padding,
      const EdgeInsets.symmetric(
        vertical: DlSpacingTokens.p_32,
        horizontal: DlSpacingTokens.p_16,
      ),
    );

    final title = tester.widget<Text>(
      find.byKey(const Key('dl_bottom_sheet_content_title')),
    );
    final description = tester.widget<Text>(
      find.byKey(const Key('dl_bottom_sheet_content_description')),
    );
    expect(title.textAlign, TextAlign.center);
    expect(description.textAlign, TextAlign.center);
    expect(title.maxLines, isNull);
    expect(description.maxLines, isNull);
    expect(title.style?.fontSize, DlTextStyles.textXl.semiBold.fontSize);
    expect(title.style?.color, DlColorsLight.black);
    expect(description.style?.fontSize, DlTextStyles.textBase.regular.fontSize);
    expect(description.style?.color, DlColorsLight.grey500);

    final textGapFinder = find.descendant(
      of: find.byKey(const Key('dl_bottom_sheet_text_box')),
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == DlSpacingTokens.p_8,
      ),
    );
    expect(textGapFinder, findsOneWidget);
  });

  testWidgets('supports custom content media widget', (tester) async {
    await pumpBottomSheet(
      tester,
      bottomSheet: buildSheet(
        contentMedia: const ColoredBox(
          key: Key('custom_media'),
          color: Colors.red,
        ),
      ),
    );

    expect(find.byKey(const Key('custom_media')), findsOneWidget);
  });

  testWidgets('button wrapper has vertical buttons with p16 gap', (
    tester,
  ) async {
    await pumpBottomSheet(
      tester,
      bottomSheet: buildSheet(
        buttons: const [
          DlButton(
            key: Key('dl_bottom_sheet_button_0'),
            label: 'Primary',
            type: DlButtonType.primary,
            fullWidth: true,
            onPressed: _noop,
          ),
          DlButton(
            key: Key('dl_bottom_sheet_button_1'),
            label: 'Secondary',
            type: DlButtonType.secondary,
            fullWidth: true,
            onPressed: _noop,
          ),
        ],
      ),
    );

    final wrapper = tester.widget<Container>(
      find.byKey(const Key('dl_bottom_sheet_button_wrapper')),
    );
    expect(wrapper.color, isNull);
    expect(
      wrapper.padding,
      const EdgeInsets.only(
        left: DlSpacingTokens.p_16,
        right: DlSpacingTokens.p_16,
        top: DlSpacingTokens.p_0,
        bottom: DlSpacingTokens.p_16,
      ),
    );

    final primary = tester.widget<DlButton>(
      find.byKey(const Key('dl_bottom_sheet_button_0')),
    );
    final secondary = tester.widget<DlButton>(
      find.byKey(const Key('dl_bottom_sheet_button_1')),
    );
    expect(primary.type, DlButtonType.primary);
    expect(secondary.type, DlButtonType.secondary);
    expect(primary.fullWidth, isTrue);
    expect(secondary.fullWidth, isTrue);

    final gapFinder = find.descendant(
      of: find.byKey(const Key('dl_bottom_sheet_button_wrapper')),
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == DlSpacingTokens.p_16,
      ),
    );
    expect(gapFinder, findsOneWidget);
  });

  testWidgets('primary and secondary buttons are clickable', (tester) async {
    var primaryTapped = false;
    var secondaryTapped = false;
    await pumpBottomSheet(
      tester,
      bottomSheet: buildSheet(
        buttons: [
          DlButton(
            key: const Key('dl_bottom_sheet_button_0'),
            label: 'Primary',
            type: DlButtonType.primary,
            fullWidth: true,
            onPressed: () => primaryTapped = true,
          ),
          DlButton(
            key: const Key('dl_bottom_sheet_button_1'),
            label: 'Secondary',
            type: DlButtonType.secondary,
            fullWidth: true,
            onPressed: () => secondaryTapped = true,
          ),
        ],
      ),
    );

    await tester.tap(find.byKey(const Key('dl_bottom_sheet_button_0')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('dl_bottom_sheet_button_1')));
    await tester.pump();

    expect(primaryTapped, isTrue);
    expect(secondaryTapped, isTrue);
  });

  testWidgets('no buttons does not render button wrapper', (tester) async {
    await pumpBottomSheet(tester, bottomSheet: buildSheet(buttons: const []));

    expect(
      find.byKey(const Key('dl_bottom_sheet_button_wrapper')),
      findsNothing,
    );
  });

  testWidgets('content title and description are optional', (tester) async {
    await pumpBottomSheet(
      tester,
      bottomSheet: buildSheet(contentTitle: null, contentDescription: null),
    );

    expect(find.byKey(const Key('dl_bottom_sheet_text_box')), findsNothing);
    expect(
      find.byKey(const Key('dl_bottom_sheet_content_title')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('dl_bottom_sheet_content_description')),
      findsNothing,
    );
  });

  testWidgets('supports fully customizable button list', (tester) async {
    await pumpBottomSheet(
      tester,
      bottomSheet: buildSheet(
        buttons: const [
          DlButton(
            key: Key('dl_bottom_sheet_custom_btn_0'),
            label: 'Primary large',
            type: DlButtonType.primary,
            size: DlButtonSize.lg,
            onPressed: _noop,
          ),
          DlButton(
            key: Key('dl_bottom_sheet_custom_btn_1'),
            label: 'Secondary small',
            type: DlButtonType.secondary,
            size: DlButtonSize.sm,
            onPressed: _noop,
          ),
          DlButton(
            key: Key('dl_bottom_sheet_custom_btn_2'),
            label: 'Ghost xs',
            type: DlButtonType.ghost,
            size: DlButtonSize.xs,
            onPressed: _noop,
          ),
        ],
      ),
    );

    final button0 = tester.widget<DlButton>(
      find.byKey(const Key('dl_bottom_sheet_custom_btn_0')),
    );
    final button1 = tester.widget<DlButton>(
      find.byKey(const Key('dl_bottom_sheet_custom_btn_1')),
    );
    final button2 = tester.widget<DlButton>(
      find.byKey(const Key('dl_bottom_sheet_custom_btn_2')),
    );
    expect(button0.type, DlButtonType.primary);
    expect(button0.size, DlButtonSize.lg);
    expect(button1.type, DlButtonType.secondary);
    expect(button1.size, DlButtonSize.sm);
    expect(button2.type, DlButtonType.ghost);
    expect(button2.size, DlButtonSize.xs);
  });
}

void _noop() {}
