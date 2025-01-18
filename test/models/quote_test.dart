import 'package:flutter_test/flutter_test.dart';
import 'package:new_beginnings/models/quote.dart';

void main() {
  group('Quote', () {
    test('toMap should convert Quote object to map', () {
      final quote = Quote(text: 'This is a quote', date: DateTime.parse('2023-10-01T12:00:00Z'));
      final map = quote.toMap();
      expect(map, {
        'text': 'This is a quote',
        'date': '2023-10-01T12:00:00.000Z',
      });
    });

    test('fromMap should create Quote object from map', () {
      final map = {
        'text': 'This is a quote',
        'date': '2023-10-01T12:00:00.000Z',
      };
      final quote = Quote.fromMap(map);
      expect(quote.text, 'This is a quote');
      expect(quote.date, DateTime.parse('2023-10-01T12:00:00Z'));
    });
  });
}