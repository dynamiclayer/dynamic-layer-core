import 'package:flutter/widgets.dart';

/// Typography tokens sourced from Dynamic Layer Figma.
abstract final class DlTypographyTokens {
  const DlTypographyTokens._();

  /// font / size
  static const double fontSize1 = 12;
  static const double fontSize2 = 14;
  static const double fontSize3 = 16;
  static const double fontSize4 = 18;
  static const double fontSize5 = 20;
  static const double fontSize6 = 24;
  static const double fontSize7 = 28;
  static const double fontSize8 = 32;
  static const double fontSize9 = 40;

  /// font / line-height
  static const double lineHeight1 = 16;
  static const double lineHeight2 = 20;
  static const double lineHeight3 = 24;
  static const double lineHeight4 = 28;
  static const double lineHeight5 = 28;
  static const double lineHeight6 = 32;
  static const double lineHeight7 = 36;
  static const double lineHeight8 = 40;
  static const double lineHeight9 = 48;

  /// font / letter-spacing
  static const double letterSpacing = 0.5;

  /// font / weight
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemibold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;
}
