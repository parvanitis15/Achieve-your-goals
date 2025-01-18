import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:new_beginnings/models/quote.dart';
import 'package:new_beginnings/widgets/quote_widget.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  Quote? dailyQuote;

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  Future<void> fetchQuote() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/generate_quote'));
      if (response.statusCode == 200) {
        setState(() {
          final Map<String, dynamic> data = json.decode(response.body);
          dailyQuote = Quote(text: data['quote'], date: DateTime.now());
        });
      } else {
        setState(() {
          dailyQuote = Quote(text: "Failed to load quote", date: DateTime.now());
        });
      }
    } catch (e) {
      setState(() {
        dailyQuote = Quote(text: "Failed to load quote: $e", date: DateTime.now());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Quote'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (dailyQuote != null)
                QuoteWidget(quote: dailyQuote!.text)
              else
                const Text(
                  "Loading...",
                  style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}