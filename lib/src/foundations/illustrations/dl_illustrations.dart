import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract final class DlIllustrations {
  const DlIllustrations._();

  static const String dynamiclayerAsset =
      'packages/dynamic_layer_core/assets/illustrations/dynamiclayer.svg';

  static const String notificationAsset =
      'packages/dynamic_layer_core/assets/illustrations/notification.svg';

  static const String qrCodeAsset =
      'packages/dynamic_layer_core/assets/illustrations/qr-code.svg';

  static const String couponAsset =
      'packages/dynamic_layer_core/assets/illustrations/coupon.svg';

  static const String badgeDisabledAsset =
      'packages/dynamic_layer_core/assets/illustrations/badge-disabled.svg';

  static const String bronzeBadgeAsset =
      'packages/dynamic_layer_core/assets/illustrations/bronze-badge.svg';

  static const String silverBadgeAsset =
      'packages/dynamic_layer_core/assets/illustrations/silver-badge.svg';

  static const String goldBadgeAsset =
      'packages/dynamic_layer_core/assets/illustrations/gold-badge.svg';

  static const String platinBadgeAsset =
      'packages/dynamic_layer_core/assets/illustrations/platin-badge.svg';

  static const String platinBadgeDisabledAsset =
      'packages/dynamic_layer_core/assets/illustrations/platin-badge-disabled.svg';
}

class DlIllustration extends StatelessWidget {
  const DlIllustration({
    required this.assetPath,
    super.key,
    this.width,
    this.height,
    this.color,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}
