# DlButtonIcon

## Purpose

`DlButtonIcon` is an icon-only action button for compact interactions where no text label is needed.

Use it for actions such as close, expand, edit, or secondary utility actions in toolbars and cards.

## API (Props)

- `icon` (`Widget`, required): icon widget rendered in the center.
- `onPressed` (`VoidCallback?`): tap callback. If `null`, the button is disabled.
- `type` (`DlButtonType`): visual style variant. Available: `primary`, `secondary`, `tertiary`, `ghost`.
- `size` (`DlButtonSize`): button size. Available: `lg`, `md`, `sm`, `xs`.
- `state` (`DlButtonState`): visual state override (`defaultState`, `pressed`, `disabled`).

## Variants

- Type: `primary`, `secondary`, `tertiary`, `ghost`
- State: `defaultState`, `pressed`, `disabled`

### Color behavior by type

- `primary`: black background, white icon; disabled uses grey background and grey icon.
- `secondary`: grey background, black icon; disabled uses lighter grey background and grey icon.
- `tertiary`: white background with grey border, black icon; disabled uses grey icon.
- `ghost`: no defined background in default/disabled; pressed uses grey background.

## Size

`DlButtonIcon` is always hug/hug (square), never full width.

- `lg`: `56x56` (`24px` icon + `p_16` on all sides)
- `md`: `48x48` (`24px` icon + `p_12` on all sides)
- `sm`: `40x40` (`24px` icon + `p_8` on all sides)
- `xs`: `32x32` (`24px` icon + `p_4` on all sides)

There is no gap value, because the component contains exactly one icon.

## Press interaction

`DlButtonIcon` uses the same interaction model as `DlButton`:

- Press starts on `onTapDown`
- Press ends on `onTapUp` / `onTapCancel`
- No default Material ripple/highlight is used

This keeps pressed feedback consistent with your `DlButton`.

## Example

```dart
DlButtonIcon(
  icon: const DlPlaceholderIcon(),
  type: DlButtonType.primary,
  size: DlButtonSize.lg,
  onPressed: () {},
)
```

## Example (all types)

```dart
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    DlButtonIcon(
      icon: const DlPlaceholderIcon(),
      type: DlButtonType.primary,
      onPressed: () {},
    ),
    const SizedBox(width: DlSpacingTokens.p_8),
    DlButtonIcon(
      icon: const DlPlaceholderIcon(),
      type: DlButtonType.secondary,
      onPressed: () {},
    ),
    const SizedBox(width: DlSpacingTokens.p_8),
    DlButtonIcon(
      icon: const DlPlaceholderIcon(),
      type: DlButtonType.tertiary,
      onPressed: () {},
    ),
    const SizedBox(width: DlSpacingTokens.p_8),
    DlButtonIcon(
      icon: const DlPlaceholderIcon(),
      type: DlButtonType.ghost,
      onPressed: () {},
    ),
  ],
)
```

## Example (all sizes)

```dart
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    DlButtonIcon(
      icon: const DlPlaceholderIcon(),
      size: DlButtonSize.lg,
      onPressed: () {},
    ),
    const SizedBox(width: DlSpacingTokens.p_8),
    DlButtonIcon(
      icon: const DlPlaceholderIcon(),
      size: DlButtonSize.md,
      onPressed: () {},
    ),
    const SizedBox(width: DlSpacingTokens.p_8),
    DlButtonIcon(
      icon: const DlPlaceholderIcon(),
      size: DlButtonSize.sm,
      onPressed: () {},
    ),
    const SizedBox(width: DlSpacingTokens.p_8),
    DlButtonIcon(
      icon: const DlPlaceholderIcon(),
      size: DlButtonSize.xs,
      onPressed: () {},
    ),
  ],
)
```

## Example (disabled)

```dart
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    DlButtonIcon(
      icon: const DlPlaceholderIcon(),
      type: DlButtonType.primary,
      state: DlButtonState.disabled,
      onPressed: () {},
    ),
    const SizedBox(width: DlSpacingTokens.p_8),
    DlButtonIcon(
      icon: const DlPlaceholderIcon(),
      type: DlButtonType.secondary,
      state: DlButtonState.disabled,
      onPressed: () {},
    ),
    const SizedBox(width: DlSpacingTokens.p_8),
    DlButtonIcon(
      icon: const DlPlaceholderIcon(),
      type: DlButtonType.tertiary,
      state: DlButtonState.disabled,
      onPressed: () {},
    ),
    const SizedBox(width: DlSpacingTokens.p_8),
    DlButtonIcon(
      icon: const DlPlaceholderIcon(),
      type: DlButtonType.ghost,
      state: DlButtonState.disabled,
      onPressed: () {},
    ),
  ],
)
```

## Accessibility notes

- Keep icon buttons at least `32x32` (`xs`) or larger in touch-heavy contexts.
- Provide meaningful semantics in app usage (for example with `Tooltip` or `Semantics`) since there is no visible text label.
- Disabled state is non-interactive and visually muted.

## Test cases

- Renders expected colors for each `type` in default state.
- Applies pressed colors while touch is active and resets after release.
- Applies disabled colors and blocks taps when disabled.
- Uses fixed square size (`56`, `48`, `40`, `32`) for `lg/md/sm/xs`.
- Applies expected token padding (`p_16`, `p_12`, `p_8`, `p_4`).
