# DlButton

## Purpose

`DlButton` is the primary call-to-action button for Dynamic Layer Flutter.

## API (Props)

- `label` (`String`, required): visible button text.
- `onPressed` (`VoidCallback?`): tap callback. If null, the button is disabled.
- `type` (`DlButtonType`): button visual type.
  Available: `primary`, `secondary`, `tertiary`, `ghost`.
- `size` (`DlButtonSize`): button size. Available: `lg`, `md`, `sm`, `xs`.
- `state` (`DlButtonState`): visual state override (`defaultState`, `pressed`, `disabled`).
- `iconLeft` (`Widget?`): optional leading icon.
- `iconRight` (`Widget?`): optional trailing icon.
- `fullWidth` (`bool`): stretches to available width when true.

## Variants

- Type: `primary`, `secondary`, `tertiary`, `ghost`
- Size: `lg`, `md`, `sm`, `xs`
- State: `defaultState`, `pressed`, `disabled`

## Example

```dart
DlButton(
  label: 'Button field',
  onPressed: () {},
)
```

## Accessibility

- Disabled state is non-interactive.
- Label text remains visible with state-dependent contrast colors.

## Test cases

- Renders label and uses expected default colors.
- Uses pressed colors when state is `pressed`.
- Uses disabled colors and blocks taps when disabled.
- Icons use the same color as the label.
- Applies expected size and spacing for `lg`.
