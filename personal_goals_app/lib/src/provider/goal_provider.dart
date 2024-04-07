import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:personal_goals_app/src/goals/models/goal_model.dart';
import 'package:personal_goals_app/src/graphql/mutations.dart';
import 'package:personal_goals_app/src/graphql/queries.dart';
import 'package:personal_goals_app/src/provider/goal_graphql_provider.dart';
import 'package:personal_goals_app/src/provider/goal_state.dart';

class GoalNotifier extends StateNotifier<GoalState> {
  final GraphQLClient client;

  GoalNotifier(this.client) : super(const GoalState(goals: []));

  //Get all goals
  Future<void> getGoals() async {
    final QueryOptions options = QueryOptions(
      document: gql(getGoalsQuery),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print("Exception fetching goals: ${result.exception.toString()}");
      return;
    }

    final List<dynamic> fetchedGoals = result.data?['goals']['data'] ?? [];
    final List<Goal> goalsList =
        fetchedGoals.map((goalData) => Goal.fromJson(goalData)).toList();

    state = state.copyWith(goals: goalsList);
  }

  // Add a new goal
  Future<void> addGoal(Goal goal) async {
    final MutationOptions options = MutationOptions(
      document: gql(createGoalMutation),
      variables: {
        'name': goal.name,
        'description': goal.description,
        'startDate': DateFormat('yyyy-MM-dd').format(goal.startDate),
        'endDate': goal.endDate != null
            ? DateFormat('yyyy-MM-dd').format(goal.endDate!)
            : null,
        'category': goal.category.toString().split('.').last,
        'status': goal.status.toString().split('.').last,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print("Exception adding goal: ${result.exception.toString()}");
      return;
    }

    final newGoalData = result.data?['createGoal']['data'];
    if (newGoalData != null) {
      final newGoal = Goal.fromJson(newGoalData);
      state = state.copyWith(goals: [...state.goals, newGoal]);
    }
  }

  // Update an existing goal
  Future<void> updateGoal(String id, Goal updatedGoal) async {
    final MutationOptions options = MutationOptions(
      document: gql(updateGoalMutation),
      variables: {
        'id': id,
        'name': updatedGoal.name,
        'description': updatedGoal.description,
        'startDate': DateFormat('yyyy-MM-dd').format(updatedGoal.startDate),
        'endDate': updatedGoal.endDate != null
            ? DateFormat('yyyy-MM-dd').format(updatedGoal.endDate!)
            : null,
        'category': updatedGoal.category.toString().split('.').last,
        'status': updatedGoal.status.toString().split('.').last,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print("Exception updating goal: ${result.exception.toString()}");
      return;
    }

    await getGoals();
  }

// Delete a goal
  Future<void> deleteGoal(String id) async {
    final MutationOptions options = MutationOptions(
      document: gql(deleteGoalMutation),
      variables: {'id': id},
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print("Exception deleting goal: ${result.exception.toString()}");
      return;
    }

    state = state.copyWith(
        goals: state.goals.where((goal) => goal.id != id).toList());
  }
}

final goalProvider = StateNotifierProvider<GoalNotifier, GoalState>((ref) {
  final client = ref.read(graphqlClientProvider);
  return GoalNotifier(client);
});
