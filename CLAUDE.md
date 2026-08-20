# DynamicLayer Core — Component Library

DynamicLayer is a commercial design system for mobile app development. It exists as two identical versions — Figma for designers and Flutter for developers — sharing the same tokens, text styles, and component structures.

This is the **Core repository** (public, free). It contains all components, tokens, styles, icons, and theme foundations. Templates and the example app live in the separate `dynamic_layer_flows` repository (private, paid).

## Project structure

```
lib/
  dynamic_layer_core.dart        # Barrel export (re-exports all public API)
  src/
    components/                    # All DL components (dl_button.dart, dl_input.dart, ...)
    foundations/
      icons/                       # Icon assets and DlIcons class
      tokens/                      # Spacing, radius, border width, color, typography tokens
    theme/                         # DlColorPalette, DlTextStyles, DlTheme
test/
  components/                      # Component tests
```

## Related repositories

- **`dynamic_layer_flows`** (private, paid) — Example app with templates, component catalog, and template catalog. Depends on `dynamic_layer_core` via path dependency. Templates and flows are developed there.

## Naming conventions

- **Files:** Always use `dl_` prefix for component files (e.g. `dl_button.dart`, `dl_card.dart`)
- **Classes:** Always use `Dl` prefix (e.g. `DlButton`, `DlCard`)
- **Enums:** `Dl` + component name + property (e.g. `DlButtonType`, `DlButtonSize`, `DlButtonState`)
- **Tokens:** `Dl[Category]Tokens` (e.g. `DlSpacingTokens`, `DlRadiusTokens`)

## Component rules

- Each component file contains a doc comment at the top describing usage rules and constraints (e.g. positioning, where to place it, what to avoid). Always read and follow these comments when using a component.
- Each component lives in its own file under `lib/src/components/`
- Use `required` only for truly mandatory parameters; everything else is optional with sensible defaults
- Define enums for `Type`, `Size`, and `State` when the component needs them
- Assign `Key` values to internal widgets (e.g. `Key('dl_button_material')`)
- Use `StatefulWidget` when the component needs internal state, `StatelessWidget` otherwise
- Always add new components to the barrel export in `lib/dynamic_layer_core.dart`
- When adding a customizable widget slot (e.g. `iconLeftWidget`) to a component, the custom widget must inherit the same styling context (IconTheme, wrappers, colors) as the default widget. Pattern: `Wrapper(child: widget.customWidget ?? const DefaultWidget())` — never render the custom widget without the wrapper that the default widget has

## Foundations

### Tokens — always use token classes, never raw values

| Token class | Examples |
|---|---|
| `DlSpacingTokens` | `p_0`, `p_2`, `p_4`, `p_8`, `p_12`, `p_16`, `p_20`, `p_24`, `p_28`, `p_32`, `p_36`, `p_40`, `p_44`, `p_48`, `p_56`, `p_64`, `p_80`, `p_96` |
| `DlRadiusTokens` | `roundedNone`, `roundedSm`, `rounded`, `roundedMd`, `roundedLg`, `roundedXl`, `rounded2Xl`, `rounded3Xl`, `rounded4Xl`, `rounded5Xl`, `roundedFull` |
| `DlBorderWidthTokens` | `border0`, `border0_5`, `border1`, `border1_5`, `border2`, `border3`, `border4` |

### Colors — always use `context.dlColors`

Access colors via `context.dlColors` (e.g. `colors.grey.c500`, `colors.red.c500`). Never use direct Flutter colors like `Colors.black`.

### Text styles

Pattern: `DlTextStyles.[size].[weight]`

**Sizes:** `textXs`, `textSm`, `textBase`, `textLg`, `textXl`, `text2Xl`, `text3Xl`, `text4Xl`, `text5Xl`

**Weights:** `light`, `regular`, `medium`, `semiBold`, `bold`, `link`, `strike`

Example: `DlTextStyles.textBase.regular`, `DlTextStyles.textSm.semiBold`

## Dos and Don'ts

### Do
- Always use a white background for every new screen: `Scaffold(backgroundColor: context.dlColors.white)`
- Always wrap screen content in `SafeArea` to respect system insets on all sides — top (status bar), bottom (home indicator), and sides (notch/dynamic island). Components like `DlTopNavigation` or `DlButtonDock` must never render behind system UI
- Write all code, labels, comments, and variable names in English
- Always use DynamicLayer tokens — never raw pixel values or color values
- Use relative imports inside the library (`lib/src/`)
- Use package imports (`package:dynamic_layer_core/...`) in tests
- Follow existing component patterns when creating new components

### Don't
- Don't add external packages without explicit approval (only Flutter SDK and `flutter_svg` by default)
- Don't change existing token values without asking first
- Don't rename Figma tokens without asking first
- Don't write tests unless explicitly asked to
