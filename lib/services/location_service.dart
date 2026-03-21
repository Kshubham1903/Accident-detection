import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

class LocationService {
  Future<Position> getCurrentPosition() async {
    if (kIsWeb) {
      // On web, just call getCurrentPosition and let browser handle permissions
      try {
        return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      } catch (e) {
        throw Exception('Location unavailable on web.');
      }
    }
    // On mobile, check service and permissions
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location service is disabled.');
    }
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission is denied.');
    }
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  String buildMapsLink(Position position) {
    return 'https://maps.google.com/?q=${position.latitude},${position.longitude}';
  }
}
