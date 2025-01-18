import 'package:flutter/material.dart';
import 'package:new_beginnings/models/action_log.dart';
import 'package:new_beginnings/models/goal.dart';
import 'package:new_beginnings/models/quote.dart';
import 'package:new_beginnings/widgets/action_log_widget.dart';
import 'package:new_beginnings/widgets/goal_input_widget.dart';
import 'package:new_beginnings/widgets/quote_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IntegratedScreen extends StatefulWidget {
  const IntegratedScreen({super.key});

  @override
  _IntegratedScreenState createState() => _IntegratedScreenState();
}

class _IntegratedScreenState extends State<IntegratedScreen> {
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _actionController = TextEditingController();
  final List<ActionLog> _actionLog = [];
  Goal? _savedGoal;
  Quote? dailyQuote;

  @override
  void initState() {
    super.initState();
    _loadSavedGoal();
    _loadActionLog();
    fetchQuote();
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

  Future<void> _loadActionLog() async {
    final prefs = await SharedPreferences.getInstance();
    final String? actionLogString = prefs.getString('actionLog');
    if (actionLogString != null) {
      final List<dynamic> actionLogJson = jsonDecode(actionLogString);
      setState(() {
        _actionLog.addAll(actionLogJson.map((json) => ActionLog.fromJson(json)).toList());
      });
    }
  }

  Future<void> _saveActionLog() async {
    final prefs = await SharedPreferences.getInstance();
    final String actionLogString = jsonEncode(_actionLog.map((log) => log.toJson()).toList());
    await prefs.setString('actionLog', actionLogString);
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
        title: const Text('New Beginnings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GoalInputWidget(
                goalController: _goalController,
                onSave: () async {
                  setState(() {
                    _savedGoal = Goal(
                      goalText: _goalController.text,
                      dateSet: DateTime.now(),
                    );
                  });
                  await _saveGoal();
                },
              ),
              const SizedBox(height: 20),
              if (_savedGoal != null)
                Text(
                  'Your goal: ${_savedGoal!.goalText}\nSet on: ${_savedGoal!.dateSet.toString().split(':').sublist(0, 2).join(':')}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              const SizedBox(height: 20),
              TextField(
                controller: _actionController,
                decoration: const InputDecoration(
                  labelText: 'Enter your action',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _actionLog.add(ActionLog(action: _actionController.text, date: DateTime.now()));
                    _actionController.clear();
                    _saveActionLog();
                  });
                },
                child: const Text('Log Action'),
              ),
              const SizedBox(height: 20),
              ActionLogWidget(actionLog: _actionLog),
              const SizedBox(height: 20),
              if (dailyQuote != null)
                QuoteWidget(quote: dailyQuote!.text)
              else
                const Text(
                  "Loading...",
                  style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}