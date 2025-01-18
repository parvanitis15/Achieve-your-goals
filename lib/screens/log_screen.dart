import 'package:flutter/material.dart';
import 'package:new_beginnings/models/action_log.dart';
import 'package:new_beginnings/widgets/action_log_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final TextEditingController _actionController = TextEditingController();
  final List<ActionLog> _actionLog = [];

  @override
  void initState() {
    super.initState();
    _loadActionLog();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Daily Actions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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