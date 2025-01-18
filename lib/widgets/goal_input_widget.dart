import 'package:flutter/material.dart';

class GoalInputWidget extends StatelessWidget {
  final TextEditingController goalController;
  final VoidCallback onSave;

  const GoalInputWidget({
    super.key,
    required this.goalController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: goalController,
            decoration: const InputDecoration(
              labelText: 'Enter your goal',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onSave,
            child: const Text('Save Goal'),
          ),
        ],
      ),
    );
  }
}