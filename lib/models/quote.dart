class Quote {
  final String text;
  final DateTime date;

  Quote({required this.text, required this.date});

  // Method to convert a Quote object to a map
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'date': date.toIso8601String(),
    };
  }

  // Method to create a Quote object from a map
  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      text: map['text'],
      date: DateTime.parse(map['date']),
    );
  }
}