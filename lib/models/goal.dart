class Goal {
  final String goalText;
  final DateTime dateSet;

  Goal({required this.goalText, required this.dateSet});

  // Method to convert a Goal object to a map
  Map<String, dynamic> toMap() {
    return {
      'goalText': goalText,
      'dateSet': dateSet.toIso8601String(),
    };
  }

  // Method to create a Goal object from a map
  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      goalText: map['goalText'],
      dateSet: DateTime.parse(map['dateSet']),
    );
  }
}