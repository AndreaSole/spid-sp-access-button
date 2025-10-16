# Installation Guide

## Step 1: Copy Assets

### SPID Icon
The SPID icon has already been copied to the Flutter package:
```bash
✓ flutter_spid_button/assets/images/spid-ico-circle-bb.png
✓ flutter_spid_button/assets/images/spid-ico-circle-bb.svg
```

### Titillium Web Fonts

You need to download and add the Titillium Web font files to your Flutter app.

**Option 1: Download from Google Fonts**

1. Visit [Google Fonts - Titillium Web](https://fonts.google.com/specimen/Titillium+Web)
2. Download the font family
3. Extract and copy these files to `flutter_spid_button/assets/fonts/`:
   - `TitilliumWeb-Regular.ttf` (weight 400)
   - `TitilliumWeb-SemiBold.ttf` (weight 600)
   - `TitilliumWeb-Bold.ttf` (weight 700)

**Option 2: Use from this repository**

If the fonts are available in `src/production/fonts/`, copy them:
```bash
cp src/production/fonts/TitilliumWeb-Regular.ttf flutter_spid_button/assets/fonts/
cp src/production/fonts/TitilliumWeb-SemiBold.ttf flutter_spid_button/assets/fonts/
cp src/production/fonts/TitilliumWeb-Bold.ttf flutter_spid_button/assets/fonts/
```

## Step 2: Install Dependencies

Navigate to the Flutter package directory:
```bash
cd flutter_spid_button
flutter pub get
```

## Step 3: Run the Example

```bash
cd example
flutter pub get
flutter run
```

## Step 4: Use in Your App

Add the package to your Flutter app's `pubspec.yaml`:

```yaml
dependencies:
  flutter_spid_button:
    path: ../flutter_spid_button  # or publish to pub.dev
```

Then import and use:

```dart
import 'package:flutter_spid_button/flutter_spid_button.dart';

SpidButton(
  size: SpidButtonSize.medium,
  onIdpSelected: (idp) {
    print('Selected: ${idp.organizationName}');
  },
)
```

## Troubleshooting

### Fonts not appearing
- Ensure the font files are in `flutter_spid_button/assets/fonts/`
- Check that `pubspec.yaml` correctly references the fonts
- Run `flutter clean && flutter pub get`

### Icon not showing
- Verify `spid-ico-circle-bb.png` is in `flutter_spid_button/assets/images/`
- The package will show a fallback icon if the image is missing

### IDP list not loading
- Check internet connectivity
- The app will automatically fall back to a default IDP list if the remote fetch fails
- Check console for error messages

## Directory Structure

After setup, your structure should look like:

```
flutter_spid_button/
├── assets/
│   ├── fonts/
│   │   ├── TitilliumWeb-Regular.ttf
│   │   ├── TitilliumWeb-SemiBold.ttf
│   │   └── TitilliumWeb-Bold.ttf
│   └── images/
│       ├── spid-ico-circle-bb.png
│       └── spid-ico-circle-bb.svg
├── lib/
│   ├── src/
│   │   ├── spid_button.dart
│   │   ├── spid_idp_model.dart
│   │   └── spid_idp_service.dart
│   └── flutter_spid_button.dart
├── example/
│   └── lib/
│       └── main.dart
├── pubspec.yaml
└── README.md
```
