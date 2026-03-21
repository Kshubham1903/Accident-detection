import 'package:flutter/material.dart';

import '../widgets/app_bottom_nav.dart';
import '../utils/navigation.dart';

class NearbyAlertScreen extends StatelessWidget {
  const NearbyAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'SafeRide AI',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'emergency_share',
                style: TextStyle(
                  color: Color(0xFFE53935),
                  fontSize: 36,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Accident Nearby',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1F274B),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEFF1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Text(
                    'priority_high IMMEDIATE ASSISTANCE NEEDED',
                    style: TextStyle(
                      color: Color(0xFFE53935),
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Someone needs help near you',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF737A90)),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 190,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9EDFF),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.map_outlined,
                            size: 56,
                            color: Color(0xFF5E36F5),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6A49F2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Text(
                              'near_me 300m away',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Main St & 5th Ave, Central District',
                      style: TextStyle(
                        color: Color(0xFF64708A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.medical_services_outlined,
                      color: Color(0xFF6A49F2),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Medical Support Needed\nEstimated 2 minutes to assist',
                        style: TextStyle(
                          color: Color(0xFF2D355B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        backgroundColor: const Color(0xFF6A49F2),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'check_circle',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        backgroundColor: const Color(0xFF6A49F2),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Accept Help\nRequest',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(46),
                ),
                child: const Text('DECLINE REQUEST'),
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
