import 'package:flutter/material.dart';

import '../widgets/app_bottom_nav.dart';
import '../utils/navigation.dart';

class HospitalRecommendationScreen extends StatelessWidget {
  const HospitalRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Recommended Hospital',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF0FF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.map_outlined,
                        size: 52,
                        color: Colors.deepPurple.shade400,
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Current Location',
                          style: TextStyle(
                            color: Color(0xFF5E36F5),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                          color: Color(0xFF5E36F5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.near_me_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Best Match for you',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E2547),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9F3FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'NEAREST TRAUMA SPECIALIZED',
                            style: TextStyle(
                              color: Color(0xFF5E36F5),
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'TOP RATED',
                          style: TextStyle(
                            color: Color(0xFF7A57FF),
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'City General Hospital',
                      style: TextStyle(
                        fontSize: 30,
                        height: 0.95,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1B2347),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Level 1 Trauma Center',
                      style: TextStyle(
                        color: Color(0xFF6A49F2),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Icon(Icons.place_outlined, size: 16),
                        SizedBox(width: 4),
                        Text('2.4 miles'),
                        SizedBox(width: 14),
                        Icon(Icons.access_time_rounded, size: 16),
                        SizedBox(width: 4),
                        Text('24/7 ER'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.navigation_rounded),
                            label: const Text('Navigate Now'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5E36F5),
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(46),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F2F7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.call_rounded),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Other Nearby Facilities',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              const _FacilityTile(
                title: 'Mercy Health Center',
                subtitle: 'Level 2 Trauma Care',
                distance: '3.6 miles away',
                eta: '12 min',
              ),
              const SizedBox(height: 10),
              const _FacilityTile(
                title: 'Valley Children\'s',
                subtitle: 'Pediatric Specialists',
                distance: '5.1 miles away',
                eta: '15 min',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: 2, // or another index if you want a new tab
        onDestinationSelected: (index) => navigateFromBottomTab(
          context,
          currentIndex: 2, // or the correct index
          targetIndex: index,
        ),
      ),
    );
  }
}

class _FacilityTile extends StatelessWidget {
  const _FacilityTile({
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.eta,
  });

  final String title;
  final String subtitle;
  final String distance;
  final String eta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF1F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.local_hospital_outlined),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Color(0xFF66708A)),
                ),
                Text(
                  distance,
                  style: const TextStyle(
                    color: Color(0xFF8A91A8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            eta,
            style: const TextStyle(
              color: Color(0xFF6A49F2),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
