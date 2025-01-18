class ActionLog {
  final String action;
  final DateTime date;

  ActionLog({required this.action, required this.date});

  // Method to convert an ActionLog object to a map
  Map<String, dynamic> toMap() {
    return {
      'action': action,
      'date': date.toIso8601String(),
    };
  }

  // Method to create an ActionLog object from a map
  factory ActionLog.fromMap(Map<String, dynamic> map) {
    return ActionLog(
      action: map['action'],
      date: DateTime.parse(map['date']),
    );
  }

  // Method to convert an ActionLog object to JSON
  Map<String, dynamic> toJson() {
    return toMap();
  }

  // Method to create an ActionLog object from JSON
  factory ActionLog.fromJson(Map<String, dynamic> json) {
    return ActionLog.fromMap(json);
  }
}