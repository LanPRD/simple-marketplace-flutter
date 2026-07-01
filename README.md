# Simple Marketplace — Flutter E-commerce App

A cross-platform e-commerce mobile app built with Flutter, featuring product browsing, cart management, order tracking, and secure authentication.

## Features

- **Authentication** — sign in, sign up, and forgot password flow with secure token storage
- **Home** — category browsing and product listing with shimmer loading states
- **Product details** — dedicated product screen with quantity controls
- **Cart** — add/remove items, quantity control, animated "add to cart" feedback, checkout/payment dialog
- **Orders** — order history and status tracking
- **Profile** — user account management

## Architecture

The project follows a **feature-first structure**, with each screen organized into clear layers:

```text
screens/
  <feature>/
    bindings/      # Dependency injection setup (GetX)
    controllers/   # Business logic and state
    repositories/  # Data fetching and API calls
    result/        # Sealed result types (success/error) via Freezed
    views/          # UI screens
    components/    # Feature-specific reusable widgets
```

This separation keeps UI, state, and data access independent — controllers don't know about HTTP details, and views don't know about business logic.

## Tech Stack

| Purpose | Package |
|---|---|
| State management & DI | [get](https://pub.dev/packages/get) (GetX) |
| HTTP client | [dio](https://pub.dev/packages/dio) |
| Immutable models | [freezed](https://pub.dev/packages/freezed) + [json_serializable](https://pub.dev/packages/json_serializable) |
| Secure token storage | [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) |
| Loading states | [shimmer](https://pub.dev/packages/shimmer) |
| UI feedback | [add_to_cart_animation](https://pub.dev/packages/add_to_cart_animation), [fluttertoast](https://pub.dev/packages/fluttertoast) |

## Key design decisions

- **Result types over exceptions**: repositories return `Result` objects (via Freezed unions) instead of throwing, making success/error handling explicit at the controller level.
- **Secure storage for auth tokens**: tokens are never kept in memory-only state or shared preferences — `flutter_secure_storage` keeps them in the platform keychain/keystore.
- **GetX bindings per feature**: each screen lazily injects its own controller and repository, keeping startup light and dependencies scoped to where they're used.

## Getting started

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## Screens

- Splash → Auth (Sign in / Sign up / Forgot password) → Home
- Home (categories + products) → Product detail → Cart
- Cart → Payment dialog → Order confirmation
- Orders (history) · Profile
