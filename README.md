# mcssym.dev

Editorial CV / open-source portfolio for **Maxime Fankam**, built with Flutter Web and [Flueco](https://github.com/flutter-ecosystem/flueco).

## Product direction

The visual system is inspired by an old broadsheet / technical journal rather than a conventional portfolio: warm paper, ink-like typography, hairline rules, editorial columns, a monochrome portrait, and a dark-paper counterpart.

Primary goal: **open-source visibility**.

## Architecture

The project deliberately follows the structure and philosophy used by the Flueco example app:

```text
lib/
├── application/
├── bootstrap/
│   ├── providers/
│   └── kernel.dart
├── data/
│   ├── repositories/
│   └── sources/remote/
├── domain/
│   ├── contracts/
│   ├── entities/
│   └── use_cases/
├── foundation/
│   ├── config/
│   └── content/
├── presentation/
│   └── ui/
│       ├── components/
│       ├── screens/pages/home/
│       └── theming/
└── main.dart
```

Flueco is responsible for bootstrapping, dependency injection and the HTTP abstraction. Presentation follows the Flueco `View / ViewModel / ViewState` approach through `flueco_state_management`.

## Feeds

- **GitHub**: loaded at runtime from the public GitHub REST API through Flueco's `HttpClient`.
- **Medium**: loaded from the public Medium RSS feed through a configurable RSS-to-JSON endpoint (`rss2json.com` by default), still consumed behind the app's data/domain abstractions.
- Feed errors are non-blocking: the CV itself remains fully usable.

The Medium proxy is isolated in `AppConfig`, so it can later be replaced by a Cloudflare Worker, serverless endpoint or your own domain without changing the domain or presentation layers.

## Local run

```bash
flutter pub get
flutter run -d chrome
```

## GitHub Pages

A Pages workflow is included at `.github/workflows/deploy.yml`. For the repository name `mcssym.dev`, the current base href is `/mcssym.dev/`.

When a custom domain is chosen, change the build command to:

```bash
flutter build web --release --base-href "/"
```

and configure the domain in GitHub Pages.

## Content source

Career and education entries were initialized from the LinkedIn profile export supplied for the project. Richer role achievements can be added later without changing the site architecture.
