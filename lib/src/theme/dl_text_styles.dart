import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';

import '../foundations/tokens/dl_typography_tokens.dart';

@immutable
class DlTextStyleScale {
  const DlTextStyleScale({
    required this.light,
    required this.regular,
    required this.medium,
    required this.semiBold,
    required this.bold,
    required this.link,
    required this.strike,
  });

  final TextStyle light;
  final TextStyle regular;
  final TextStyle medium;
  final TextStyle semiBold;
  final TextStyle bold;
  final TextStyle link;
  final TextStyle strike;
}

/// Predefined text styles derived from Dynamic Layer Figma text styles.
abstract final class DlTextStyles {
  const DlTextStyles._();

  static final DlTextStyleScale textXs = _buildScale(
    fontSize: DlTypographyTokens.fontSize1,
    lineHeight: DlTypographyTokens.lineHeight1,
    letterSpacing: 0.5,
  );

  static final DlTextStyleScale textSm = _buildScale(
    fontSize: DlTypographyTokens.fontSize2,
    lineHeight: DlTypographyTokens.lineHeight2,
    letterSpacing: 0.5,
  );

  static final DlTextStyleScale textBase = _buildScale(
    fontSize: DlTypographyTokens.fontSize3,
    lineHeight: DlTypographyTokens.lineHeight3,
    letterSpacing: 0.5,
  );

  static final DlTextStyleScale textLg = _buildScale(
    fontSize: DlTypographyTokens.fontSize4,
    lineHeight: DlTypographyTokens.lineHeight4,
    letterSpacing: 0.5,
  );

  static final DlTextStyleScale textXl = _buildScale(
    fontSize: DlTypographyTokens.fontSize5,
    lineHeight: DlTypographyTokens.lineHeight5,
    letterSpacing: 0.5,
  );

  static final DlTextStyleScale text2Xl = _buildScale(
    fontSize: DlTypographyTokens.fontSize6,
    lineHeight: DlTypographyTokens.lineHeight6,
    letterSpacing: 0.5,
  );

  static final DlTextStyleScale text3Xl = _buildScale(
    fontSize: DlTypographyTokens.fontSize7,
    lineHeight: DlTypographyTokens.lineHeight7,
    letterSpacing: 0.5,
  );

  static final DlTextStyleScale text4Xl = _buildScale(
    fontSize: DlTypographyTokens.fontSize8,
    lineHeight: DlTypographyTokens.lineHeight8,
    letterSpacing: 0.5,
  );

  static final DlTextStyleScale text5Xl = _buildScale(
    fontSize: DlTypographyTokens.fontSize9,
    lineHeight: DlTypographyTokens.lineHeight9,
    letterSpacing: 0.5,
  );

  static DlTextStyleScale _buildScale({
    required double fontSize,
    required double lineHeight,
    required double letterSpacing,
  }) {
    return DlTextStyleScale(
      light: _style(
        fontSize: fontSize,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        fontWeight: DlTypographyTokens.weightLight,
      ),
      regular: _style(
        fontSize: fontSize,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        fontWeight: DlTypographyTokens.weightRegular,
      ),
      medium: _style(
        fontSize: fontSize,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        fontWeight: DlTypographyTokens.weightMedium,
      ),
      semiBold: _style(
        fontSize: fontSize,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        fontWeight: DlTypographyTokens.weightSemibold,
      ),
      bold: _style(
        fontSize: fontSize,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        fontWeight: DlTypographyTokens.weightBold,
      ),
      link: _style(
        fontSize: fontSize,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        fontWeight: DlTypographyTokens.weightBold,
        decoration: TextDecoration.underline,
      ),
      strike: _style(
        fontSize: fontSize,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        fontWeight: DlTypographyTokens.weightRegular,
        decoration: TextDecoration.lineThrough,
      ),
    );
  }

  static final String? _fontFamily = Platform.isIOS ? '.AppleSystemUIFontRounded' : null;

  static TextStyle _style({
    required double fontSize,
    required double lineHeight,
    required double letterSpacing,
    required FontWeight fontWeight,
    TextDecoration decoration = TextDecoration.none,
  }) {
    if (decoration != TextDecoration.none) {
      return _DecoratedTextStyle(
        fontFamily: _fontFamily,
        fontSize: fontSize,
        height: lineHeight / fontSize,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
        decoration: decoration,
      );
    }
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight,
      decoration: decoration,
    );
  }
}

class _DecoratedTextStyle extends TextStyle {
  const _DecoratedTextStyle({
    super.fontFamily,
    super.fontSize,
    super.height,
    super.letterSpacing,
    super.fontWeight,
    super.decoration,
  });

  @override
  TextStyle copyWith({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) {
    return super.copyWith(
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      leadingDistribution: leadingDistribution,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      fontVariations: fontVariations,
      decoration: decoration,
      decorationColor: decorationColor ?? color,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
      package: package,
      overflow: overflow,
    );
  }
}
