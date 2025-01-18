import 'package:flutter/material.dart';
import 'package:new_beginnings/models/action_log.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LogScreen extends StatefulWidget {
  final Function(ActionLog)? onActionLogged;

  const LogScreen({super.key, this.onActionLogged});

  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final TextEditingController _actionController = TextEditingController();
  final List<ActionLog> _actionLog = [];
  bool _actionPerformedToday = false;

  @override
  void initState() {
    super.initState();
    _loadActionLog();
    _checkActionPerformedToday();
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

  Future<void> _checkActionPerformedToday() async {
    final prefs = await SharedPreferences.getInstance();
    final String? actionLogString = prefs.getString('actionLog');
    if (actionLogString != null) {
      final List<dynamic> actionLogJson = jsonDecode(actionLogString);
      if (actionLogJson.isNotEmpty) {
        final lastAction = ActionLog.fromJson(actionLogJson.last);
        if (lastAction.date.day == DateTime.now().day &&
            lastAction.date.month == DateTime.now().month &&
            lastAction.date.year == DateTime.now().year) {
          setState(() {
            _actionPerformedToday = true;
          });
        } else {
          setState(() {
            _actionPerformedToday = false;
          });
        }
      } else {
        setState(() {
          _actionPerformedToday = false;
        });
      }
    } else {
      setState(() {
        _actionPerformedToday = false;
      });
    }
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
            if (!_actionPerformedToday)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No actions logged today',
                  style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            TextField(
              controller: _actionController,
              decoration: const InputDecoration(
                labelText: 'Enter your action',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                _logAction();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logAction,
              child: const Text('Log Action'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _actionLog.length,
                itemBuilder: (context, index) {
                  final action = _actionLog[index];
                  return ListTile(
                    title: Text(action.action),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _actionLog.removeAt(index);
                          _saveActionLog();
                          _checkActionPerformedToday();
                          if (widget.onActionLogged != null) {
                            widget.onActionLogged!(_actionLog.isNotEmpty ? _actionLog.last : ActionLog(action: 'None', date: DateTime.now()));
                          }
                        });
                      },
                    ),
                  );
                },
              ),
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

  void _logAction() {
    setState(() {
      final newAction = ActionLog(action: _actionController.text, date: DateTime.now());
      _actionLog.add(newAction);
      _actionController.clear();
      _saveActionLog();
      _checkActionPerformedToday();
      if (widget.onActionLogged != null) {
        widget.onActionLogged!(newAction);
      }
    });
  }
}