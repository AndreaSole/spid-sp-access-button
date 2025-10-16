import 'package:flutter/material.dart';
import 'package:flutter_spid_button/flutter_spid_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPID Button Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SpidButtonDemo(),
    );
  }
}

class SpidButtonDemo extends StatefulWidget {
  const SpidButtonDemo({Key? key}) : super(key: key);

  @override
  State<SpidButtonDemo> createState() => _SpidButtonDemoState();
}

class _SpidButtonDemoState extends State<SpidButtonDemo> {
  SpidIdp? _selectedIdp;

  void _handleIdpSelection(SpidIdp idp) {
    setState(() {
      _selectedIdp = idp;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: ${idp.organizationName}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SPID Button Demo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SPID SP ACCESS BUTTON - Flutter Demo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'TitilliumWeb',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Size demonstrations
            _buildSection(
              'Small Button',
              'Button size S (150x27px equivalent)',
              SpidButton(
                size: SpidButtonSize.small,
                onIdpSelected: _handleIdpSelection,
              ),
            ),
            const SizedBox(height: 30),

            _buildSection(
              'Medium Button',
              'Button size M (220x40px equivalent)',
              SpidButton(
                size: SpidButtonSize.medium,
                onIdpSelected: _handleIdpSelection,
              ),
            ),
            const SizedBox(height: 30),

            _buildSection(
              'Large Button',
              'Button size L (280x53px equivalent)',
              SpidButton(
                size: SpidButtonSize.large,
                onIdpSelected: _handleIdpSelection,
              ),
            ),
            const SizedBox(height: 30),

            _buildSection(
              'Extra Large Button',
              'Button size XL (340x66px equivalent)',
              SpidButton(
                size: SpidButtonSize.xlarge,
                onIdpSelected: _handleIdpSelection,
              ),
            ),
            const SizedBox(height: 40),

            // Selected IDP display
            if (_selectedIdp != null) ...[
              const Divider(),
              const SizedBox(height: 20),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selected Identity Provider',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Organization: ${_selectedIdp!.organizationName}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Entity ID: ${_selectedIdp!.entityId}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Logo URI: ${_selectedIdp!.logoUri}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 40),

            // Information section
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About SPID Button',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'This Flutter widget replicates the official SPID '
                      '(Sistema Pubblico di Identità Digitale) Service Provider '
                      'Access Button from AGID.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Features:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Multiple button sizes (S, M, L, XL)\n'
                      '• Automatic IDP fetching from AgID registry\n'
                      '• Randomized IDP list for fair visibility\n'
                      '• SPID compliant styling\n'
                      '• Fallback to default IDP list if fetch fails',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String description, Widget button) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'TitilliumWeb',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        button,
      ],
    );
  }
}
