import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/emergency_call_service.dart';
import '../services/emergency_contacts_repository.dart';
import '../services/location_service.dart';
import '../services/sms_service.dart';
import 'alert_sent_screen.dart';

class AccidentScreen extends StatefulWidget {
  const AccidentScreen({
    super.key,
    this.countdownSeconds = 10,
    this.manualTrigger = false,
  });

  final int countdownSeconds;
  final bool manualTrigger;

  @override
  State<AccidentScreen> createState() => _AccidentScreenState();
}

class _AccidentScreenState extends State<AccidentScreen> {
  final EmergencyCallService _emergencyCallService = EmergencyCallService();
  final EmergencyContactsRepository _contactsRepository =
      EmergencyContactsRepository();
  final LocationService _locationService = LocationService();
  final SmsService _smsService = SmsService();

  final AudioPlayer _audioPlayer = AudioPlayer();

  Timer? _timer;
  late int _secondsLeft;
  bool _isSending = false;
  String? _statusMessage;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.countdownSeconds;
    _startAlarmSound();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stopAlarmSound();
    super.dispose();
  }

  void _startAlarmSound() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('sounds/alarm.mp3'));
  }

  void _stopAlarmSound() async {
    await _audioPlayer.stop();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        _stopAlarmSound();
        _sendEmergencyAlert();
        return;
      }

      if (!mounted) {
        timer.cancel();
        _stopAlarmSound();
        return;
      }

      setState(() {
        _secondsLeft -= 1;
      });
    });
  }

  Future<void> _markSafe() async {
    _timer?.cancel();
    _stopAlarmSound();
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
  }

  Future<void> _sendEmergencyAlert() async {
    if (_isSending) {
      return;
    }

    setState(() {
      _isSending = true;
      _statusMessage = 'Preparing emergency alert...';
    });

    try {
      final contacts = await _contactsRepository.getContacts();
      if (contacts.isEmpty) {
        throw Exception(
          'No emergency contacts found. Add contacts in Profile.',
        );
      }

      if (kIsWeb) {
        // On web, skip permission and location checks, send message directly
        final locationLink = 'Location unavailable on web';
        setState(() {
          _statusMessage = 'Sending SMS alert...';
        });
        await _smsService.sendEmergencyAlert(
          contacts: contacts,
          locationLink: locationLink,
        );
        if (!mounted) {
          return;
        }
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (_) => AlertSentScreen(locationLink: locationLink),
          ),
        );
        return;
      }

      final hasPermissions = await _requestPermissions();
      if (!hasPermissions) {
        throw Exception('Required permissions are not granted.');
      }

      setState(() {
        _statusMessage = 'Fetching location...';
      });
      final position = await _locationService.getCurrentPosition();
      final locationLink = _locationService.buildMapsLink(position);

      setState(() {
        _statusMessage = 'Sending SMS alert...';
      });
      await _smsService.sendEmergencyAlert(
        contacts: contacts,
        locationLink: locationLink,
      );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => AlertSentScreen(locationLink: locationLink),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _statusMessage = error.toString().replaceFirst('Exception: ', '');
        _isSending = false;
      });
    }
  }

  Future<bool> _requestPermissions() async {
    // On web, do not use permission_handler for location; browser will prompt when using geolocator
    if (kIsWeb) {
      return true;
    }
    // On Android, request both location and SMS permissions
    if (defaultTargetPlatform == TargetPlatform.android) {
      final locationStatus = await Permission.locationWhenInUse.request();
      if (!locationStatus.isGranted) {
        return false;
      }
      final smsStatus = await Permission.sms.request();
      if (!smsStatus.isGranted) {
        return false;
      }
      return true;
    }
    // On iOS or other platforms, only request location permission
    final locationStatus = await Permission.locationWhenInUse.request();
    if (!locationStatus.isGranted) {
      return false;
    }
    return true;
  }

  Future<void> _callEmergencyServices() async {
    final didLaunch = await _emergencyCallService.launchEmergencyDialer();
    if (!mounted || didLaunch) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to open dialer on this device.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = _secondsLeft / widget.countdownSeconds;
    final bannerTitle = widget.manualTrigger
        ? 'EMERGENCY\nREQUESTED!'
        : 'ACCIDENT\nDETECTED!';
    final countdownText = widget.manualTrigger
        ? 'Sending emergency request in $_secondsLeft seconds...'
        : 'Sending alert in $_secondsLeft seconds...';
    final descriptionText = widget.manualTrigger
        ? 'Manual SOS has been triggered. Emergency services and contacts will be notified automatically if you do not cancel.'
        : 'We\'ve detected a strong impact. Emergency services will be notified automatically if you do not respond.';
    final safeButtonLabel = widget.manualTrigger ? 'CANCEL SOS' : 'I\'M SAFE';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: _markSafe,
        ),
        title: const Text(
          'SafeRide AI',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 36,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF2F2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFFF6E6E)),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            size: 38,
                            color: Color(0xFFE53935),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            bannerTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFFE53935),
                              fontSize: 32,
                              height: 0.95,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 230,
                      height: 230,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 220,
                            height: 220,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 9,
                              color: const Color(0xFFE53935),
                              backgroundColor: const Color(0xFFE8EBF4),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$_secondsLeft',
                                style: const TextStyle(
                                  fontSize: 62,
                                  height: 0.95,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF15203F),
                                ),
                              ),
                              const Text(
                                'SECONDS',
                                style: TextStyle(
                                  letterSpacing: 1.2,
                                  color: Color(0xFF7B8197),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _isSending ? 'Sending emergency alert...' : countdownText,
                      style: const TextStyle(
                        color: Color(0xFFE53935),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Are you safe?',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E2547),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      descriptionText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xFF69718A)),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: _isSending ? null : _markSafe,
                        icon: const Icon(Icons.check_circle_outline_rounded),
                        label: Text(safeButtonLabel),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF16C25F),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton.icon(
                      onPressed: _callEmergencyServices,
                      icon: const Icon(Icons.call_outlined),
                      label: const Text('Call Emergency Services Now'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),
                    if (_statusMessage != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _statusMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _isSending
                              ? const Color(0xFF56607A)
                              : const Color(0xFFD32F2F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
