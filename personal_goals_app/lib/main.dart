import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_goals_app/src/goals/components/goal_add.dart';
import 'package:personal_goals_app/src/goals/components/goal_edit.dart';
import 'package:personal_goals_app/src/goals/components/goal_start.dart';
import 'package:personal_goals_app/src/goals/models/goal_model.dart';
import 'package:personal_goals_app/src/home.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Strapi Api Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      initialRoute: '/',
      routes: {
        '/start': (context) => StartGoal(),
        '/add': (context) => const GoalFormPage(),
        
      },
         onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          final goal = settings.arguments as Goal;
          return MaterialPageRoute(
            builder: (context) {
              return GoalEditPage(goal: goal); 
            },
          );
        }
        return null;
      },
    );
  }
}
