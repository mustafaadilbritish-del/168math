import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppState {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  static const String _keyCurrentLives = 'currentLives';
  static const String _keyTotalStars = 'totalStars';
  static const String _keyTableProgress = 'tableProgress';

  // User progress data
  Map<int, TableProgress> tableProgress = {};
  int currentLives = 5;
  int totalStars = 0;
  
  // Current lesson state
  int? currentTable;
  int currentQuestionIndex = 0;
  List<Question> currentQuestions = [];

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    currentLives = prefs.getInt(_keyCurrentLives) ?? currentLives;
    totalStars = prefs.getInt(_keyTotalStars) ?? totalStars;
    final tableStr = prefs.getString(_keyTableProgress);
    if (tableStr != null && tableStr.isNotEmpty) {
      final Map<String, dynamic> decoded = jsonDecode(tableStr) as Map<String, dynamic>;
      tableProgress = decoded.map((key, value) {
        final int table = int.tryParse(key) ?? 0;
        final Map<String, dynamic> data = Map<String, dynamic>.from(value as Map);
        return MapEntry(table, TableProgress.fromMap(data));
      });
    }
  }

  Future<void> saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCurrentLives, currentLives);
    await prefs.setInt(_keyTotalStars, totalStars);
    final encoded = jsonEncode(
      tableProgress.map((key, value) => MapEntry(key.toString(), value.toMap())),
    );
    await prefs.setString(_keyTableProgress, encoded);
  }
  
  void resetLives() {
    currentLives = 5;
    saveToStorage();
  }
  
  void loseLife() {
    if (currentLives > 0) {
      currentLives--;
      saveToStorage();
    }
  }
  
  void gainStar() {
    totalStars++;
    saveToStorage();
  }
  
  void updateTableProgress(int table, int correctAnswers, int totalQuestions) {
    tableProgress[table] = TableProgress(
      correctAnswers: correctAnswers,
      totalQuestions: totalQuestions,
      isCompleted: correctAnswers == totalQuestions,
    );
    saveToStorage();
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

  Map<String, dynamic> toMap() => {
    'correctAnswers': correctAnswers,
    'totalQuestions': totalQuestions,
    'isCompleted': isCompleted,
  };

  factory TableProgress.fromMap(Map<String, dynamic> map) => TableProgress(
    correctAnswers: (map['correctAnswers'] as num?)?.toInt() ?? 0,
    totalQuestions: (map['totalQuestions'] as num?)?.toInt() ?? 0,
    isCompleted: map['isCompleted'] as bool? ?? false,
  );
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

