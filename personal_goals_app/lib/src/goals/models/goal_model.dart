enum GoalStatus { active, completed, pending }
enum GoalCategory { vacation, money, exercise, smoke, language }

class Goal {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime? endDate; // End date is optional because some goals might not have a specific end date
  final GoalCategory category;
  GoalStatus status;
  double? targetValue; // Numeric value representing the goal target (e.g., amount to save)
  double? currentValue; // Current progress towards the goal (e.g., current savings)

  Goal({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.category,
    this.status = GoalStatus.pending,
    this.targetValue,
    this.currentValue,
  });


  factory Goal.fromJson(Map<String, dynamic> json) {
        var attributes = json['attributes'];
    return Goal(
    id: json['id'].toString(), // Ensuring `id` is treated as a String.
    name: attributes['name'] ?? '', // Providing a default empty string if `name` is null.
    description: attributes['description'] ?? '',
    startDate: DateTime.parse(attributes['startDate']),
    endDate: attributes['endDate'] != null ? DateTime.parse(attributes['endDate']) : null,
    category: _stringToGoalCategory(attributes['category'] ?? 'vacation'),
    status: _stringToGoalStatus(attributes['status'] ?? 'pending'),
    targetValue: attributes['targetValue'],
    currentValue: attributes['currentValue'],
    );
  }
  // Calculate the status of the goal based on dates
  static GoalStatus calculateStatus(DateTime startDate, DateTime endDate) {
    final currentDate = DateTime.now();
    if (currentDate.isAfter(endDate)) {
      return GoalStatus.completed;
    } else  if (currentDate.isAfter(startDate)) {
      return GoalStatus.active;
    } else {
      return GoalStatus.pending;
    }
  }

  static GoalCategory _stringToGoalCategory(String category) {
    return GoalCategory.values.firstWhere(
      (e) => e.toString().split('.').last == category,
      orElse: () => GoalCategory.vacation, 
    );
  }

  static GoalStatus _stringToGoalStatus(String status) {
    return GoalStatus.values.firstWhere(
      (e) => e.toString().split('.').last == status,
      orElse: () => GoalStatus.pending,
    );
  }
}
