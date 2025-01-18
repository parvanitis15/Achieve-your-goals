import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_beginnings/screens/log_screen.dart';
import 'package:new_beginnings/models/action_log.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LogScreen Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('LogScreen initializes correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LogScreen()));
      expect(find.text('Log Daily Actions'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Log Action'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('LogScreen logs a new action', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LogScreen()));
      await tester.enterText(find.byType(TextField), 'New Action');
      await tester.tap(find.text('Log Action'));
      await tester.pumpAndSettle();

      expect(find.text('New Action'), findsOneWidget);
    });

    testWidgets('LogScreen deletes an action', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LogScreen()));
      await tester.enterText(find.byType(TextField), 'Action to Delete');
      await tester.tap(find.text('Log Action'));
      await tester.pumpAndSettle();

      expect(find.text('Action to Delete'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(find.text('Action to Delete'), findsNothing);
    });

    testWidgets('LogScreen navigates back when "Back" button is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LogScreen()));
      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      expect(find.text('Log Daily Actions'), findsNothing);
    });
  });
}