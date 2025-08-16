class AppState {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  // User progress data
  Map<int, TableProgress> tableProgress = {};
  int currentLives = 5;
  int totalStars = 0;
  
  // Current lesson state
  int? currentTable;
  int currentQuestionIndex = 0;
  List<Question> currentQuestions = [];
  
  void resetLives() {
    currentLives = 5;
  }
  
  void loseLife() {
    if (currentLives > 0) {
      currentLives--;
    }
  }
  
  void gainStar() {
    totalStars++;
  }
  
  void updateTableProgress(int table, int correctAnswers, int totalQuestions) {
    tableProgress[table] = TableProgress(
      correctAnswers: correctAnswers,
      totalQuestions: totalQuestions,
      isCompleted: correctAnswers == totalQuestions,
    );
  }
}

class TableProgress {
  final int correctAnswers;
  final int totalQuestions;
  final bool isCompleted;
  
  TableProgress({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.isCompleted,
  });
  
  double get progressPercentage => correctAnswers / totalQuestions;
}

class Question {
  final int multiplicand;
  final int multiplier;
  final int correctAnswer;
  final QuestionType type;
  final List<int>? choices; // For multiple choice questions
  
  Question({
    required this.multiplicand,
    required this.multiplier,
    required this.correctAnswer,
    required this.type,
    this.choices,
  });
  
  String get questionText => '$multiplicand × $multiplier = ?';
}

enum QuestionType {
  typeAnswer,
  multipleChoice,
  followPattern,
}

