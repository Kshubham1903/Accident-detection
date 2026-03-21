import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../services/sensor_service.dart';
import 'accident_screen.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/custom_button.dart';
import '../widgets/status_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const double _accidentThreshold = 27;

  final SensorService _sensorService = SensorService();
  bool monitoringEnabled = false;
  bool _accidentFlowOpen = false;

  void _openAccidentScreen({required bool manualTrigger}) {
    if (!mounted || _accidentFlowOpen) {
      return;
    }

    _accidentFlowOpen = true;
    Navigator.of(context)
        .push(
          MaterialPageRoute<void>(
            builder: (_) => AccidentScreen(manualTrigger: manualTrigger),
          ),
        )
        .whenComplete(() {
          _accidentFlowOpen = false;
        });
  }

  void _setMonitoring(bool enabled) {
    setState(() {
      monitoringEnabled = enabled;
    });

    if (!enabled) {
      _sensorService.stopMonitoring();
      return;
    }

    _sensorService.startMonitoring(
      threshold: _accidentThreshold,
      onAccidentDetected: (force) {
        if (!mounted || !monitoringEnabled) {
          return;
        }
        _openAccidentScreen(manualTrigger: false);
      },
    );
  }

  @override
  void dispose() {
    _sensorService.stopMonitoring();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'SafeRide AI',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StatusCard(
                      title: monitoringEnabled
                          ? 'Monitoring Active'
                          : 'Monitoring Off',
                      subtitle: monitoringEnabled
                          ? 'Trip protection is enabled'
                          : 'Enable monitoring to detect impacts',
                      value: monitoringEnabled,
                      onChanged: _setMonitoring,
                    ),
                    const SizedBox(height: 28),
                    Container(
                      height: 180,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x12000000),
                            blurRadius: 28,
                            offset: Offset(0, 14),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.shield_outlined,
                        size: 62,
                        color: Color(0xFF9AA3B2),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Ready for your trip?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E2547),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Toggle accident detection to start AI-powered trip protection.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF7B8197)),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      label: 'Manual SOS',
                      color: const Color(0xFFF2E7EB),
                      textColor: const Color(0xFFD14D75),
                      icon: Icons.emergency_share_outlined,
                      onPressed: () => _openAccidentScreen(manualTrigger: true),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: 0,
        onDestinationSelected: (index) => navigateFromBottomTab(
          context,
          currentIndex: 0,
          targetIndex: index,
        ),
      ),
    );
  }
}
