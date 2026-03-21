import 'package:telephony/telephony.dart';

class SmsService {
  final Telephony _telephony = Telephony.instance;

  Future<void> sendEmergencyAlert({
    required List<String> contacts,
    required String locationLink,
  }) async {
    final message =
        'Accident Detected!\nLocation: $locationLink\nPlease send help immediately.';

    for (final contact in contacts) {
      await _telephony.sendSms(to: contact, message: message);
    }
  }
}
