import 'package:flutter/material.dart';
import 'goal_screen.dart';
import 'log_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:new_beginnings/models/quote.dart';
import 'package:new_beginnings/widgets/quote_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/action_log.dart'; // Add this import
import '../models/goal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Quote? dailyQuote;
  Goal? _savedGoal;
  ActionLog? _lastAction;

  @override
  void initState() {
    super.initState();
    fetchQuote();
    _loadSavedGoal().then((_) {
      if (_savedGoal == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GoalScreen(onGoalUpdated: _updateGoal),
          ),
        );
      }
    });
    _loadLastAction();
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

  Future<void> _loadLastAction() async {
    final prefs = await SharedPreferences.getInstance();
    final String? actionLogString = prefs.getString('actionLog');
    if (actionLogString != null) {
      final List<dynamic> actionLogJson = jsonDecode(actionLogString);
      if (actionLogJson.isNotEmpty) {
        setState(() {
          _lastAction = ActionLog.fromJson(actionLogJson.last);
        });
      }
    }
  }

  void _updateGoal(Goal newGoal) {
    setState(() {
      _savedGoal = newGoal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achieve Your Goals'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GoalScreen(onGoalUpdated: _updateGoal),
                ),  
              );
            },
            child: const Text('Reset Goal'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            if (_savedGoal != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Goal',
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      _savedGoal!.goalText,
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogScreen(
                            onActionLogged: (newAction) {
                              setState(() {
                                _lastAction = newAction;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: const Text('Log Daily Actions'),
                  ),
                  const SizedBox(height: 20),
                  if (_lastAction != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Last Action: ${_lastAction!.action}',
                        style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
            if (dailyQuote != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: QuoteWidget(quote: dailyQuote!.text),
              )
            else
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Loading...",
                  style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}