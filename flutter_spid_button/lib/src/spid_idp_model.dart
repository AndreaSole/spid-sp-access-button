/// Model class representing a SPID Identity Provider
class SpidIdp {
  /// The official organization name of the IDP
  final String organizationName;

  /// The entity ID (SAML metadata URL)
  final String entityId;

  /// URI to the IDP logo image
  final String logoUri;

  const SpidIdp({
    required this.organizationName,
    required this.entityId,
    required this.logoUri,
  });

  /// Creates a SpidIdp from JSON data
  factory SpidIdp.fromJson(Map<String, dynamic> json) {
    return SpidIdp(
      organizationName: json['organization_name'] as String? ?? '',
      entityId: json['entity_id'] as String? ?? '',
      logoUri: json['logo_uri'] as String? ?? '',
    );
  }

  /// Converts the SpidIdp to JSON
  Map<String, dynamic> toJson() {
    return {
      'organization_name': organizationName,
      'entity_id': entityId,
      'logo_uri': logoUri,
    };
  }

  @override
  String toString() {
    return 'SpidIdp(organizationName: $organizationName, entityId: $entityId, logoUri: $logoUri)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SpidIdp && other.entityId == entityId;
  }

  @override
  int get hashCode => entityId.hashCode;
}
