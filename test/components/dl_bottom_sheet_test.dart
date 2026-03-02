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
    VoidCallback? onHeaderIconPressed,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Widget? contentMedia,
  }) {
    return DlBottomSheet(
      headerTitle: 'Bottom Sheet Title',
      contentTitle: 'Content title',
      contentDescription: 'Content description',
      primaryButtonLabel: 'Primary',
      secondaryButtonLabel: 'Secondary',
      onHeaderIconPressed: onHeaderIconPressed,
      onPrimaryPressed: onPrimaryPressed,
      onSecondaryPressed: onSecondaryPressed,
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
    expect(find.byType(DlPlaceholderIcon), findsOneWidget);
  });

  testWidgets('right header box is clickable', (tester) async {
    var tapped = false;
    await pumpBottomSheet(
      tester,
      bottomSheet: buildSheet(onHeaderIconPressed: () => tapped = true),
    );

    await tester.tap(find.byKey(const Key('dl_bottom_sheet_header_right_tap')));
    await tester.pump();

    expect(tapped, isTrue);
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

    final sheetWidth = tester.getSize(find.byKey(const Key('dl_bottom_sheet'))).width;
    final mediaSize = tester.getSize(find.byKey(const Key('dl_bottom_sheet_media')));
    expect(mediaSize.height, 12);
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
    expect(title.style?.fontSize, DlTextStyles.textXl.semiBold.fontSize);
    expect(title.style?.color, DlColorsLight.black);
    expect(description.style?.fontSize, DlTextStyles.textBase.regular.fontSize);
    expect(description.style?.color, DlColorsLight.grey500);
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

  testWidgets('button wrapper has two vertical buttons with p16 gap', (
    tester,
  ) async {
    await pumpBottomSheet(tester, bottomSheet: buildSheet());

    final wrapper = tester.widget<Container>(
      find.byKey(const Key('dl_bottom_sheet_button_wrapper')),
    );
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
      find.byKey(const Key('dl_bottom_sheet_primary_button')),
    );
    final secondary = tester.widget<DlButton>(
      find.byKey(const Key('dl_bottom_sheet_secondary_button')),
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
        onPrimaryPressed: () => primaryTapped = true,
        onSecondaryPressed: () => secondaryTapped = true,
      ),
    );

    await tester.tap(find.byKey(const Key('dl_bottom_sheet_primary_button')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('dl_bottom_sheet_secondary_button')));
    await tester.pump();

    expect(primaryTapped, isTrue);
    expect(secondaryTapped, isTrue);
  });
}
