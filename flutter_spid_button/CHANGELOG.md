# Changelog

## [1.0.0] - 2025-10-15

### Added
- Initial release of Flutter SPID Button widget
- Support for all four button sizes (S, M, L, XL)
- Automatic IDP fetching from AgID registry (https://registry.spid.gov.it/entities-idp)
- Dropdown overlay with IDP selection
- Randomized IDP list display for fair visibility
- Fallback to default IDP list if remote fetch fails
- Custom IDP list support
- Customizable logo base URL
- Full SPID compliance (colors, fonts, styling)
- Titillium Web font integration
- Example app demonstrating all features
- Comprehensive documentation and README

### Features
- `SpidButton` widget with configurable sizes
- `SpidIdpService` for fetching IDP data
- `SpidIdp` model class
- Overlay-based dropdown implementation
- HTTP-based remote data fetching with timeout
- Error handling with automatic fallback
- Accessibility support with semantic labels

### Design
- Pixel-perfect replication of official SPID button styling
- SPID blue color scheme (#0066CC, #003366, #83BEED)
- Titillium Web font family (400, 600 weights)
- Responsive layout matching original dimensions
- Triangle tip on dropdown (matching original CSS)
- Border and shadow effects matching specification
