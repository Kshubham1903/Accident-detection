import 'package:shared_preferences/shared_preferences.dart';

class EmergencyContactsRepository {
  static const String _storageKey = 'emergency_contacts';

  Future<List<String>> getContacts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_storageKey) ?? <String>[];
  }

  Future<void> saveContacts(List<String> contacts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_storageKey, contacts);
  }

  Future<void> addContact(String contact) async {
    final cleaned = _normalize(contact);
    if (cleaned == null) {
      return;
    }

    final contacts = await getContacts();
    final incomingKey = _dedupeKey(cleaned);
    final alreadyExists = contacts.any(
      (saved) => _dedupeKey(saved) == incomingKey,
    );
    if (alreadyExists) {
      return;
    }

    contacts.add(cleaned);
    await saveContacts(contacts);
  }

  Future<void> removeContact(String contact) async {
    final contacts = await getContacts();
    contacts.remove(contact);
    await saveContacts(contacts);
  }

  String? validatePhone(String value) {
    final cleaned = _normalize(value);
    if (cleaned == null) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? _normalize(String value) {
    final normalized = value.replaceAll(RegExp(r'[^0-9+]'), '');
    if (normalized.length < 10 || normalized.length > 15) {
      return null;
    }
    return normalized;
  }

  String _dedupeKey(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length <= 10) {
      return digitsOnly;
    }
    return digitsOnly.substring(digitsOnly.length - 10);
  }
}
