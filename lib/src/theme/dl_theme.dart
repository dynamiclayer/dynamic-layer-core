import 'package:flutter/material.dart';

import 'dl_color_palette.dart';

/// Central helpers to build Dynamic Layer base themes.
abstract final class DlTheme {
  const DlTheme._();

  static ThemeData light({
    ThemeData? baseTheme,
    DlColorPalette palette = DlColorPalette.light,
  }) {
    final theme = (baseTheme ?? ThemeData.light(useMaterial3: true)).copyWith(
      brightness: Brightness.light,
    );
    return _withPalette(theme, palette);
  }

  static ThemeData dark({
    ThemeData? baseTheme,
    DlColorPalette palette = DlColorPalette.dark,
  }) {
    final theme = (baseTheme ?? ThemeData.dark(useMaterial3: true)).copyWith(
      brightness: Brightness.dark,
    );
    return _withPalette(theme, palette);
  }

  static ThemeData _withPalette(ThemeData theme, DlColorPalette palette) {
    final extensions = theme.extensions.values
        .where((extension) => extension is! DlColorPalette)
        .toList(growable: true);
    extensions.add(palette);
    return theme.copyWith(extensions: extensions);
  }
}
