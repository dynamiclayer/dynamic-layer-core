import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpTag(
    WidgetTester tester, {
    required DlTag tag,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: tag)),
      ),
    );
  }

  testWidgets('lg uses grey100 background, rounded, and p8/p2 padding', (
    tester,
  ) async {
    await pumpTag(
      tester,
      tag: const DlTag(label: 'Tag'),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_tag_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;

    expect(decoration.color, DlColorsLight.grey100);
    expect(radius.topLeft.x, DlRadiusTokens.rounded);
    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_8,
        vertical: DlSpacingTokens.p_2,
      ),
    );
  });

  testWidgets('label uses textBase semiBold grey600 for lg light mode', (
    tester,
  ) async {
    await pumpTag(
      tester,
      tag: const DlTag(label: 'Tag label'),
    );

    final text = tester.widget<Text>(find.byKey(const Key('dl_tag_label')));
    expect(text.style?.fontSize, DlTextStyles.textBase.semiBold.fontSize);
    expect(text.style?.fontWeight, DlTextStyles.textBase.semiBold.fontWeight);
    expect(text.style?.color, DlColorsLight.grey600);
  });

  testWidgets('md uses p8/p2 and textSm semiBold', (tester) async {
    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Tag md',
        size: DlTagSize.md,
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_tag_container')),
    );
    final text = tester.widget<Text>(find.byKey(const Key('dl_tag_label')));

    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_8,
        vertical: DlSpacingTokens.p_2,
      ),
    );
    expect(text.style?.fontSize, DlTextStyles.textSm.semiBold.fontSize);
    expect(text.style?.fontWeight, DlTextStyles.textSm.semiBold.fontWeight);
    expect(text.style?.color, DlColorsLight.grey600);
  });

  testWidgets('sm uses p4/p2 and textXs semiBold', (tester) async {
    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Tag sm',
        size: DlTagSize.sm,
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_tag_container')),
    );
    final text = tester.widget<Text>(find.byKey(const Key('dl_tag_label')));

    expect(
      container.padding,
      const EdgeInsets.symmetric(
        horizontal: DlSpacingTokens.p_4,
        vertical: DlSpacingTokens.p_2,
      ),
    );
    expect(text.style?.fontSize, DlTextStyles.textXs.semiBold.fontSize);
    expect(text.style?.fontWeight, DlTextStyles.textXs.semiBold.fontWeight);
    expect(text.style?.color, DlColorsLight.grey600);
  });

  testWidgets('renders optional left and right icons with p2 gap', (tester) async {
    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Tag',
        iconLeft: DlPlaceholderIcon(key: Key('left_icon')),
        iconRight: DlPlaceholderIcon(key: Key('right_icon')),
      ),
    );

    expect(find.byKey(const Key('left_icon')), findsOneWidget);
    expect(find.byKey(const Key('right_icon')), findsOneWidget);

    final leftTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_tag_icon_left_theme')),
    );
    final rightTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_tag_icon_right_theme')),
    );
    expect(leftTheme.data.color, DlColorsLight.grey600);
    expect(rightTheme.data.color, DlColorsLight.grey600);

    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.width == DlSpacingTokens.p_2,
      ),
      findsNWidgets(2),
    );
  });

  testWidgets('md icons are 20x20 and sm icons are 16x16', (tester) async {
    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Tag md',
        size: DlTagSize.md,
        iconLeft: DlPlaceholderIcon(key: Key('md_left_icon')),
      ),
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_tag_icon_left_size_box'))),
      const Size(20, 20),
    );

    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Tag sm',
        size: DlTagSize.sm,
        iconLeft: DlPlaceholderIcon(key: Key('sm_left_icon')),
      ),
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_tag_icon_left_size_box'))),
      const Size(16, 16),
    );
  });

  testWidgets('dark mode uses grey500 background and white text/icons', (tester) async {
    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Tag dark',
        mode: DlTagMode.dark,
        iconLeft: DlPlaceholderIcon(key: Key('dark_left_icon')),
        iconRight: DlPlaceholderIcon(key: Key('dark_right_icon')),
      ),
    );

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_tag_container')),
    );
    final text = tester.widget<Text>(find.byKey(const Key('dl_tag_label')));
    final leftTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_tag_icon_left_theme')),
    );
    final rightTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_tag_icon_right_theme')),
    );
    final decoration = container.decoration as BoxDecoration;

    expect(decoration.color, DlColorsLight.grey500);
    expect(text.style?.color, DlColorsLight.white);
    expect(leftTheme.data.color, DlColorsLight.white);
    expect(rightTheme.data.color, DlColorsLight.white);
  });

  testWidgets('warning type uses yellow palette for light and dark modes', (
    tester,
  ) async {
    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Warning light',
        type: DlTagType.warning,
        mode: DlTagMode.light,
      ),
    );

    var container = tester.widget<Container>(find.byKey(const Key('dl_tag_container')));
    var text = tester.widget<Text>(find.byKey(const Key('dl_tag_label')));
    var decoration = container.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.yellow300);
    expect(text.style?.color, DlColorsLight.yellow700);

    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Warning dark',
        type: DlTagType.warning,
        mode: DlTagMode.dark,
      ),
    );

    container = tester.widget<Container>(find.byKey(const Key('dl_tag_container')));
    text = tester.widget<Text>(find.byKey(const Key('dl_tag_label')));
    decoration = container.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.yellow500);
    expect(text.style?.color, Colors.black);
  });

  testWidgets('error and success types use configured light and dark palettes', (
    tester,
  ) async {
    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Error light',
        type: DlTagType.error,
        mode: DlTagMode.light,
      ),
    );
    var container = tester.widget<Container>(find.byKey(const Key('dl_tag_container')));
    var text = tester.widget<Text>(find.byKey(const Key('dl_tag_label')));
    var decoration = container.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.red100);
    expect(text.style?.color, DlColorsLight.red600);

    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Error dark',
        type: DlTagType.error,
        mode: DlTagMode.dark,
      ),
    );
    container = tester.widget<Container>(find.byKey(const Key('dl_tag_container')));
    text = tester.widget<Text>(find.byKey(const Key('dl_tag_label')));
    decoration = container.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.red500);
    expect(text.style?.color, Colors.white);

    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Success light',
        type: DlTagType.success,
        mode: DlTagMode.light,
      ),
    );
    container = tester.widget<Container>(find.byKey(const Key('dl_tag_container')));
    text = tester.widget<Text>(find.byKey(const Key('dl_tag_label')));
    decoration = container.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.green100);
    expect(text.style?.color, DlColorsLight.green700);

    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Success dark',
        type: DlTagType.success,
        mode: DlTagMode.dark,
      ),
    );
    container = tester.widget<Container>(find.byKey(const Key('dl_tag_container')));
    text = tester.widget<Text>(find.byKey(const Key('dl_tag_label')));
    decoration = container.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.green600);
    expect(text.style?.color, Colors.white);
  });

  testWidgets('dark warning/error/success icons match text color', (tester) async {
    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Warning dark',
        type: DlTagType.warning,
        mode: DlTagMode.dark,
        iconLeft: DlPlaceholderIcon(),
      ),
    );
    var iconTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_tag_icon_left_theme')),
    );
    expect(iconTheme.data.color, Colors.black);

    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Error dark',
        type: DlTagType.error,
        mode: DlTagMode.dark,
        iconLeft: DlPlaceholderIcon(),
      ),
    );
    iconTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_tag_icon_left_theme')),
    );
    expect(iconTheme.data.color, Colors.white);

    await pumpTag(
      tester,
      tag: const DlTag(
        label: 'Success dark',
        type: DlTagType.success,
        mode: DlTagMode.dark,
        iconLeft: DlPlaceholderIcon(),
      ),
    );
    iconTheme = tester.widget<IconTheme>(
      find.byKey(const Key('dl_tag_icon_left_theme')),
    );
    expect(iconTheme.data.color, Colors.white);
  });
}
