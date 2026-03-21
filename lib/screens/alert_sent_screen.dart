import 'package:flutter/material.dart';

import '../services/emergency_call_service.dart';
import '../utils/navigation.dart';
import '../widgets/app_bottom_nav.dart';
import 'hospital_recommendation_screen.dart';

class AlertSentScreen extends StatelessWidget {
  const AlertSentScreen({super.key, required this.locationLink});

  final String locationLink;

  Future<void> _callEmergencyServices(BuildContext context) async {
    final didLaunch = await EmergencyCallService().launchEmergencyDialer();
    if (!context.mounted || didLaunch) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to open dialer on this device.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SafeRide AI',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 62,
                      height: 62,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDCF7E7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Color(0xFF16A34A),
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Emergency Alert Sent',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E2547),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Help is on the way',
                      style: TextStyle(
                        color: Color(0xFF5B49E8),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Stay calm and keep your phone active. Your location has been shared with emergency services and trusted contacts.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF66708A)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CURRENT LOCATION',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF4F5D7A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F2FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.map_outlined,
                        size: 46,
                        color: Color(0xFF5E36F5),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      locationLink,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF4F5D7A),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _callEmergencyServices(context),
                icon: const Icon(Icons.call_rounded),
                label: const Text('Call Emergency Services'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(54),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const HospitalRecommendationScreen(),
                    ),
                  );
                },
                child: const Text('View Incident Details'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: 2,
        onDestinationSelected: (index) => navigateFromBottomTab(
          context,
          currentIndex: 2,
          targetIndex: index,
        ),
      ),
    );
  }
}
