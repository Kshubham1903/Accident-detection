import 'package:flutter/material.dart';

import 'navigation/app_routes.dart';
import 'screens/dashboard_screen.dart';
import 'screens/first_aid_guide_screen.dart';
import 'screens/nearby_alert_screen.dart';
import 'screens/profile_settings_screen.dart';
import 'screens/hospital_recommendation_screen.dart';
import 'main_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeRide AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5E36F5)),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.dashboard,
      routes: {
        AppRoutes.dashboard: (_) => const MainNavigation(),
        AppRoutes.firstAidGuide: (_) => const FirstAidGuideScreen(),
        AppRoutes.nearbyAlert: (_) => const NearbyAlertScreen(),
        AppRoutes.profile: (_) => const ProfileSettingsScreen(),
        AppRoutes.hospitalRecommendation: (_) => const HospitalRecommendationScreen(),
      },
    );
  }
}
