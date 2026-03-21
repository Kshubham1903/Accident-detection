# SafeRide AI

Hackathon prototype for accident detection and emergency alerting using Flutter.

## Current Milestone

- Step 1 complete: project setup, package configuration, folder structure.
- Step 2 complete: dashboard UI scaffold added to match provided design direction.
- Step 3 complete: monitoring toggle now starts/stops accelerometer listener.
- Step 4 complete: high-force detection routes to accident confirmation screen.
- Step 5 complete: 10-second countdown with "I'm Safe" cancel action.
- Step 6 complete: location fetching and maps link generation added.
- Step 7 complete: SMS alert dispatch added with runtime permission checks.
- Step 8 complete: alert-sent confirmation screen with location preview.
- Step 9 complete: profile-managed emergency contacts with local persistence.
- Step 10 complete: Manual SOS now opens the same emergency countdown and alert flow.
- Step 11 complete: emergency call buttons now launch dialer (`tel:112`).
- Step 12 complete: First Aid Guide screen implemented and wired from Safety tab.
- Step 13 complete: Nearby Alert screen implemented and wired from Activity tab.
- Step 14 complete: Hospital Recommendation screen implemented and wired from Alert Sent flow.
- Next: align remaining tab routing/polish for final demo walkthrough.

## Implemented Structure

```text
lib/
  main.dart
  screens/
	dashboard_screen.dart
	accident_screen.dart
	alert_sent_screen.dart
	first_aid_guide_screen.dart
	nearby_alert_screen.dart
	hospital_recommendation_screen.dart
	profile_settings_screen.dart
  services/
	sensor_service.dart
	location_service.dart
	sms_service.dart
  widgets/
	custom_button.dart
	status_card.dart
```

## Dependencies

- `sensors_plus`
- `geolocator`
- `telephony`
- `permission_handler`
- `shared_preferences`
- `url_launcher`

## Run

```powershell
flutter pub get
flutter run
```

## Test

```powershell
flutter test
```
