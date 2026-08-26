/// DlAvatar — Usage rules:
/// - A circular avatar displaying a user icon, initials, or image.
/// - Types: icon (default, generic user icon), initials (two-letter text),
///   image (profile photo).
/// - When using type initials, always use the first letter of the first name
///   and the first letter of the last name (e.g. "Andrew Doe" → "AD").
/// - Sizes: 8xl (120px), 7xl (112px), 6xl (104px), 5xl (96px), 4xl (88px),
///   3xl (80px), 2xl (72px), xl (64px), lg (default, 56px), md (48px),
///   sm (40px), xs (32px).
/// - States: defaultState (no indicator), online (green dot), offline (grey dot).
///   The status dot appears at the bottom-right corner.
/// - Use in user-related contexts: profile headers, message lists, contact
///   cards, DlTopNavigation.
import 'package:flutter/material.dart';

import '../foundations/icons/dl_icons.dart';
import '../foundations/tokens/dl_border_width_tokens.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlAvatarSize { xl8, xl7, xl6, xl5, xl4, xl3, xl2, xl, lg, md, sm, xs }

enum DlAvatarState { defaultState, online, offline, add }

enum DlAvatarType { icon, initials, image }

class DlAvatar extends StatelessWidget {
  const DlAvatar({
    super.key,
    this.size = DlAvatarSize.lg,
    this.state = DlAvatarState.defaultState,
    this.type = DlAvatarType.icon,
    this.initials = 'AA',
  });

  final DlAvatarSize size;
  final DlAvatarState state;
  final DlAvatarType type;
  final String initials;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    final avatarBody = Container(
      key: const Key('dl_avatar_container'),
      width: _dimensionForSize(),
      height: _dimensionForSize(),
      decoration: BoxDecoration(
        color: colors.grey.c100,
        borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
      ),
      child: Center(
        child: switch (type) {
          DlAvatarType.icon => DlAssetIcon(
            key: Key('dl_avatar_icon'),
            assetPath: DlIcons.userFilledAsset,
            size: _iconDimensionForSize(),
            color: colors.grey.c400,
          ),
          DlAvatarType.initials => Text(
            initials,
            key: const Key('dl_avatar_initials'),
            style: _initialsStyle().copyWith(color: colors.grey.c500),
            maxLines: 1,
            softWrap: false,
          ),
          DlAvatarType.image => DlAssetIcon(
            key: const Key('dl_avatar_image'),
            assetPath: DlIcons.placeholderAsset,
            size: _iconDimensionForSize(),
            color: colors.grey.c500,
          ),
        },
      ),
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatarBody,
        if (state == DlAvatarState.online || state == DlAvatarState.offline || state == DlAvatarState.add)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              key: const Key('dl_avatar_online_outer'),
              width: _statusOuterDimensionForSize(),
              height: _statusOuterDimensionForSize(),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
                border: Border.all(
                  color: colors.white,
                  width: _statusDotDimensionForSize() >= 30
                      ? DlBorderWidthTokens.border4
                      : _statusDotDimensionForSize() >= 20
                          ? DlBorderWidthTokens.border3
                          : DlBorderWidthTokens.border2,
                ),
              ),
              child: Container(
                key: const Key('dl_avatar_online_dot'),
                width: _statusDotDimensionForSize(),
                height: _statusDotDimensionForSize(),
                decoration: BoxDecoration(
                  color: state == DlAvatarState.online
                      ? colors.green.c500
                      : state == DlAvatarState.add
                          ? colors.blue.c500
                          : colors.grey.c200,
                  borderRadius: BorderRadius.circular(
                    DlRadiusTokens.roundedFull,
                  ),
                ),
                child: state == DlAvatarState.add
                    ? Center(
                        child: SizedBox(
                          width: _plusIconDimension(),
                          height: _plusIconDimension(),
                          child: CustomPaint(
                            key: const Key('dl_avatar_add_plus'),
                            painter: _PlusIconPainter(
                              color: colors.white,
                              strokeWidth: _plusStrokeWidth(),
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
      ],
    );
  }

  double _dimensionForSize() {
    switch (size) {
      case DlAvatarSize.xl8:
        return 120;
      case DlAvatarSize.xl7:
        return 112;
      case DlAvatarSize.xl6:
        return 104;
      case DlAvatarSize.xl5:
        return DlSpacingTokens.p_96;
      case DlAvatarSize.xl4:
        return 88;
      case DlAvatarSize.xl3:
        return DlSpacingTokens.p_80;
      case DlAvatarSize.xl2:
        return 72;
      case DlAvatarSize.xl:
        return DlSpacingTokens.p_64;
      case DlAvatarSize.lg:
        return DlSpacingTokens.p_56;
      case DlAvatarSize.md:
        return DlSpacingTokens.p_48;
      case DlAvatarSize.sm:
        return DlSpacingTokens.p_40;
      case DlAvatarSize.xs:
        return DlSpacingTokens.p_32;
    }
  }

  double _statusDotDimensionForSize() {
    switch (size) {
      case DlAvatarSize.xl8:
        return 32;
      case DlAvatarSize.xl7:
        return 30;
      case DlAvatarSize.xl6:
        return 28;
      case DlAvatarSize.xl5:
        return 26;
      case DlAvatarSize.xl4:
        return 24;
      case DlAvatarSize.xl3:
        return 22;
      case DlAvatarSize.xl2:
        return 20;
      case DlAvatarSize.xl:
        return 18;
      case DlAvatarSize.lg:
        return 16;
      case DlAvatarSize.md:
        return 14;
      case DlAvatarSize.sm:
        return 12;
      case DlAvatarSize.xs:
        return 8;
    }
  }

  double _statusOuterDimensionForSize() {
    switch (size) {
      case DlAvatarSize.xl8:
        return 40;
      case DlAvatarSize.xl7:
        return 38;
      case DlAvatarSize.xl6:
        return 34;
      case DlAvatarSize.xl5:
        return 32;
      case DlAvatarSize.xl4:
        return 30;
      case DlAvatarSize.xl3:
        return 28;
      case DlAvatarSize.xl2:
        return 26;
      case DlAvatarSize.xl:
        return 24;
      case DlAvatarSize.lg:
        return 20;
      case DlAvatarSize.md:
        return 18;
      case DlAvatarSize.sm:
        return 16;
      case DlAvatarSize.xs:
        return 12;
    }
  }

  TextStyle _initialsStyle() {
    switch (size) {
      case DlAvatarSize.xl8:
      case DlAvatarSize.xl7:
      case DlAvatarSize.xl6:
        return DlTextStyles.text5Xl.bold;
      case DlAvatarSize.xl5:
      case DlAvatarSize.xl4:
        return DlTextStyles.text4Xl.bold;
      case DlAvatarSize.xl3:
      case DlAvatarSize.xl2:
        return DlTextStyles.text3Xl.bold;
      case DlAvatarSize.xl:
        return DlTextStyles.text2Xl.bold;
      case DlAvatarSize.lg:
        return DlTextStyles.textXl.bold;
      case DlAvatarSize.md:
        return DlTextStyles.textLg.bold;
      case DlAvatarSize.sm:
        return DlTextStyles.textSm.bold;
      case DlAvatarSize.xs:
        return DlTextStyles.textXs.bold;
    }
  }

  double _iconDimensionForSize() {
    switch (size) {
      case DlAvatarSize.xl8:
        return DlSpacingTokens.p_56;
      case DlAvatarSize.xl7:
        return DlSpacingTokens.p_48;
      case DlAvatarSize.xl6:
        return DlSpacingTokens.p_44;
      case DlAvatarSize.xl5:
        return DlSpacingTokens.p_40;
      case DlAvatarSize.xl4:
        return DlSpacingTokens.p_36;
      case DlAvatarSize.xl3:
        return DlSpacingTokens.p_32;
      case DlAvatarSize.xl2:
        return DlSpacingTokens.p_28;
      case DlAvatarSize.xl:
        return DlSpacingTokens.p_24;
      case DlAvatarSize.lg:
      case DlAvatarSize.md:
        return 24;
      case DlAvatarSize.sm:
        return 20;
      case DlAvatarSize.xs:
        return 16;
    }
  }

  double _plusStrokeWidth() {
    switch (size) {
      case DlAvatarSize.xl8:
        return 4;
      case DlAvatarSize.xl7:
        return 4;
      case DlAvatarSize.xl6:
        return 3;
      case DlAvatarSize.xl5:
        return 3;
      case DlAvatarSize.xl4:
        return 3;
      case DlAvatarSize.xl3:
        return 3;
      case DlAvatarSize.xl2:
        return 3;
      case DlAvatarSize.xl:
        return 2;
      case DlAvatarSize.lg:
        return 2;
      case DlAvatarSize.md:
        return 1.5;
      case DlAvatarSize.sm:
        return 1.5;
      case DlAvatarSize.xs:
        return 1;
    }
  }

  double _plusIconDimension() {
    switch (size) {
      case DlAvatarSize.xl8:
        return 14;
      case DlAvatarSize.xl7:
        return 12;
      case DlAvatarSize.xl6:
        return 10;
      case DlAvatarSize.xl5:
        return 10;
      case DlAvatarSize.xl4:
        return 8;
      case DlAvatarSize.xl3:
        return 8;
      case DlAvatarSize.xl2:
        return 8;
      case DlAvatarSize.xl:
        return 6;
      case DlAvatarSize.lg:
        return 6;
      case DlAvatarSize.md:
        return 6;
      case DlAvatarSize.sm:
        return 4;
      case DlAvatarSize.xs:
        return 2;
    }
  }
}

class _PlusIconPainter extends CustomPainter {
  _PlusIconPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _PlusIconPainter oldDelegate) =>
      color != oldDelegate.color || strokeWidth != oldDelegate.strokeWidth;
}
