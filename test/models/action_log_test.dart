import 'package:flutter_test/flutter_test.dart';
import 'package:new_beginnings/models/action_log.dart';

void main() {
  group('ActionLog', () {
    test('toMap should convert ActionLog object to map', () {
      final actionLog = ActionLog(action: 'Test Action', date: DateTime.parse('2023-10-01T12:00:00Z'));
      final map = actionLog.toMap();
      expect(map, {
        'action': 'Test Action',
        'date': '2023-10-01T12:00:00.000Z',
      });
    });

    test('fromMap should create ActionLog object from map', () {
      final map = {
        'action': 'Test Action',
        'date': '2023-10-01T12:00:00.000Z',
      };
      final actionLog = ActionLog.fromMap(map);
      expect(actionLog.action, 'Test Action');
      expect(actionLog.date, DateTime.parse('2023-10-01T12:00:00Z'));
    });

    test('toJson should convert ActionLog object to JSON', () {
      final actionLog = ActionLog(action: 'Test Action', date: DateTime.parse('2023-10-01T12:00:00Z'));
      final json = actionLog.toJson();
      expect(json, {
        'action': 'Test Action',
        'date': '2023-10-01T12:00:00.000Z',
      });
    });

    test('fromJson should create ActionLog object from JSON', () {
      final json = {
        'action': 'Test Action',
        'date': '2023-10-01T12:00:00.000Z',
      };
      final actionLog = ActionLog.fromJson(json);
      expect(actionLog.action, 'Test Action');
      expect(actionLog.date, DateTime.parse('2023-10-01T12:00:00Z'));
    });
  });
}