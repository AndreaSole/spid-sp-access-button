# Flutter SPID Button

A Flutter implementation of the official SPID (Sistema Pubblico di Identità Digitale) Service Provider Access Button from AGID.

## Features

- ✅ Multiple button sizes (S, M, L, XL)
- ✅ Automatic IDP provider fetching from AgID registry
- ✅ Dropdown with randomized IDP list for fair visibility
- ✅ SPID compliant styling with Titillium Web font
- ✅ Fallback to default IDP list if remote fetch fails
- ✅ Customizable logo base URL
- ✅ Full accessibility support

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_spid_button: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Setup

### 1. Copy Assets

Copy the SPID logo and font files from the original repository:

```bash
# Copy SPID icon
cp src/production/img/spid-ico-circle-bb.png flutter_spid_button/assets/images/
cp src/production/img/spid-ico-circle-bb.svg flutter_spid_button/assets/images/

# Copy Titillium Web fonts
cp src/production/fonts/* flutter_spid_button/assets/fonts/
```

### 2. Update pubspec.yaml

The package's `pubspec.yaml` already includes the necessary font and asset configurations.

## Usage

### Basic Usage

```dart
import 'package:flutter_spid_button/flutter_spid_button.dart';

SpidButton(
  size: SpidButtonSize.medium,
  onIdpSelected: (idp) {
    print('Selected IDP: ${idp.organizationName}');
    print('Entity ID: ${idp.entityId}');

    // Navigate to SPID authentication flow
    // Implement your SAML authentication here
  },
)
```

### All Button Sizes

```dart
// Small button (150x27px equivalent)
SpidButton(
  size: SpidButtonSize.small,
  onIdpSelected: _handleIdpSelection,
)

// Medium button (220x40px equivalent) - Default
SpidButton(
  size: SpidButtonSize.medium,
  onIdpSelected: _handleIdpSelection,
)

// Large button (280x53px equivalent)
SpidButton(
  size: SpidButtonSize.large,
  onIdpSelected: _handleIdpSelection,
)

// Extra Large button (340x66px equivalent)
SpidButton(
  size: SpidButtonSize.xlarge,
  onIdpSelected: _handleIdpSelection,
)
```

### Custom IDP List

```dart
SpidButton(
  size: SpidButtonSize.medium,
  fetchRemote: false,
  customIdps: [
    SpidIdp(
      organizationName: 'Custom IDP',
      entityId: 'https://example.com/idp',
      logoUri: 'https://example.com/logo.svg',
    ),
  ],
  onIdpSelected: _handleIdpSelection,
)
```

### Custom Logo Base URL

```dart
SpidButton(
  size: SpidButtonSize.medium,
  logoBaseUrl: 'https://your-cdn.com/spid-logos',
  onIdpSelected: _handleIdpSelection,
)
```

## Architecture

### Components

1. **SpidButton**: Main widget that displays the "Entra con SPID" button
2. **SpidIdpService**: Service class that fetches IDP data from AgID registry
3. **SpidIdp**: Model class representing an Identity Provider
4. **_SpidDropdown**: Overlay widget that displays the IDP selection menu

### Data Flow

1. On init, `SpidButton` calls `SpidIdpService.fetchIdps()`
2. Service fetches from `https://registry.spid.gov.it/entities-idp`
3. IDP list is shuffled for random display order
4. On button tap, dropdown overlay is shown
5. User selects an IDP
6. `onIdpSelected` callback is triggered with the selected `SpidIdp`

### Styling

The widget replicates the exact styling from the original implementation:

- Primary color: `#0066CC` (SPID blue)
- Hover color: `#003366`
- Active color: `#83BEED`
- Font: Titillium Web (weights: 400, 600, 700)
- Sizes match the original pixel-perfect dimensions

## Compliance

This implementation follows the official SPID guidelines:

- Uses official SPID logo and colors
- Displays all accredited IDPs in random order
- Implements proper accessibility (semantic labels)
- Uses Titillium Web font as required
- Mobile-first responsive design

## Example App

See the `example` directory for a complete demo application showing all button sizes and configurations.

```bash
cd example
flutter run
```

## API Reference

### SpidButton

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `size` | `SpidButtonSize` | `medium` | Button size (small, medium, large, xlarge) |
| `onIdpSelected` | `Function(SpidIdp)?` | `null` | Callback when IDP is selected |
| `fetchRemote` | `bool` | `true` | Whether to fetch IDPs from remote registry |
| `customIdps` | `List<SpidIdp>?` | `null` | Custom IDP list (fallback or override) |
| `logoBaseUrl` | `String?` | `null` | Base URL for IDP logos |

### SpidIdp

| Property | Type | Description |
|----------|------|-------------|
| `organizationName` | `String` | Official organization name of the IDP |
| `entityId` | `String` | Entity ID (SAML metadata URL) |
| `logoUri` | `String` | URI to the IDP logo image |

## License

This package is released under the same license as the original SPID SP Access Button project.

See [LICENSE.md](../LICENSE.md) for details.

## Credits

Flutter implementation based on the official SPID SP Access Button by AGID:
https://github.com/italia/spid-sp-access-button
