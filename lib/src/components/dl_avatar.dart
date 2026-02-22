import 'package:flutter/material.dart';

import '../foundations/icons/dl_icons.dart';
import '../foundations/tokens/dl_border_width_tokens.dart';
import '../foundations/tokens/dl_radius_tokens.dart';
import '../foundations/tokens/dl_spacing_tokens.dart';
import '../theme/dl_color_palette.dart';
import '../theme/dl_text_styles.dart';

enum DlAvatarSize { lg, md, sm, xs }

enum DlAvatarState { defaultState, online, offline }

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
            assetPath: DlIcons.userAsset,
            size: _iconDimensionForSize(),
          ),
          DlAvatarType.initials => Text(
            initials,
            key: const Key('dl_avatar_initials'),
            style: _initialsStyle().copyWith(color: colors.grey.c500),
            maxLines: 1,
            softWrap: false,
          ),
          DlAvatarType.image => ClipRRect(
            borderRadius: BorderRadius.circular(DlRadiusTokens.roundedFull),
            child: Image.asset(
              DlIcons.avatarImageAsset,
              key: const Key('dl_avatar_image'),
              width: _dimensionForSize(),
              height: _dimensionForSize(),
              fit: BoxFit.cover,
            ),
          ),
        },
      ),
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatarBody,
        if (state == DlAvatarState.online || state == DlAvatarState.offline)
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
                  width: DlBorderWidthTokens.border2,
                ),
              ),
              child: Container(
                key: const Key('dl_avatar_online_dot'),
                width: _statusDotDimensionForSize(),
                height: _statusDotDimensionForSize(),
                decoration: BoxDecoration(
                  color: state == DlAvatarState.online
                      ? colors.green.c500
                      : colors.grey.c200,
                  borderRadius: BorderRadius.circular(
                    DlRadiusTokens.roundedFull,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  double _dimensionForSize() {
    switch (size) {
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
      case DlAvatarSize.lg:
        return DlTextStyles.textXl.semiBold;
      case DlAvatarSize.md:
        return DlTextStyles.textLg.semiBold;
      case DlAvatarSize.sm:
        return DlTextStyles.textSm.semiBold;
      case DlAvatarSize.xs:
        return DlTextStyles.textXs.semiBold;
    }
  }

  double _iconDimensionForSize() {
    switch (size) {
      case DlAvatarSize.xs:
        return 16;
      case DlAvatarSize.sm:
        return 20;
      case DlAvatarSize.lg:
      case DlAvatarSize.md:
        return 24;
    }
  }
}
