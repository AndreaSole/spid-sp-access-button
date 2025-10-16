import 'dart:convert';
import 'package:http/http.dart' as http;
import 'spid_idp_model.dart';

/// Service class for fetching SPID IDP data from AgID registry
class SpidIdpService {
  /// Official AgID SPID registry URL
  static const String defaultRegistryUrl =
      'https://registry.spid.gov.it/entities-idp?&output=json&custom=info_display_base';

  /// Default fallback IDP list (matching the original JavaScript implementation)
  /// Uses local PNG assets for logos (better compatibility than SVG)
  static final List<SpidIdp> defaultIdps = [
    const SpidIdp(
      organizationName: 'ArubaPEC S.p.A.',
      entityId: 'https://loginspid.aruba.it',
      logoUri: 'packages/flutter_spid_button/assets/images/spid-idp-arubaid.png',
    ),
    const SpidIdp(
      organizationName: 'InfoCert S.p.A.',
      entityId: 'https://identity.infocert.it',
      logoUri: 'packages/flutter_spid_button/assets/images/spid-idp-infocertid.png',
    ),
    const SpidIdp(
      organizationName: 'IN.TE.S.A. S.p.A.',
      entityId: 'https://spid.intesa.it',
      logoUri: 'packages/flutter_spid_button/assets/images/spid-idp-intesaid.png',
    ),
    const SpidIdp(
      organizationName: 'Lepida S.p.A.',
      entityId: 'https://id.lepida.it/idp/shibboleth',
      logoUri: 'packages/flutter_spid_button/assets/images/spid-idp-lepidaid.png',
    ),
    const SpidIdp(
      organizationName: 'Namirial',
      entityId: 'https://idp.namirialtsp.com/idp',
      logoUri: 'packages/flutter_spid_button/assets/images/spid-idp-namirialid.png',
    ),
    const SpidIdp(
      organizationName: 'Poste Italiane SpA',
      entityId: 'https://posteid.poste.it',
      logoUri: 'packages/flutter_spid_button/assets/images/spid-idp-posteid.png',
    ),
    const SpidIdp(
      organizationName: 'Sielte S.p.A.',
      entityId: 'https://identity.sieltecloud.it',
      logoUri: 'packages/flutter_spid_button/assets/images/spid-idp-sielteid.png',
    ),
    const SpidIdp(
      organizationName: 'Register.it S.p.A.',
      entityId: 'https://spid.register.it',
      logoUri: 'packages/flutter_spid_button/assets/images/spid-idp-spiditalia.png',
    ),
    const SpidIdp(
      organizationName: 'TI Trust Technologies srl',
      entityId: 'https://login.id.tim.it/affwebservices/public/saml2sso',
      logoUri: 'packages/flutter_spid_button/assets/images/spid-idp-timid.png',
    ),
    const SpidIdp(
      organizationName: 'TeamSystem s.p.a.',
      entityId: 'https://spid.teamsystem.com/idp',
      logoUri: 'packages/flutter_spid_button/assets/images/spid-idp-teamsystemid.png',
    ),
  ];

  final String registryUrl;
  final Duration timeout;

  SpidIdpService({
    this.registryUrl = defaultRegistryUrl,
    this.timeout = const Duration(seconds: 10),
  });

  /// Fetches the list of SPID IDPs from the AgID registry
  ///
  /// Returns a list of [SpidIdp] objects. If the fetch fails,
  /// throws an exception that should be caught by the caller
  /// to use the fallback list.
  Future<List<SpidIdp>> fetchIdps() async {
    try {
      final response = await http
          .get(Uri.parse(registryUrl))
          .timeout(timeout);

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to load IDPs: HTTP ${response.statusCode}',
        );
      }

      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((json) => SpidIdp.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching IDPs: $e');
    }
  }

  /// Fetches IDPs with automatic fallback to default list
  ///
  /// This method never throws exceptions. If the remote fetch fails,
  /// it returns the default IDP list.
  Future<List<SpidIdp>> fetchIdpsWithFallback() async {
    try {
      return await fetchIdps();
    } catch (e) {
      // Return default list on any error
      return defaultIdps;
    }
  }
}
