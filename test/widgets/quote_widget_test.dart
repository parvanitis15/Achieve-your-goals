import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_beginnings/widgets/quote_widget.dart';

void main() {
  group('QuoteWidget', () {
    testWidgets('displays the quote text', (WidgetTester tester) async {
      const testQuote = 'This is a test quote.';

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: QuoteWidget(quote: testQuote),
        ),
      ));

      expect(find.text(testQuote), findsOneWidget);
    });

    testWidgets('applies correct text style', (WidgetTester tester) async {
      const testQuote = 'This is a test quote.';

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: QuoteWidget(quote: testQuote),
        ),
      ));

      final textWidget = tester.widget<Text>(find.text(testQuote));
      expect(textWidget.style?.fontSize, 24.0);
      expect(textWidget.style?.fontStyle, FontStyle.italic);
    });

    testWidgets('applies correct padding', (WidgetTester tester) async {
      const testQuote = 'This is a test quote.';

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: QuoteWidget(quote: testQuote),
        ),
      ));

      final paddingWidget = tester.widget<Padding>(find.byType(Padding));
      expect(paddingWidget.padding, const EdgeInsets.all(16.0));
    });

    testWidgets('centers the text', (WidgetTester tester) async {
      const testQuote = 'This is a test quote.';

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: QuoteWidget(quote: testQuote),
        ),
      ));

      final textWidget = tester.widget<Text>(find.text(testQuote));
      expect(textWidget.textAlign, TextAlign.center);
    });
  });
}