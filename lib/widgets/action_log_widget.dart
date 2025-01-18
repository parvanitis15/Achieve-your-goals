import 'package:flutter/material.dart';
import '../models/action_log.dart';

class ActionLogWidget extends StatelessWidget {
  final List<ActionLog> actionLog;

  const ActionLogWidget({super.key, required this.actionLog});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: actionLog.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(actionLog[index].action),
            subtitle: Text(actionLog[index].date.toIso8601String().replaceFirst('T', ' ').split(':').sublist(0, 2).join(':')),
          );
        },
      ),
    );
  }
}