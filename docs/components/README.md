# Component Documentation Template

Use this template for each component documentation file, for example `docs/components/button.md`.

## 1) Purpose

- What problem does the component solve?
- When should developers use it?

## 2) API (Props)

Document all relevant constructor parameters and behavior:

- Required parameters
- Optional parameters
- Default values
- Callbacks/events

## 3) Variants

List supported variants and visual states, for example:

- Size variants (`small`, `medium`, `large`)
- Style variants (`primary`, `secondary`, `ghost`)
- States (`enabled`, `disabled`, `loading`, `error`)

## 4) Example code

Provide at least one minimal usage snippet:

```dart
DlButton(
  label: 'Continue',
  onPressed: () {},
)
```

## 5) Accessibility notes

Describe accessibility behavior and requirements:

- Semantic labels
- Focus behavior
- Tap target sizing
- Color contrast considerations

## 6) Test cases

List expected test coverage:

- Renders correctly with default props
- Handles callbacks/events
- Supports key variants/states
- Accessibility semantics are present where needed
