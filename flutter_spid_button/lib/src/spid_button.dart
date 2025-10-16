import 'package:flutter/material.dart';
import 'spid_idp_model.dart';
import 'spid_idp_service.dart';

/// Enum for SPID button sizes matching the original implementation
enum SpidButtonSize {
  small(fontSize: 10.0, width: 150.0, iconSize: 19.0),
  medium(fontSize: 15.0, width: 220.0, iconSize: 29.0),
  large(fontSize: 20.0, width: 280.0, iconSize: 38.0),
  xlarge(fontSize: 25.0, width: 340.0, iconSize: 47.0);

  final double fontSize;
  final double width;
  final double iconSize;

  const SpidButtonSize({
    required this.fontSize,
    required this.width,
    required this.iconSize,
  });
}

/// Main SPID button widget that replicates the official SPID SP Access Button
///
/// This widget provides a standardized authentication button for SPID
/// (Sistema Pubblico di Identità Digitale) with automatic IDP provider loading.
class SpidButton extends StatefulWidget {
  /// The size of the button
  final SpidButtonSize size;

  /// Callback when an IDP is selected
  final void Function(SpidIdp idp)? onIdpSelected;

  /// Whether to fetch IDPs from remote registry (default: true)
  final bool fetchRemote;

  /// Custom IDP list (used if fetchRemote is false or as fallback)
  final List<SpidIdp>? customIdps;

  /// Base URL for IDP logos (default uses local assets)
  final String? logoBaseUrl;

  const SpidButton({
    Key? key,
    this.size = SpidButtonSize.medium,
    this.onIdpSelected,
    this.fetchRemote = true,
    this.customIdps,
    this.logoBaseUrl,
  }) : super(key: key);

  @override
  State<SpidButton> createState() => _SpidButtonState();
}

class _SpidButtonState extends State<SpidButton> {
  final GlobalKey _buttonKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  List<SpidIdp>? _idps;

  @override
  void initState() {
    super.initState();
    _loadIdps();
  }

  Future<void> _loadIdps() async {
    if (!widget.fetchRemote && widget.customIdps != null) {
      setState(() {
        _idps = List.from(widget.customIdps!)..shuffle();
      });
      return;
    }

    try {
      final service = SpidIdpService();
      final idps = await service.fetchIdps();
      setState(() {
        _idps = idps..shuffle();
      });
    } catch (e) {
      setState(() {
        // Fallback to custom IDPs or default list
        _idps = widget.customIdps ?? SpidIdpService.defaultIdps;
        _idps?.shuffle();
      });
    }
  }

  void _toggleDropdown() {
    if (_overlayEntry != null) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    final renderBox = _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => _SpidDropdown(
        buttonOffset: offset,
        buttonSize: size,
        buttonWidth: widget.size.width,
        idps: _idps ?? [],
        onIdpSelected: (idp) {
          _removeOverlay();
          widget.onIdpSelected?.call(idp);
        },
        onDismiss: _removeOverlay,
        logoBaseUrl: widget.logoBaseUrl,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {});
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _buttonKey,
      onTap: _toggleDropdown,
      child: Container(
        width: widget.size.width,
        decoration: BoxDecoration(
          color: const Color(0xFF0066CC), // SPID blue
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            // Icon section
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.size.fontSize * 0.8,
                vertical: widget.size.fontSize * 0.6,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Color(0x1AFFFFFF), // rgba(255, 255, 255, 0.1)
                    width: 1,
                  ),
                ),
              ),
              child: Image.asset(
                'packages/flutter_spid_button/assets/images/spid-ico-circle-bb.png',
                width: widget.size.iconSize,
                height: widget.size.iconSize,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.account_circle,
                    size: widget.size.iconSize,
                    color: Colors.white,
                  );
                },
              ),
            ),
            // Text section
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: widget.size.fontSize * 0.85,
                  horizontal: widget.size.fontSize * 0.5,
                ),
                child: Text(
                  'Entra con SPID',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'TitilliumWeb',
                    fontSize: widget.size.fontSize * 1.15,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dropdown overlay widget that displays the IDP list
class _SpidDropdown extends StatelessWidget {
  final Offset buttonOffset;
  final Size buttonSize;
  final double buttonWidth;
  final List<SpidIdp> idps;
  final void Function(SpidIdp) onIdpSelected;
  final VoidCallback onDismiss;
  final String? logoBaseUrl;

  const _SpidDropdown({
    required this.buttonOffset,
    required this.buttonSize,
    required this.buttonWidth,
    required this.idps,
    required this.onIdpSelected,
    required this.onDismiss,
    this.logoBaseUrl,
  });

  double get _dropdownWidth {
    if (buttonWidth <= 220) return 230;
    if (buttonWidth <= 280) return 270;
    return 330;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Invisible barrier to detect outside taps
        Positioned.fill(
          child: GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
        ),
        // Dropdown menu
        Positioned(
          left: buttonOffset.dx,
          top: buttonOffset.dy + buttonSize.height + 8,
          child: Material(
            elevation: 5,
            shadowColor: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(0),
            child: Container(
              width: _dropdownWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFDDDDDD)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // IDP list
                  ...idps.map((idp) => _buildIdpItem(idp)),
                  // Info links
                  _buildInfoLink(
                    'Maggiori informazioni',
                    'https://www.spid.gov.it',
                  ),
                  _buildInfoLink(
                    'Non hai SPID?',
                    'https://www.spid.gov.it/richiedi-spid',
                  ),
                  _buildInfoLink(
                    'Serve aiuto?',
                    'https://www.spid.gov.it/serve-aiuto',
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Triangle tip
        Positioned(
          left: buttonOffset.dx + 9,
          top: buttonOffset.dy + buttonSize.height + 2,
          child: CustomPaint(
            size: const Size(14, 7),
            painter: _TrianglePainter(),
          ),
        ),
      ],
    );
  }

  Widget _buildIdpItem(SpidIdp idp) {
    // Determine if logo is local asset or remote URL
    final bool isLocalAsset = idp.logoUri.startsWith('packages/');

    return InkWell(
      onTap: () => onIdpSelected(idp),
      hoverColor: const Color(0xFFF0F0F0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFCCCCCC), width: 1),
          ),
        ),
        child: _buildLogoWidget(idp, isLocalAsset),
      ),
    );
  }

  Widget _buildLogoWidget(SpidIdp idp, bool isLocalAsset) {
    final errorWidget = Text(
      idp.organizationName,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF0066CC),
      ),
    );

    if (isLocalAsset) {
      return Image.asset(
        idp.logoUri,
        height: 25,
        fit: BoxFit.fitHeight,
        alignment: Alignment.centerLeft,
        errorBuilder: (context, error, stackTrace) => errorWidget,
      );
    } else {
      // Remote URL
      final url = logoBaseUrl != null ? '$logoBaseUrl/${idp.logoUri}' : idp.logoUri;
      return Image.network(
        url,
        height: 25,
        fit: BoxFit.fitHeight,
        alignment: Alignment.centerLeft,
        errorBuilder: (context, error, stackTrace) => errorWidget,
      );
    }
  }

  Widget _buildInfoLink(String text, String url, {bool isLast = false}) {
    return InkWell(
      onTap: () {
        // In a real app, launch URL
        debugPrint('Navigate to: $url');
        onDismiss();
      },
      hoverColor: const Color(0xFFF0F0F0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : const BorderSide(color: Color(0xFFDDDDDD), width: 1),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'TitilliumWeb',
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Color(0xFF0066CC),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

/// Custom painter for the dropdown triangle tip
class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDDDDDD)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);

    // Inner white triangle
    final paintWhite = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final pathWhite = Path()
      ..moveTo(size.width / 2, 1)
      ..lineTo(1, size.height)
      ..lineTo(size.width - 1, size.height)
      ..close();

    canvas.drawPath(pathWhite, paintWhite);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
