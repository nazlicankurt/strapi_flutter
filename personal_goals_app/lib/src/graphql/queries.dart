const String getGoalsQuery = """
query GetGoals {
  goals {
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
