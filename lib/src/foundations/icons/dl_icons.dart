import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract final class DlIcons {
  const DlIcons._();

  static const String placeholderAsset =
      'packages/dynamiclayer_flutter/assets/icons/placeholder.svg';
  static const String alertTriangleFilledAsset =
      'packages/dynamiclayer_flutter/assets/icons/alert-triangle-filled.svg';
  static const String circleAlertAsset =
      'packages/dynamiclayer_flutter/assets/icons/circle-alert.svg';
  static const String circleCheckAsset =
      'packages/dynamiclayer_flutter/assets/icons/circle-check.svg';
  static const String arrowUpAsset =
      'packages/dynamiclayer_flutter/assets/icons/arrow-up.svg';
  static const String circleXAsset =
      'packages/dynamiclayer_flutter/assets/icons/circle-x.svg';
  static const String infoAsset =
      'packages/dynamiclayer_flutter/assets/icons/info.svg';
  static const String plusAsset = 'packages/dynamiclayer_flutter/assets/icons/plus.svg';
  static const String searchAsset =
      'packages/dynamiclayer_flutter/assets/icons/search.svg';
  static const String xAsset = 'packages/dynamiclayer_flutter/assets/icons/x.svg';
  static const String userAsset =
      'packages/dynamiclayer_flutter/assets/icons/user.svg';
  static const String avatarImageAsset =
      'packages/dynamiclayer_flutter/assets/icons/avatar-image.png';
}

class DlPlaceholderIcon extends StatelessWidget {
  const DlPlaceholderIcon({super.key, this.size = 24, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? IconTheme.of(context).color;
    return SvgPicture.asset(
      DlIcons.placeholderAsset,
      width: size,
      height: size,
      colorFilter: effectiveColor == null
          ? null
          : ColorFilter.mode(effectiveColor, BlendMode.srcIn),
    );
  }
}

class DlAssetIcon extends StatelessWidget {
  const DlAssetIcon({
    required this.assetPath,
    super.key,
    this.size = 24,
    this.color,
  });

  final String assetPath;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? IconTheme.of(context).color;

    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: effectiveColor == null
          ? null
          : ColorFilter.mode(effectiveColor, BlendMode.srcIn),
    );
  }
}
