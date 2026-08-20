# dynamic_layer_core

`dynamic_layer_core` is a reusable Flutter UI components package.

**Mission:** "Dieses Repo ist eine Flutter UI-Komponentenbibliothek, keine Produkt-App."

The GitHub repository is `dynamiclayer-flutter`, while the Dart/Flutter package name stays `dynamic_layer_core`.

## What Dynamic Layer is

Dynamic Layer starts as a Figma template system:

- Agencies receive a full copy of the Dynamic Layer Figma file.
- The copy includes components, styles, and variables.
- Teams adapt that copy per client project (for example border radius, colors, fonts, component shape).
- The goal is to avoid rebuilding the same base components from scratch on every new project.

`dynamic_layer_core` is the matching Flutter code template for the same idea.
It provides reusable UI components as a starting point, and each project can adjust those components to match its adapted Figma system.

## Intended workflow (Design to Code)

1. An agency starts a new client app project.
2. The designer uses the Dynamic Layer Figma template as the foundation.
3. The designer adapts components to the client's visual system (for example rounded buttons and custom typography).
4. The designer builds screens in Figma using those adapted components.
5. The developer starts from `dynamic_layer_core` as the Flutter base.
6. The developer adapts the library's components to match the final Figma decisions.
7. The developer builds product screens using the adjusted components.

This means the library is intentionally a project-ready starter layer, not a locked UI kit.

## Repository goal

- Provide reusable, themeable UI components for Flutter.
- Keep product and business logic out of this package.
- Expose a stable public package API for consumers.
- Use `example/` as a separate demo/preview app for components.

## Public API contract

Only import from:

```dart
import 'package:dynamic_layer_core/dynamic_layer_core.dart';
```

Package internals under `lib/src/**` are not part of the public API and may change.

## Usage

### Local path dependency

```yaml
dependencies:
  dynamic_layer_core:
    path: ../dynamic_layer_core
```

### Git dependency

```yaml
dependencies:
  dynamic_layer_core:
    git:
      url: https://github.com/<your-org>/dynamiclayer-flutter.git
      ref: main
```

Then run:

```bash
flutter pub get
```

## Demo app

Use the separate demo app in `example/` to preview components and variants during development.

## Quickstart

From the repository root:

```bash
flutter pub get
flutter analyze
flutter test
```

To run the demo app:

```bash
cd example
flutter pub get
flutter run
```

## Documentation

- Architecture: `docs/ARCHITECTURE.md`
- Roadmap: `docs/ROADMAP.md`
- Component docs template: `docs/components/README.md`

## Third-party assets and licenses

This project may include third-party icon assets (for example Lucide).
Attribution and license details are documented in:

- `THIRD_PARTY_LICENSES.md`
- `licenses/LUCIDE-ISC.txt`
