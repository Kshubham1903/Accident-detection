import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../utils/navigation.dart';

class FirstAidGuideScreen extends StatefulWidget {
  const FirstAidGuideScreen({super.key});

  @override
  State<FirstAidGuideScreen> createState() => _FirstAidGuideScreenState();
}

class _FirstAidGuideScreenState extends State<FirstAidGuideScreen> {
  int _currentStep = 0;
  final FlutterTts _flutterTts = FlutterTts();

  final List<Map<String, String>> _steps = [
    {
      'title': 'Check Breathing',
      'description': 'Tilt head back, lift chin, and watch for chest movement. Listen for breath sounds.',
      'badge': 'IMMEDIATE ACTION',
      'badgeColor': '0xFFE53935',
      'icon': 'health_and_safety_outlined',
    },
    {
      'title': 'Stop Bleeding',
      'description': 'Apply firm, direct pressure with a clean cloth. Do not remove soaked fabric.',
      'badge': 'URGENT',
      'badgeColor': '0xFFB5A980',
      'icon': 'medication_liquid_outlined',
    },
    {
      'title': 'Keep Stable',
      'description': 'Keep them warm and still. Reassure the person until help arrives.',
      'badge': 'PRIMARY',
      'badgeColor': '0xFF6A49F2',
      'icon': 'hotel_class_outlined',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];
    final int totalSteps = _steps.length;
    final bool isLastStep = _currentStep == totalSteps - 1;

    IconData getStepIcon(String? iconName) {
      switch (iconName) {
        case 'health_and_safety_outlined':
          return Icons.health_and_safety_outlined;
        case 'medication_liquid_outlined':
          return Icons.medication_liquid_outlined;
        case 'hotel_class_outlined':
          return Icons.hotel_class_outlined;
        default:
          return Icons.health_and_safety_outlined;
      }
    }

    Color getBadgeColor(String? colorHex) {
      if (colorHex == null) return const Color(0xFFE53935);
      return Color(int.parse(colorHex));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'First Aid Guide',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: Icon(Icons.medical_services_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              step['title'] ?? '',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1D2547),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              step['description'] ?? '',
              style: const TextStyle(color: Color(0xFF64708B)),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Diagram: \\${step['title']}'),
                            content: SizedBox(
                              height: 180,
                              child: Center(
                                child: Icon(
                                  getStepIcon(step['icon']),
                                  size: 100,
                                  color: const Color(0xFF6A49F2),
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('View Diagram'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentStep == 0
                        ? null
                        : () {
                            setState(() {
                              if (_currentStep > 0) {
                                _currentStep--;
                              }
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB5A980),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Previous Step'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLastStep
                        ? null
                        : () {
                            setState(() {
                              if (_currentStep < totalSteps - 1) {
                                _currentStep++;
                              }
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A49F2),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(isLastStep ? 'Done' : 'Next Step'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0EDFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.local_hospital_outlined,
                    color: Color(0xFF6A49F2),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Ambulance is on the way\nETA 4 mins - Dispatch ID #C-76-AH92',
                      style: TextStyle(
                        color: Color(0xFF514B7B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MutedStepCard extends StatelessWidget {
  const _MutedStepCard({
    required this.title,
    required this.description,
    required this.badge,
  });

  final String title;
  final String description;
  final String badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            badge,
            style: const TextStyle(
              color: Color(0xFFB5A980),
              fontWeight: FontWeight.w800,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF3D476A),
            ),
          ),
          const SizedBox(height: 4),
          Text(description, style: const TextStyle(color: Color(0xFF8C94AA))),
        ],
      ),
    );
  }
}
