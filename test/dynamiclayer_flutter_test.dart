import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';

void main() {
  group('DlTheme', () {
    test('light() returns light theme with color palette', () {
      final theme = DlTheme.light();
      expect(theme.brightness, Brightness.light);
      expect(theme.extension<DlColorPalette>(), DlColorPalette.light);
    });

    test('dark() returns dark theme with color palette', () {
      final theme = DlTheme.dark();
      expect(theme.brightness, Brightness.dark);
      expect(theme.extension<DlColorPalette>(), DlColorPalette.dark);
    });

    test('keeps other theme extensions when applying palette', () {
      const textScale = _DummyScale(2);
      final baseTheme = ThemeData(
        brightness: Brightness.light,
        extensions: const <ThemeExtension<dynamic>>[textScale],
      );

      final theme = DlTheme.light(baseTheme: baseTheme);

      expect(theme.extension<_DummyScale>(), textScale);
      expect(theme.extension<DlColorPalette>(), DlColorPalette.light);
    });

    test('supports custom palette override', () {
      final theme = DlTheme.light(palette: DlColorPalette.dark);
      expect(theme.brightness, Brightness.light);
      expect(theme.extension<DlColorPalette>(), DlColorPalette.dark);
    });
  });

  group('DlColorPalette', () {
    test('provides fallback palette by brightness', () {
      expect(
        DlColorPalette.fallbackForBrightness(Brightness.light),
        DlColorPalette.light,
      );
      expect(
        DlColorPalette.fallbackForBrightness(Brightness.dark),
        DlColorPalette.dark,
      );
    });

    test('can be attached and read from ThemeData extension', () {
      final lightTheme = ThemeData(
        brightness: Brightness.light,
        extensions: const <ThemeExtension<dynamic>>[DlColorPalette.light],
      );
      final darkTheme = ThemeData(
        brightness: Brightness.dark,
        extensions: const <ThemeExtension<dynamic>>[DlColorPalette.dark],
      );

      expect(lightTheme.extension<DlColorPalette>(), DlColorPalette.light);
      expect(darkTheme.extension<DlColorPalette>(), DlColorPalette.dark);
      expect(lightTheme.extension<DlColorPalette>()?.sky.c700, DlColorsLight.sky700);
      expect(darkTheme.extension<DlColorPalette>()?.grey.c50, DlColorsDark.grey50);
    });
  });

  group('DlColorTokens', () {
    test('exposes light mode palette values', () {
      expect(DlColorsLight.platinum50, const Color(0xFFF8FAFC));
      expect(DlColorsLight.platinum950, const Color(0xFF020617));
      expect(DlColorsLight.pink500, const Color(0xFFEC4899));
      expect(DlColorsLight.brown600, const Color(0xFFB95E35));
      expect(DlColorsLight.sky700, const Color(0xFF1D4ED8));
      expect(DlColorsLight.yellow400, const Color(0xFFFFE50D));
      expect(DlColorsLight.rose500, const Color(0xFFF43F5E));
      expect(DlColorsLight.violet600, const Color(0xFF7630F7));
      expect(DlColorsLight.blue700, const Color(0xFF0075FF));
      expect(DlColorsLight.fuchsia600, const Color(0xFFC026D3));
      expect(DlColorsLight.teal500, const Color(0xFF14B8A6));
      expect(DlColorsLight.purple500, const Color(0xFFA855F7));
      expect(DlColorsLight.green500, const Color(0xFF00DD00));
      expect(DlColorsLight.magenta500, const Color(0xFFFF27A0));
      expect(DlColorsLight.orange500, const Color(0xFFFF920A));
      expect(DlColorsLight.cyan500, const Color(0xFF06B6D4));
      expect(DlColorsLight.emerald500, const Color(0xFF10B981));
      expect(DlColorsLight.lime500, const Color(0xFF84CC16));
      expect(DlColorsLight.red500, const Color(0xFFFF2C20));
      expect(DlColorsLight.indigo500, const Color(0xFF6366F1));
    });

    test('exposes dark mode grey palette values', () {
      expect(DlColorsDark.white, const Color(0xFF141414));
      expect(DlColorsDark.grey50, const Color(0xFF1F1F1F));
      expect(DlColorsDark.grey100, const Color(0xFF333333));
      expect(DlColorsDark.grey500, const Color(0xFFCBCBCB));
      expect(DlColorsDark.grey900, const Color(0xFFFFFFFF));
      expect(DlColorsDark.black, const Color(0xFFFFFFFF));
    });

    test('reuses same chromatic palette values in dark mode', () {
      expect(DlColorsDark.platinum500, DlColorsLight.platinum500);
      expect(DlColorsDark.sky700, DlColorsLight.sky700);
      expect(DlColorsDark.green500, DlColorsLight.green500);
      expect(DlColorsDark.red700, DlColorsLight.red700);
      expect(DlColorsDark.indigo950, DlColorsLight.indigo950);
    });
  });

  group('DlBorderWidthTokens', () {
    test('exposes figma border width scale', () {
      expect(DlBorderWidthTokens.border0, 0);
      expect(DlBorderWidthTokens.border0_5, 0.5);
      expect(DlBorderWidthTokens.border1, 1);
      expect(DlBorderWidthTokens.border1_5, 1.5);
      expect(DlBorderWidthTokens.border2, 2);
      expect(DlBorderWidthTokens.border3, 3);
      expect(DlBorderWidthTokens.border4, 4);
    });
  });

  group('DlRadiusTokens', () {
    test('exposes figma radius scale', () {
      expect(DlRadiusTokens.roundedNone, 0);
      expect(DlRadiusTokens.roundedSm, 2);
      expect(DlRadiusTokens.rounded, 4);
      expect(DlRadiusTokens.roundedMd, 8);
      expect(DlRadiusTokens.roundedLg, 12);
      expect(DlRadiusTokens.roundedXl, 16);
      expect(DlRadiusTokens.rounded2Xl, 20);
      expect(DlRadiusTokens.rounded3Xl, 24);
      expect(DlRadiusTokens.rounded4Xl, 28);
      expect(DlRadiusTokens.rounded5Xl, 32);
      expect(DlRadiusTokens.roundedFull, 9999);
    });
  });

  group('DlSpacingTokens', () {
    test('exposes figma spacing scale', () {
      expect(DlSpacingTokens.p_0, 0);
      expect(DlSpacingTokens.p_2, 2);
      expect(DlSpacingTokens.p_4, 4);
      expect(DlSpacingTokens.p_8, 8);
      expect(DlSpacingTokens.p_12, 12);
      expect(DlSpacingTokens.p_16, 16);
      expect(DlSpacingTokens.p_20, 20);
      expect(DlSpacingTokens.p_24, 24);
      expect(DlSpacingTokens.p_28, 28);
      expect(DlSpacingTokens.p_32, 32);
      expect(DlSpacingTokens.p_36, 36);
      expect(DlSpacingTokens.p_40, 40);
      expect(DlSpacingTokens.p_44, 44);
      expect(DlSpacingTokens.p_48, 48);
      expect(DlSpacingTokens.p_56, 56);
      expect(DlSpacingTokens.p_64, 64);
      expect(DlSpacingTokens.p_80, 80);
      expect(DlSpacingTokens.p_96, 96);
    });
  });

  group('DlTypographyTokens', () {
    test('exposes figma font sizes', () {
      expect(DlTypographyTokens.fontSize1, 12);
      expect(DlTypographyTokens.fontSize2, 14);
      expect(DlTypographyTokens.fontSize3, 16);
      expect(DlTypographyTokens.fontSize4, 18);
      expect(DlTypographyTokens.fontSize5, 20);
      expect(DlTypographyTokens.fontSize6, 24);
      expect(DlTypographyTokens.fontSize7, 28);
      expect(DlTypographyTokens.fontSize8, 32);
      expect(DlTypographyTokens.fontSize9, 40);
    });

    test('exposes figma line heights', () {
      expect(DlTypographyTokens.lineHeight1, 16);
      expect(DlTypographyTokens.lineHeight2, 20);
      expect(DlTypographyTokens.lineHeight3, 24);
      expect(DlTypographyTokens.lineHeight4, 28);
      expect(DlTypographyTokens.lineHeight5, 28);
      expect(DlTypographyTokens.lineHeight6, 32);
      expect(DlTypographyTokens.lineHeight7, 36);
      expect(DlTypographyTokens.lineHeight8, 40);
      expect(DlTypographyTokens.lineHeight9, 48);
    });

    test('exposes figma letter spacing', () {
      expect(DlTypographyTokens.letterSpacing1, -0.4);
      expect(DlTypographyTokens.letterSpacing2, -0.16);
      expect(DlTypographyTokens.letterSpacing3, -0.12);
      expect(DlTypographyTokens.letterSpacing4, -0.1);
      expect(DlTypographyTokens.letterSpacing5, -0.08);
      expect(DlTypographyTokens.letterSpacing6, -0.04);
      expect(DlTypographyTokens.letterSpacing7, 0);
      expect(DlTypographyTokens.letterSpacing8, 0.04);
    });

    test('maps typography weights to flutter font weights', () {
      expect(DlTypographyTokens.weightLight, FontWeight.w300);
      expect(DlTypographyTokens.weightRegular, FontWeight.w400);
      expect(DlTypographyTokens.weightMedium, FontWeight.w500);
      expect(DlTypographyTokens.weightSemibold, FontWeight.w600);
      expect(DlTypographyTokens.weightBold, FontWeight.w700);
    });
  });

  group('DlTextStyles', () {
    test('maps text scale values from figma', () {
      expect(DlTextStyles.textXs.regular.fontSize, 12);
      expect(DlTextStyles.textXs.regular.height, 16 / 12);

      expect(DlTextStyles.textSm.regular.fontSize, 14);
      expect(DlTextStyles.textSm.regular.height, 20 / 14);

      expect(DlTextStyles.textBase.regular.fontSize, 16);
      expect(DlTextStyles.textBase.regular.height, 24 / 16);

      expect(DlTextStyles.textLg.regular.fontSize, 18);
      expect(DlTextStyles.textLg.regular.height, 28 / 18);

      expect(DlTextStyles.textXl.regular.fontSize, 20);
      expect(DlTextStyles.textXl.regular.height, 28 / 20);

      expect(DlTextStyles.text2Xl.regular.fontSize, 24);
      expect(DlTextStyles.text2Xl.regular.height, 32 / 24);

      expect(DlTextStyles.text3Xl.regular.fontSize, 28);
      expect(DlTextStyles.text3Xl.regular.height, 36 / 28);

      expect(DlTextStyles.text4Xl.regular.fontSize, 32);
      expect(DlTextStyles.text4Xl.regular.height, 40 / 32);

      expect(DlTextStyles.text5Xl.regular.fontSize, 40);
      expect(DlTextStyles.text5Xl.regular.height, 48 / 40);
    });

    test('maps figma letter spacing per text scale', () {
      expect(DlTextStyles.textXs.regular.letterSpacing, 0.04);
      expect(DlTextStyles.textSm.regular.letterSpacing, 0);
      expect(DlTextStyles.textBase.regular.letterSpacing, 0);
      expect(DlTextStyles.textLg.regular.letterSpacing, -0.04);
      expect(DlTextStyles.textXl.regular.letterSpacing, -0.08);
      expect(DlTextStyles.text2Xl.regular.letterSpacing, -0.1);
      expect(DlTextStyles.text3Xl.regular.letterSpacing, -0.12);
      expect(DlTextStyles.text4Xl.regular.letterSpacing, -0.16);
      expect(DlTextStyles.text5Xl.regular.letterSpacing, -0.4);
    });

    test('exposes font-weight variants', () {
      expect(DlTextStyles.textBase.light.fontWeight, FontWeight.w300);
      expect(DlTextStyles.textBase.regular.fontWeight, FontWeight.w400);
      expect(DlTextStyles.textBase.medium.fontWeight, FontWeight.w500);
      expect(DlTextStyles.textBase.semiBold.fontWeight, FontWeight.w600);
      expect(DlTextStyles.textBase.bold.fontWeight, FontWeight.w700);
    });

    test('exposes link and strike styles', () {
      expect(DlTextStyles.textLg.link.decoration, TextDecoration.underline);
      expect(DlTextStyles.textLg.link.fontWeight, FontWeight.w600);
      expect(
        DlTextStyles.textLg.strike.decoration,
        TextDecoration.lineThrough,
      );
    });
  });
}

@immutable
class _DummyScale extends ThemeExtension<_DummyScale> {
  const _DummyScale(this.value);

  final double value;

  @override
  _DummyScale copyWith({double? value}) => _DummyScale(value ?? this.value);

  @override
  _DummyScale lerp(covariant ThemeExtension<_DummyScale>? other, double t) {
    if (other is! _DummyScale) return this;
    return t < 0.5 ? this : other;
  }
}
