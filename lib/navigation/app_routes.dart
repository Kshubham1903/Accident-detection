import 'package:flutter/material.dart';

class AppRoutes {
  static const String dashboard = '/dashboard';
  static const String firstAidGuide = '/first-aid-guide';
  static const String nearbyAlert = '/nearby-alert';
  static const String profile = '/profile';
  static const String hospitalRecommendation = '/hospital-recommendation';
  static const String hospitals = '/hospitals';
  static const String activity = '/activity';

  static String? routeForTabIndex(int index) {
    switch (index) {
      case 0:
        return dashboard;
      case 1:
        return firstAidGuide;
      case 2:
        return hospitals;
      case 3:
        return activity;
      case 4:
        return profile;
      // Optionally add a case for hospitalRecommendation if you want a tab for it
      default:
        return null;
    }
  }
}

void navigateFromBottomTab(
  BuildContext context, {
  required int currentIndex,
  required int targetIndex,
}) {
  if (targetIndex == currentIndex) {
    return;
  }

  final route = AppRoutes.routeForTabIndex(targetIndex);
  if (route == null) {
    return;
  }

  Navigator.of(context).pushReplacementNamed(route);
}
