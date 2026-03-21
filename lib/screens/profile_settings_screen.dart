import 'package:flutter/material.dart';

import '../services/emergency_contacts_repository.dart';
import '../utils/navigation.dart';
import '../widgets/app_bottom_nav.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final EmergencyContactsRepository _contactsRepository =
      EmergencyContactsRepository();
  final TextEditingController _phoneController = TextEditingController();

  List<String> _contacts = <String>[];
  bool _monitoringEnabled = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadContacts() async {
    final contacts = await _contactsRepository.getContacts();
    if (!mounted) {
      return;
    }
    setState(() {
      _contacts = contacts;
    });
  }

  Future<void> _addContact() async {
    final error = _contactsRepository.validatePhone(_phoneController.text);
    if (error != null) {
      setState(() {
        _errorText = error;
      });
      return;
    }

    await _contactsRepository.addContact(_phoneController.text);
    _phoneController.clear();
    setState(() {
      _errorText = null;
    });
    await _loadContacts();
  }

  Future<void> _removeContact(String contact) async {
    await _contactsRepository.removeContact(contact);
    await _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile & Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundColor: Color(0xFFE8E5FF),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF5E36F5),
                        size: 36,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Alex Johnson',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '+1 (555) 000-1234',
                      style: TextStyle(color: Color(0xFF5E36F5)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Safety Monitoring',
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Enable AI Monitoring'),
                  subtitle: const Text(
                    'Real-time trip tracking & anomaly detection',
                  ),
                  value: _monitoringEnabled,
                  onChanged: (value) {
                    setState(() {
                      _monitoringEnabled = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Emergency Contacts',
                trailing: TextButton(
                  onPressed: _addContact,
                  child: const Text('Add New'),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                        prefixIcon: const Icon(Icons.phone_outlined),
                        errorText: _errorText,
                        border: const OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _addContact(),
                    ),
                    const SizedBox(height: 10),
                    if (_contacts.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'No emergency contacts yet.',
                          style: TextStyle(color: Color(0xFF6E7893)),
                        ),
                      ),
                    for (final contact in _contacts)
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFEDEBFF),
                          child: Icon(
                            Icons.person,
                            color: Color(0xFF5E36F5),
                            size: 18,
                          ),
                        ),
                        title: Text(contact),
                        trailing: IconButton(
                          onPressed: () => _removeContact(contact),
                          icon: const Icon(Icons.delete_outline_rounded),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: 3,
        onDestinationSelected: (index) => navigateFromBottomTab(
          context,
          currentIndex: 3,
          targetIndex: index,
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child, this.trailing});

  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          child,
        ],
      ),
    );
  }
}
