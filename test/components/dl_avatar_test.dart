import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpAvatar(
    WidgetTester tester, {
    required DlAvatar avatar,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: avatar)),
      ),
    );
  }

  testWidgets('renders lg avatar with full radius and grey100 background', (
    tester,
  ) async {
    await pumpAvatar(tester, avatar: const DlAvatar());

    final container = tester.widget<Container>(
      find.byKey(const Key('dl_avatar_container')),
    );
    final decoration = container.decoration as BoxDecoration;
    final size = tester.getSize(find.byKey(const Key('dl_avatar_container')));

    expect(size.width, DlSpacingTokens.p_56);
    expect(size.height, DlSpacingTokens.p_56);
    expect(decoration.color, DlColorsLight.grey100);
    expect(
      decoration.borderRadius,
      BorderRadius.circular(DlRadiusTokens.roundedFull),
    );
  });

  testWidgets('renders md avatar with 48x48 size', (tester) async {
    await pumpAvatar(tester, avatar: const DlAvatar(size: DlAvatarSize.md));

    final size = tester.getSize(find.byKey(const Key('dl_avatar_container')));
    expect(size.width, DlSpacingTokens.p_48);
    expect(size.height, DlSpacingTokens.p_48);
  });

  testWidgets('renders sm avatar with 40x40 size', (tester) async {
    await pumpAvatar(tester, avatar: const DlAvatar(size: DlAvatarSize.sm));

    final size = tester.getSize(find.byKey(const Key('dl_avatar_container')));
    expect(size.width, DlSpacingTokens.p_40);
    expect(size.height, DlSpacingTokens.p_40);
  });

  testWidgets('renders xs avatar with 32x32 size', (tester) async {
    await pumpAvatar(tester, avatar: const DlAvatar(size: DlAvatarSize.xs));

    final size = tester.getSize(find.byKey(const Key('dl_avatar_container')));
    expect(size.width, DlSpacingTokens.p_32);
    expect(size.height, DlSpacingTokens.p_32);
  });

  testWidgets('renders centered user icon asset', (tester) async {
    await pumpAvatar(tester, avatar: const DlAvatar());

    final icon = tester.widget<DlAssetIcon>(
      find.byKey(const Key('dl_avatar_icon')),
    );
    expect(icon.assetPath, DlIcons.userAsset);
    expect(icon.size, 24);
    expect(icon.color, DlColorsLight.grey500);
  });

  testWidgets('uses 16x16 user icon for xs size', (tester) async {
    await pumpAvatar(tester, avatar: const DlAvatar(size: DlAvatarSize.xs));

    final icon = tester.widget<DlAssetIcon>(
      find.byKey(const Key('dl_avatar_icon')),
    );
    expect(icon.size, 16);
  });

  testWidgets('uses 20x20 user icon for sm size', (tester) async {
    await pumpAvatar(tester, avatar: const DlAvatar(size: DlAvatarSize.sm));

    final icon = tester.widget<DlAssetIcon>(
      find.byKey(const Key('dl_avatar_icon')),
    );
    expect(icon.size, 20);
  });

  testWidgets('renders initials when type is initials', (tester) async {
    await pumpAvatar(
      tester,
      avatar: const DlAvatar(type: DlAvatarType.initials, initials: 'Aa'),
    );

    final initialsText = tester.widget<Text>(
      find.byKey(const Key('dl_avatar_initials')),
    );
    expect(initialsText.data, 'Aa');
    expect(
      initialsText.style?.fontWeight,
      DlTextStyles.textXl.semiBold.fontWeight,
    );
    expect(initialsText.style?.fontSize, DlTextStyles.textXl.semiBold.fontSize);
    expect(initialsText.style?.color, DlColorsLight.grey500);
    expect(find.byKey(const Key('dl_avatar_icon')), findsNothing);
  });

  testWidgets('maps initials typography per avatar size', (tester) async {
    final expected = <DlAvatarSize, TextStyle>{
      DlAvatarSize.lg: DlTextStyles.textXl.semiBold,
      DlAvatarSize.md: DlTextStyles.textLg.semiBold,
      DlAvatarSize.sm: DlTextStyles.textSm.semiBold,
      DlAvatarSize.xs: DlTextStyles.textXs.semiBold,
    };

    for (final entry in expected.entries) {
      await pumpAvatar(
        tester,
        avatar: DlAvatar(
          size: entry.key,
          type: DlAvatarType.initials,
          initials: 'Aa',
        ),
      );

      final text = tester.widget<Text>(
        find.byKey(const Key('dl_avatar_initials')),
      );
      expect(text.style?.fontSize, entry.value.fontSize);
      expect(text.style?.fontWeight, entry.value.fontWeight);
    }
  });

  testWidgets('renders image when type is image', (tester) async {
    await pumpAvatar(tester, avatar: const DlAvatar(type: DlAvatarType.image));

    final image = tester.widget<Image>(
      find.byKey(const Key('dl_avatar_image')),
    );
    final provider = image.image as AssetImage;
    expect(provider.assetName, DlIcons.avatarImageAsset);
    expect(find.byKey(const Key('dl_avatar_icon')), findsNothing);
    expect(find.byKey(const Key('dl_avatar_initials')), findsNothing);
  });

  testWidgets('renders online state indicator at bottom right', (tester) async {
    await pumpAvatar(
      tester,
      avatar: const DlAvatar(state: DlAvatarState.online),
    );

    final outer = tester.widget<Container>(
      find.byKey(const Key('dl_avatar_online_outer')),
    );
    final outerDecoration = outer.decoration as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const Key('dl_avatar_online_dot')),
    );
    final dotDecoration = dot.decoration as BoxDecoration;

    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_outer'))).width,
      20,
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_outer'))).height,
      20,
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_dot'))).width,
      16,
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_dot'))).height,
      16,
    );
    expect(
      (outerDecoration.border as Border).top.width,
      DlBorderWidthTokens.border2,
    );
    expect((outerDecoration.border as Border).top.color, DlColorsLight.white);
    expect(dotDecoration.color, DlColorsLight.green500);
  });

  testWidgets('renders offline state indicator with grey200 dot', (
    tester,
  ) async {
    await pumpAvatar(
      tester,
      avatar: const DlAvatar(state: DlAvatarState.offline),
    );

    final dot = tester.widget<Container>(
      find.byKey(const Key('dl_avatar_online_dot')),
    );
    final dotDecoration = dot.decoration as BoxDecoration;
    expect(dotDecoration.color, DlColorsLight.grey200);
  });

  testWidgets('uses md status dot size 14x14 when size is md', (tester) async {
    await pumpAvatar(
      tester,
      avatar: const DlAvatar(
        size: DlAvatarSize.md,
        state: DlAvatarState.online,
      ),
    );

    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_outer'))).width,
      18,
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_outer'))).height,
      18,
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_dot'))).width,
      14,
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_dot'))).height,
      14,
    );
  });

  testWidgets('uses sm status dot size 12x12 when size is sm', (tester) async {
    await pumpAvatar(
      tester,
      avatar: const DlAvatar(
        size: DlAvatarSize.sm,
        state: DlAvatarState.online,
      ),
    );

    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_outer'))).width,
      16,
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_outer'))).height,
      16,
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_dot'))).width,
      12,
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_dot'))).height,
      12,
    );
  });

  testWidgets('uses xs status dot size 8x8 when size is xs', (tester) async {
    await pumpAvatar(
      tester,
      avatar: const DlAvatar(
        size: DlAvatarSize.xs,
        state: DlAvatarState.online,
      ),
    );

    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_outer'))).width,
      12,
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_outer'))).height,
      12,
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_dot'))).width,
      8,
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_avatar_online_dot'))).height,
      8,
    );
  });
}
