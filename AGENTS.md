# AGENTS

This file defines working rules for AI agents contributing to `dynamic_layer_core`.

## Scope

This repository is a Flutter UI components library package. It is not a feature/product app.
It mirrors the Dynamic Layer Figma template concept in code: teams start from this library, then adapt components per project/client design system before building final app screens.

## Product context (must stay true)

- Dynamic Layer for Figma is a template copy that agencies can fully customize per project.
- `dynamic_layer_core` is the equivalent Flutter template layer.
- Defaults in the base library (for example button radius) are starting values, not immutable product rules.
- Per-project customization of style tokens and component appearance is expected.
- The repository should stay reusable and generic so teams can adapt it quickly to different brands.

## Required project structure

- `lib/dynamic_layer_core.dart`: public exports only
- `lib/src/components/`: component implementations
- `lib/src/theme/`: theme primitives
- `lib/src/foundations/`: design tokens/constants
- `test/components/`: widget/component tests
- `docs/components/`: component documentation
- `example/`: demo app only

## Rules for all changes

1. Keep folder structure and naming conventions intact.
2. Use `Dl` prefix for components (for example `DlButton`, `DlTextField`, `DlCard`).
3. Public API must be exposed only via `lib/dynamic_layer_core.dart`.
4. Do not add business logic to UI components.
5. Components should be theme-capable and avoid app-specific dependencies.
6. Prefer configuration and theme/token-based customization over hard-coded styling.

## Component completeness requirements

Every new component must include:

1. Implementation in `lib/src/components/`
2. Tests in `test/components/`
3. Documentation in `docs/components/`
4. Example integration in `example/`

## Consistency between library and demo

- Do not change `example/` without a corresponding component/library change.
- Do not change components without updating `example/` where relevant.
- Keep example usage aligned with current public API.
