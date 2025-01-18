import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_beginnings/screens/goal_screen.dart';
import 'package:new_beginnings/models/goal.dart';

void main() {
  testWidgets('GoalScreen displays and saves goal', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    Goal? updatedGoal;
    await tester.pumpWidget(MaterialApp(
      home: GoalScreen(
        onGoalUpdated: (goal) {
          updatedGoal = goal;
        },
      ),
    ));

    // Verify the initial state
    expect(find.text('Set Your Goal'), findsOneWidget);
    expect(find.text('Enter your goal'), findsOneWidget);

    // Enter a goal
    await tester.enterText(find.byType(TextField), 'Learn Flutter');
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verify the goal is saved and displayed
    expect(updatedGoal, isNotNull);
    expect(updatedGoal!.goalText, 'Learn Flutter');
    expect(find.text('Your goal: Learn Flutter'), findsOneWidget);
  });
}
