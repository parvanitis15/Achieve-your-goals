import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_beginnings/models/action_log.dart';
import 'package:new_beginnings/widgets/action_log_widget.dart';

void main() {
  group('ActionLogWidget', () {
    testWidgets('displays the correct number of ListTile widgets', (WidgetTester tester) async {
      final actionLogs = [
        ActionLog(action: 'Action 1', date: DateTime.parse('2023-10-01T12:00:00Z')),
        ActionLog(action: 'Action 2', date: DateTime.parse('2023-10-02T12:00:00Z')),
      ];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ActionLogWidget(actionLog: actionLogs),
        ),
      ));

      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('displays the correct action text', (WidgetTester tester) async {
      final actionLogs = [
        ActionLog(action: 'Action 1', date: DateTime.parse('2023-10-01T12:00:00Z')),
      ];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ActionLogWidget(actionLog: actionLogs),
        ),
      ));

      expect(find.text('Action 1'), findsOneWidget);
    });

    testWidgets('displays the correct date text', (WidgetTester tester) async {
      final actionLogs = [
        ActionLog(action: 'Action 1', date: DateTime.parse('2023-10-01T12:00:00Z')),
      ];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ActionLogWidget(actionLog: actionLogs),
        ),
      ));

      expect(find.text('2023-10-01 12:00'), findsOneWidget);
    });
  });
}