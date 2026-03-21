// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:smart/main.dart';
import 'package:smart/screens/alert_sent_screen.dart';

void main() {
  testWidgets('Dashboard renders key controls', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('SafeRide AI'), findsOneWidget);
    expect(find.text('Manual SOS'), findsOneWidget);
    expect(find.text('Monitoring Off'), findsOneWidget);
  });

  testWidgets('Manual SOS opens emergency confirmation flow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.ensureVisible(find.text('Manual SOS'));
    await tester.tap(find.text('Manual SOS'));
    await tester.pumpAndSettle();

    expect(find.textContaining('REQUESTED!'), findsOneWidget);
    expect(find.text('CANCEL SOS'), findsOneWidget);
  });

  testWidgets('Safety tab opens First Aid Guide screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Safety'));
    await tester.pumpAndSettle();

    expect(find.text('First Aid Guide'), findsOneWidget);
    expect(find.text('Start Voice Instructions'), findsOneWidget);
  });

  testWidgets('Activity tab opens Nearby Alert screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Activity'));
    await tester.pumpAndSettle();

    expect(find.text('Accident Nearby'), findsOneWidget);
    expect(find.textContaining('IMMEDIATE ASSISTANCE NEEDED'), findsOneWidget);
  });

  testWidgets('Alert sent screen opens hospital recommendation flow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AlertSentScreen(locationLink: 'https://maps.google.com/?q=1,1'),
      ),
    );

    await tester.ensureVisible(find.text('View Incident Details'));
    await tester.tap(find.text('View Incident Details'));
    await tester.pumpAndSettle();

    expect(find.text('Recommended Hospital'), findsOneWidget);
    expect(find.text('Best Match for you'), findsOneWidget);
  });
}
