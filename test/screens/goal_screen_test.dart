import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_beginnings/models/goal.dart';
import 'package:new_beginnings/screens/goal_screen.dart';
import 'package:new_beginnings/widgets/goal_input_widget.dart';

void main() {
  group('GoalScreen', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    testWidgets('displays the GoalInputWidget and ElevatedButton', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GoalScreen(onGoalUpdated: (Goal goal) {}),
      ));

      expect(find.byType(GoalInputWidget), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Save Goal'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Back'), findsOneWidget);
    });

    testWidgets('saves and displays the goal', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GoalScreen(onGoalUpdated: (Goal goal) {}),
      ));

      await tester.enterText(find.byType(TextField), 'My New Goal');
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pump();

      expect(prefs.getString('goalText'), 'My New Goal');
      expect(find.textContaining('Your goal: My New Goal'), findsOneWidget);
    });

    testWidgets('loads saved goal on init', (WidgetTester tester) async {
      await prefs.setString('goalText', 'Saved Goal');
      await prefs.setString('dateSet', DateTime.now().toString());

      await tester.pumpWidget(MaterialApp(
        home: GoalScreen(onGoalUpdated: (Goal goal) {}),
      ));
      await tester.pump();

      expect(find.textContaining('Your goal: Saved Goal'), findsOneWidget);
    });

    testWidgets('calls onGoalUpdated when goal is saved', (WidgetTester tester) async {
      bool onGoalUpdatedCalled = false;

      await tester.pumpWidget(MaterialApp(
        home: GoalScreen(onGoalUpdated: (Goal goal) {
          onGoalUpdatedCalled = true;
        }),
      ));

      await tester.enterText(find.byType(TextField), 'Another Goal');
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pump();

      expect(onGoalUpdatedCalled, isTrue);
    });

    testWidgets('navigates back when back button is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GoalScreen(onGoalUpdated: (Goal goal) {}),
      ));

      await tester.tap(find.byType(ElevatedButton).last);
      await tester.pumpAndSettle();

      expect(find.byType(GoalScreen), findsNothing);
    });
  });
}