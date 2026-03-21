import 'dart:async';
import 'dart:math' as math;

import 'package:sensors_plus/sensors_plus.dart';

class SensorService {
  StreamSubscription<AccelerometerEvent>? _subscription;

  void startMonitoring({
    required double threshold,
    required void Function(double force) onAccidentDetected,
  }) {
    stopMonitoring();
    _subscription = accelerometerEventStream().listen((event) {
      final force = _calculateForce(event.x, event.y, event.z);
      if (force >= threshold) {
        onAccidentDetected(force);
      }
    });
  }

  void stopMonitoring() {
    _subscription?.cancel();
    _subscription = null;
  }

  double _calculateForce(double x, double y, double z) {
    return math.sqrt(x * x + y * y + z * z);
  }
}
