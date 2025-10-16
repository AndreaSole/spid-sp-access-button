/// Flutter SPID Button - Official SPID authentication button widget
///
/// A Flutter implementation of the official SPID (Sistema Pubblico di Identità Digitale)
/// Service Provider Access Button from AGID.
///
/// Features:
/// - Multiple button sizes (small, medium, large, xlarge)
/// - Automatic IDP provider fetching from AgID registry
/// - Dropdown with randomized IDP list
/// - SPID compliant styling with Titillium Web font
///
/// Example:
/// ```dart
/// SpidButton(
///   size: SpidButtonSize.medium,
///   onIdpSelected: (idp) {
///     print('Selected IDP: ${idp.organizationName}');
///     // Handle authentication flow
///   },
/// )
/// ```
library flutter_spid_button;

export 'src/spid_button.dart';
export 'src/spid_idp_model.dart';
export 'src/spid_idp_service.dart';
