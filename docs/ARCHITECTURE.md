# Architecture

## Purpose

This repository is a Flutter UI component library package. It is not a product app.

## Separation of concerns

- `lib/src/**`: internal implementation of components, themes, and foundations.
- `example/**`: standalone demo/preview app for showcasing and testing components visually.

No feature screens or product flows belong in the package itself.

## API rules

1. Public API is exported only via `lib/dynamiclayer_flutter.dart`.
2. Everything under `lib/src/**` is internal and can evolve without direct consumer guarantees.
3. Component naming follows the `Dl` prefix convention:
   - `DlButton`
   - `DlTextField`
   - `DlCard`
4. Components must not contain business logic, backend calls, or app-specific workflows.
5. Components must be theme-friendly and must not depend on hard app-specific dependencies.

## Package layout

- `lib/dynamiclayer_flutter.dart`: public exports only.
- `lib/src/components/`: reusable UI widgets.
- `lib/src/theme/`: shared theme primitives (colors, typography, spacing, ThemeData adapters).
- `lib/src/foundations/`: design tokens and constants.
- `test/`: widget tests and behavior verification.
- `docs/`: architecture, roadmap, and component docs.
- `example/`: demo app.
