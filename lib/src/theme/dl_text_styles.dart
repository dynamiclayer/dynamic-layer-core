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
    letterSpacing: DlTypographyTokens.letterSpacing8,
  );

  static final DlTextStyleScale textSm = _buildScale(
    fontSize: DlTypographyTokens.fontSize2,
    lineHeight: DlTypographyTokens.lineHeight2,
    letterSpacing: DlTypographyTokens.letterSpacing7,
  );

  static final DlTextStyleScale textBase = _buildScale(
    fontSize: DlTypographyTokens.fontSize3,
    lineHeight: DlTypographyTokens.lineHeight3,
    letterSpacing: DlTypographyTokens.letterSpacing7,
  );

  static final DlTextStyleScale textLg = _buildScale(
    fontSize: DlTypographyTokens.fontSize4,
    lineHeight: DlTypographyTokens.lineHeight4,
    letterSpacing: DlTypographyTokens.letterSpacing6,
  );

  static final DlTextStyleScale textXl = _buildScale(
    fontSize: DlTypographyTokens.fontSize5,
    lineHeight: DlTypographyTokens.lineHeight5,
    letterSpacing: DlTypographyTokens.letterSpacing5,
  );

  static final DlTextStyleScale text2Xl = _buildScale(
    fontSize: DlTypographyTokens.fontSize6,
    lineHeight: DlTypographyTokens.lineHeight6,
    letterSpacing: DlTypographyTokens.letterSpacing4,
  );

  static final DlTextStyleScale text3Xl = _buildScale(
    fontSize: DlTypographyTokens.fontSize7,
    lineHeight: DlTypographyTokens.lineHeight7,
    letterSpacing: DlTypographyTokens.letterSpacing3,
  );

  static final DlTextStyleScale text4Xl = _buildScale(
    fontSize: DlTypographyTokens.fontSize8,
    lineHeight: DlTypographyTokens.lineHeight8,
    letterSpacing: DlTypographyTokens.letterSpacing2,
  );

  static final DlTextStyleScale text5Xl = _buildScale(
    fontSize: DlTypographyTokens.fontSize9,
    lineHeight: DlTypographyTokens.lineHeight9,
    letterSpacing: DlTypographyTokens.letterSpacing1,
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
        fontWeight: DlTypographyTokens.weightSemibold,
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

  static TextStyle _style({
    required double fontSize,
    required double lineHeight,
    required double letterSpacing,
    required FontWeight fontWeight,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return TextStyle(
      fontSize: fontSize,
      height: lineHeight / fontSize,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight,
      decoration: decoration,
    );
  }
}
