import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_beginnings/widgets/goal_input_widget.dart';

void main() {
  group('GoalInputWidget', () {
    late TextEditingController goalController;

    setUp(() {
      goalController = TextEditingController();
    });

    testWidgets('displays the TextField', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: GoalInputWidget(
            goalController: goalController,
          ),
        ),
      ));

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('TextField has correct label text', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: GoalInputWidget(
            goalController: goalController,
          ),
        ),
      ));

      expect(find.text('Enter your goal'), findsOneWidget);
    });

    testWidgets('TextField has OutlineInputBorder', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: GoalInputWidget(
            goalController: goalController,
          ),
        ),
      ));

      final textField = tester.widget<TextField>(find.byType(TextField));
      final decoration = textField.decoration as InputDecoration;
      expect(decoration.border, isA<OutlineInputBorder>());
    });

    testWidgets('accepts input in the TextField', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: GoalInputWidget(
            goalController: goalController,
          ),
        ),
      ));

      await tester.enterText(find.byType(TextField), 'Test Goal');
      expect(goalController.text, 'Test Goal');
    });

  });
}