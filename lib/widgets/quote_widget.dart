import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  final String quote;

  const QuoteWidget({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        quote,
        style: const TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
        textAlign: TextAlign.center,
      ),
    );
  }
}