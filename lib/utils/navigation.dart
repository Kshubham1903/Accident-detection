import 'package:flutter/material.dart';

/// Navigates to the correct screen based on the bottom tab index.
void navigateFromBottomTab(BuildContext context, {required int currentIndex, required int targetIndex}) {
  if (currentIndex == targetIndex) return;
  switch (targetIndex) {
    case 0:
      Navigator.pushNamed(context, '/dashboard');
      break;
    case 1:
      Navigator.pushNamed(context, '/first-aid-guide');
      break;
    case 2:
      // Hospitals is now a tab, not a route. Switch tab in MainNavigation instead.
      break;
    case 3:
      // Activity is now a tab, not a route. Switch tab in MainNavigation instead.
      break;
    case 4:
      Navigator.pushNamed(context, '/profile');
      break;
    default:
      break;
  }
}
