import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart'; 
import 'package:new_beginnings/screens/home_screen.dart';
import 'package:new_beginnings/screens/goal_screen.dart';
import 'package:new_beginnings/screens/log_screen.dart';
import 'package:new_beginnings/models/goal.dart';
import 'package:new_beginnings/models/quote.dart';
import 'package:new_beginnings/widgets/quote_widget.dart';
import 'dart:convert';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HomeScreen Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('HomeScreen initializes correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      expect(find.text('New Beginnings App'), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('HomeScreen fetches and displays a quote', (WidgetTester tester) async {
      final client = MockClient((request) async {
        return http.Response(json.encode({'quote': 'Test Quote'}), 200);
      });

      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Test Quote'), findsOneWidget);
    });

    testWidgets('HomeScreen navigates to GoalScreen if no goal is saved', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(GoalScreen), findsOneWidget);
    });

    testWidgets('HomeScreen displays the saved goal', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'goalText': 'Learn Flutter',
        'dateSet': DateTime.now().toString(),
      });

      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Learn Flutter'), findsOneWidget);
    });

    testWidgets('HomeScreen navigates to LogScreen when button is pressed', (WidgetTester tester) async {
      // Set up the shared preferences so that a goal is saved and the goal setting is not displayed
      SharedPreferences.setMockInitialValues({
        'goalText': 'Learn Flutter',
        'dateSet': DateTime.now().toString(),
      });

      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.tap(find.text('Log Daily Actions'));
      await tester.pumpAndSettle();

      expect(find.byType(LogScreen), findsOneWidget);
    });

    testWidgets('HomeScreen resets the goal when "Reset Goal" button is pressed', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'goalText': 'Learn Flutter',
        'dateSet': DateTime.now().toString(),
      });

      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.tap(find.text('Reset Goal'));
      await tester.pumpAndSettle();

      expect(find.byType(GoalScreen), findsOneWidget);
    });

    testWidgets('HomeScreen updates last action after logging a new action', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'goalText': 'Learn Flutter',
        'dateSet': DateTime.now().toString(),
      });

      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      // Navigate to LogScreen
      await tester.tap(find.text('Log Daily Actions'));
      await tester.pumpAndSettle();

      // Enter a new action and log it
      await tester.enterText(find.byType(TextField), 'New Action');
      await tester.tap(find.text('Log Action'));
      await tester.pumpAndSettle();

      // Navigate back to HomeScreen
      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      // Check if the last action is updated
      expect(find.text('Last Action: New Action'), findsOneWidget);
    });
  });
}