import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_goals_app/src/goals/components/goal_card.dart';
import 'package:personal_goals_app/src/provider/goal_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(goalProvider.notifier).getGoals());
  }

  @override
  Widget build(BuildContext context) {
    final goals = ref.watch(goalProvider).goals;

    return Scaffold(
        appBar: AppBar(title: const Text('Targets')),
        body: ListView.builder(
          itemCount: goals.length,
          itemBuilder: (context, index) {
            final goal = goals[index];
            return GoalCard(goal: goal);
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final refreshNeeded = await Navigator.pushNamed(context, '/start');
            if (refreshNeeded == true) {
              ref.read(goalProvider.notifier).getGoals();
            }
          },
          label: const Text('Add New Target'),
          icon: const Icon(Icons.add),
        ));
  }
}
