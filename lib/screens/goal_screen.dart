import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/goal.dart';
import '../widgets/goal_input_widget.dart';

class GoalScreen extends StatefulWidget {
  final Function(Goal) onGoalUpdated;

  const GoalScreen({super.key, required this.onGoalUpdated});

  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final TextEditingController _goalController = TextEditingController();
  Goal? _savedGoal;

  @override
  void initState() {
    super.initState();
    _loadSavedGoal();
  }

  Future<void> _loadSavedGoal() async {
    final prefs = await SharedPreferences.getInstance();
    final goalText = prefs.getString('goalText');
    final dateSet = prefs.getString('dateSet');
    if (goalText != null && dateSet != null) {
      setState(() {
        _savedGoal = Goal(
          goalText: goalText,
          dateSet: DateTime.parse(dateSet),
        );
      });
    }
  }

  Future<void> _saveGoal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('goalText', _goalController.text);
    await prefs.setString('dateSet', DateTime.now().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Your Goal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GoalInputWidget(
              goalController: _goalController,
              onSave: () async {
                final newGoal = Goal(
                  goalText: _goalController.text,
                  dateSet: DateTime.now(),
                );
                setState(() {
                  _savedGoal = newGoal;
                });
                await _saveGoal();
                widget.onGoalUpdated(newGoal);
              },
            ),
            const SizedBox(height: 20),
            if (_savedGoal != null)
              Text(
                // Display the goal text and date set (without seconds)
                'Your goal: ${_savedGoal!.goalText}\nSet on: ${_savedGoal!.dateSet.toString().split(':').sublist(0, 2).join(':')}',
                style: const TextStyle(fontSize: 18.0),
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
    );
  }
}