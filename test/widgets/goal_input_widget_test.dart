import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_beginnings/widgets/goal_input_widget.dart';

void main() {
  group('GoalInputWidget', () {
    testWidgets('displays the TextField and ElevatedButton', (WidgetTester tester) async {
      final goalController = TextEditingController();
      final onSave = () {};

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GoalInputWidget(
            goalController: goalController,
            onSave: onSave,
          ),
        ),
      ));

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('displays the correct label text in TextField', (WidgetTester tester) async {
      final goalController = TextEditingController();
      final onSave = () {};

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GoalInputWidget(
            goalController: goalController,
            onSave: onSave,
          ),
        ),
      ));

      expect(find.text('Enter your goal'), findsOneWidget);
    });

    testWidgets('calls onSave when ElevatedButton is pressed', (WidgetTester tester) async {
      final goalController = TextEditingController();
      bool onSaveCalled = false;
      final onSave = () {
        onSaveCalled = true;
      };

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GoalInputWidget(
            goalController: goalController,
            onSave: onSave,
          ),
        ),
      ));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(onSaveCalled, isTrue);
    });

    testWidgets('updates TextField value', (WidgetTester tester) async {
      final goalController = TextEditingController();
      final onSave = () {};

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GoalInputWidget(
            goalController: goalController,
            onSave: onSave,
          ),
        ),
      ));

      await tester.enterText(find.byType(TextField), 'New Goal');
      expect(goalController.text, 'New Goal');
    });
  });
}