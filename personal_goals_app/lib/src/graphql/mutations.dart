// Create a new goal
const String createGoalMutation = """
mutation CreateGoal(\$name: String!, \$description: String!, \$startDate: Date!, \$endDate: Date, \$category: ENUM_GOAL_CATEGORY!, \$status: ENUM_GOAL_STATUS!) {
  createGoal(data: {
    name: \$name,
    description: \$description,
    startDate: \$startDate,
    endDate: \$endDate,
    category: \$category,  
    status: \$status     
  }) {
    data {
      id
      attributes {
        name
        description
        startDate
        endDate
        category
        status
      }
    }
  }
}
""";

// Update an existing goal
const String updateGoalMutation = """
mutation UpdateGoal(\$id: ID!, \$name: String, \$description: String, \$startDate: Date, \$endDate: Date, \$category: ENUM_GOAL_CATEGORY, \$status: ENUM_GOAL_STATUS) {
  updateGoal(id: \$id, data: {
    name: \$name,
    description: \$description,
    startDate: \$startDate,
    endDate: \$endDate,
    category: \$category,
    status: \$status
  }) {
    data {
      id
      attributes {
        name
        description
        startDate
        endDate
        category
        status
      }
    }
  }
}
""";

// Delete a goal
const String deleteGoalMutation = """
mutation DeleteGoal(\$id: ID!) {
  deleteGoal(id: \$id) {
    data {
      id
    }
  }
}
""";
