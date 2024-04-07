import 'package:flutter/material.dart';
import 'package:personal_goals_app/src/goals/models/goal_list.dart';

class StartGoal extends StatelessWidget {
  StartGoal({super.key});

  final List<GoalList> targetList = [
    GoalList(
      title: 'Plan your vacation',
      icon: Icons.flight_takeoff,
      subtitle: 'Plan your next getaway',
    ),
    GoalList(
      title: 'Save Money',
      icon: Icons.attach_money,
      subtitle: 'Start saving money',
    ),
    GoalList(
      title: 'Quit Smoking',
      icon: Icons.smoke_free,
      subtitle: 'Track smoke-free days',
    ),
    GoalList(
      title: 'Exercise',
      icon: Icons.directions_run,
      subtitle: 'Keep up with your workouts',
    ),
    GoalList(
      title: 'Learn a new language',
      icon: Icons.book,
      subtitle: 'Stay on top of your studies',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new target')),
      body: ListView.builder(
        itemCount: targetList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Icon(targetList[index].icon, size: 36,        color: Colors.deepPurple,),
              title: Text(targetList[index].title),
              subtitle: Text(targetList[index].subtitle),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.deepPurple,
              ),
              onTap: () {


                Navigator.pushNamed(context, '/add');
              },
            ),
          );
        },
      ),
    );
  }
}
