import 'package:flutter/material.dart';
import '../models/goal_model.dart'; 

class GoalCard extends StatelessWidget {
  final Goal goal;

  const GoalCard({Key? key, required this.goal}) : super(key: key);

  String formatDate(DateTime date) {
    return '${date.month}/${date.year}';
  }

  Color getStatusColor(GoalStatus status) {
    switch (status) {
      case GoalStatus.active:
        return Colors.deepPurple;
      case GoalStatus.pending:
        return Colors.blue;
      case GoalStatus.completed:
        return Colors.green;
      default:
        return Colors.grey; 
    }
  }

  @override
  Widget build(BuildContext context) {
        goal.status = Goal.calculateStatus(goal.startDate, goal.endDate!);

    return Card(
      margin: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 120,
            color: getStatusColor(goal.status),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            alignment: Alignment.center,
            child: Text(
              goal.status.toString().split('.').last.toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.track_changes),
            title: Text(goal.name),
            subtitle: Text(
              'Target duration: ${goal.endDate?.difference(goal.startDate).inDays ?? 'N/A'} days',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "End Date: ${goal.endDate != null ? formatDate(goal.endDate!) : 'N/A'}",
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Description: ${goal.description}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: const Text('Go Details'),
                onPressed: () {
                  Navigator.pushNamed(context,'/edit', arguments: goal);
                },
              ),
            ],
          ),
      const SizedBox(height: 40)

        ],
      ),
      
    );
  }
}
