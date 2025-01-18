import 'package:flutter_test/flutter_test.dart';
import 'package:new_beginnings/models/goal.dart';

void main() {
  group('Goal', () {
    test('toMap should convert Goal object to map', () {
      final goal = Goal(goalText: 'Learn Dart', dateSet: DateTime.parse('2023-10-01T12:00:00Z'));
      final map = goal.toMap();
      expect(map, {
        'goalText': 'Learn Dart',
        'dateSet': '2023-10-01T12:00:00.000Z',
      });
    });

    test('fromMap should create Goal object from map', () {
      final map = {
        'goalText': 'Learn Dart',
        'dateSet': '2023-10-01T12:00:00.000Z',
      };
      final goal = Goal.fromMap(map);
      expect(goal.goalText, 'Learn Dart');
      expect(goal.dateSet, DateTime.parse('2023-10-01T12:00:00Z'));
    });
  });
}