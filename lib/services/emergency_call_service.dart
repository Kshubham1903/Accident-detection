import 'package:url_launcher/url_launcher.dart';

class EmergencyCallService {
  static const String defaultEmergencyNumber = '112';

  Future<bool> launchEmergencyDialer({
    String phoneNumber = defaultEmergencyNumber,
  }) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);

    if (!await canLaunchUrl(uri)) {
      return false;
    }

    return launchUrl(uri);
  }
}
