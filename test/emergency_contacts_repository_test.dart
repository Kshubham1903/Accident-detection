import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart/services/emergency_contacts_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late EmergencyContactsRepository repository;

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    repository = EmergencyContactsRepository();
  });

  test('adds and reads unique contacts', () async {
    await repository.addContact('+91 9876543210');
    await repository.addContact('9876543210');

    final contacts = await repository.getContacts();
    expect(contacts.length, 1);
    expect(contacts.first, '+919876543210');
  });

  test('removes contact', () async {
    await repository.saveContacts(<String>['9999999999']);

    await repository.removeContact('9999999999');

    final contacts = await repository.getContacts();
    expect(contacts, isEmpty);
  });

  test('validates phone number', () {
    expect(repository.validatePhone('12345'), isNotNull);
    expect(repository.validatePhone('+919999888877'), isNull);
  });
}
