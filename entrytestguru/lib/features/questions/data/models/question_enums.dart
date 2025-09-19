/// Base enums for the question system
/// These enums are designed to match the backend Python models for seamless integration

/// ARDE (Actual Real Exam Data) probability levels
/// Determines how likely a question is to appear on actual exams
enum ArdeLevel {
  /// High probability (>70% chance of appearing)
  high,

  /// Medium probability (30-70% chance of appearing)
  medium,

  /// Low probability (<30% chance of appearing)
  low,
}

/// Difficulty levels for questions
enum DifficultyLevel {
  /// Very easy questions
  veryEasy,

  /// Easy questions
  easy,

  /// Medium difficulty questions
  medium,

  /// Hard questions
  hard,

  /// Very hard questions
  veryHard,
}

/// Types of questions supported
enum QuestionType {
  /// Single choice question (one correct answer)
  singleChoice,

  /// Multiple choice question (multiple correct answers)
  multipleChoice,

  /// Assertion-reason type questions
  assertionReason,

  /// Numerical answer questions
  numerical,
}

/// Sorting options for question lists
enum QuestionSortBy {
  /// Sort by relevance to search query
  relevance,

  /// Sort by ARDE probability (high to low)
  ardeProbability,

  /// Sort by difficulty level
  difficulty,

  /// Sort by user accuracy rate
  accuracy,

  /// Sort by creation date
  createdDate,

  /// Sort by popularity (most attempted)
  popularity,
}

/// Sort direction options
enum SortDirection {
  /// Ascending order (A-Z, low to high)
  ascending,

  /// Descending order (Z-A, high to low)
  descending,
}

/// User tier levels for feature access control
enum UserTier {
  /// Anonymous users with basic access
  anonymous,

  /// Free tier users with enhanced access
  free,

  /// Paid tier users with full access
  paid,
}

/// Question approval status
enum QuestionStatus {
  /// Question is in draft state
  draft,

  /// Question is under review
  review,

  /// Question is approved and active
  approved,

  /// Question is archived/inactive
  archived,
}
