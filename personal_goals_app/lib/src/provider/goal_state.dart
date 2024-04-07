import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_goals_app/src/goals/models/goal_model.dart'; 
part 'goal_state.freezed.dart';

@freezed
class GoalState with _$GoalState {
  const factory GoalState({
    @Default([]) List<Goal> goals,
  }) = _GoalState;
}
