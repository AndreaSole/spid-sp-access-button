# SPID Button Example App

This is an example Flutter application demonstrating the usage of the Flutter SPID Button widget.

## Features Demonstrated

- All four button sizes (Small, Medium, Large, XL)
- IDP selection callback handling
- Display of selected IDP information
- Real-time IDP list fetching from AgID registry

## Running the Example

1. Ensure you have Flutter installed and configured

2. Navigate to the example directory:
```bash
cd example
```

3. Get dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## What to Expect

The example app displays:

1. **Four SPID buttons** in different sizes (S, M, L, XL)
2. **Interactive dropdowns** showing all available SPID Identity Providers
3. **Selected IDP display** showing the organization name, entity ID, and logo URI
4. **Information section** explaining the SPID button features

## Testing

Try the following:

- Tap each button size to see the dropdown
- Select different IDPs to see the selection callback
- Notice the randomized order of IDPs in the dropdown
- Test on different screen sizes to verify responsiveness

## Notes

- The IDP list is fetched from `https://registry.spid.gov.it/entities-idp`
- If the remote fetch fails, the app falls back to a hardcoded default list
- The IDP order is randomized on each app start for fair visibility
