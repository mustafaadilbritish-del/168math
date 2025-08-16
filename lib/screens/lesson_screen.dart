import 'package:flutter/material.dart';
import 'dart:math';
import '../models/app_state.dart';
import '../widgets/question_widgets.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with TickerProviderStateMixin {
  late int tableNumber;
  late AppState appState;
  late AnimationController _progressController;
  late AnimationController _feedbackController;
  late Animation<double> _progressAnimation;
  late Animation<double> _feedbackAnimation;
  
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  bool showFeedback = false;
  bool isCorrect = false;
  String userAnswer = '';

  @override
  void initState() {
    super.initState();
    appState = AppState();
    
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
    
    _feedbackAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as int?;
    if (args != null) {
      tableNumber = args;
      _generateQuestions();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _generateQuestions() {
    questions.clear();
    final random = Random();
    
    // Generate 12 questions for the multiplication table
    for (int i = 1; i <= 12; i++) {
      final questionType = _getRandomQuestionType(random);
      List<int>? choices;
      
      if (questionType == QuestionType.multipleChoice) {
        choices = _generateChoices(tableNumber * i, random);
      }
      
      questions.add(Question(
        multiplicand: tableNumber,
        multiplier: i,
        correctAnswer: tableNumber * i,
        type: questionType,
        choices: choices,
      ));
    }
    
    // Shuffle questions for variety
    questions.shuffle(random);
    
    _progressController.forward();
  }

  QuestionType _getRandomQuestionType(Random random) {
    final types = [
      QuestionType.typeAnswer,
      QuestionType.multipleChoice,
      QuestionType.followPattern,
    ];
    return types[random.nextInt(types.length)];
  }

  List<int> _generateChoices(int correctAnswer, Random random) {
    final choices = <int>[correctAnswer];
    
    while (choices.length < 4) {
      int wrongAnswer;
      if (random.nextBool()) {
        // Generate close wrong answers
        wrongAnswer = correctAnswer + random.nextInt(10) - 5;
      } else {
        // Generate random wrong answers
        wrongAnswer = random.nextInt(144) + 1;
      }
      
      if (wrongAnswer > 0 && !choices.contains(wrongAnswer)) {
        choices.add(wrongAnswer);
      }
    }
    
    choices.shuffle(random);
    return choices;
  }

  void _submitAnswer(String answer) {
    final currentQuestion = questions[currentQuestionIndex];
    final userAnswerInt = int.tryParse(answer) ?? -1;
    
    setState(() {
      isCorrect = userAnswerInt == currentQuestion.correctAnswer;
      showFeedback = true;
      userAnswer = answer;
    });
    
    if (isCorrect) {
      correctAnswers++;
      appState.gainStar();
    } else {
      appState.loseLife();
    }
    
    _feedbackController.forward().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        _nextQuestion();
      });
    });
  }

  void _nextQuestion() {
    _feedbackController.reset();
    
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        showFeedback = false;
        userAnswer = '';
      });
    } else {
      _completeLesson();
    }
  }

  void _completeLesson() {
    appState.updateTableProgress(tableNumber, correctAnswers, questions.length);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _buildCompletionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final currentQuestion = questions[currentQuestionIndex];
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF3E5F5),
              Color(0xFFE1BEE7),
              Color(0xFFCE93D8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with progress and lives
              _buildHeader(isTablet),
              
              // Question content
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: showFeedback
                      ? _buildFeedbackWidget(isTablet)
                      : _buildQuestionWidget(currentQuestion, isTablet),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Top row with close button and lives
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.close,
                  size: isTablet ? 32 : 24,
                  color: const Color(0xFF7B1FA2),
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < appState.currentLives
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                    size: isTablet ? 28 : 24,
                  );
                }),
              ),
            ],
          ),
          
          const SizedBox(height: 10),
          
          // Progress bar
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (currentQuestionIndex + 1) / questions.length,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 10),
          
          // Question counter
          Text(
            'Question ${currentQuestionIndex + 1} of ${questions.length}',
            style: TextStyle(
              fontSize: isTablet ? 18 : 14,
              color: const Color(0xFF7B1FA2),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionWidget(Question question, bool isTablet) {
    switch (question.type) {
      case QuestionType.typeAnswer:
        return TypeAnswerWidget(
          question: question,
          onSubmit: _submitAnswer,
          isTablet: isTablet,
        );
      case QuestionType.multipleChoice:
        return MultipleChoiceWidget(
          question: question,
          onSubmit: _submitAnswer,
          isTablet: isTablet,
        );
      case QuestionType.followPattern:
        return FollowPatternWidget(
          question: question,
          onSubmit: _submitAnswer,
          isTablet: isTablet,
        );
    }
  }

  Widget _buildFeedbackWidget(bool isTablet) {
    return AnimatedBuilder(
      animation: _feedbackAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _feedbackAnimation.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dash character with expression
              Container(
                width: isTablet ? 150 : 120,
                height: isTablet ? 150 : 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    isCorrect
                        ? 'assets/images/dash_character.png'
                        : 'assets/images/dash_character_glasses.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Feedback message
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  color: isCorrect ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: Colors.white,
                      size: isTablet ? 48 : 36,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isCorrect ? 'Correct!' : 'Try Again!',
                      style: TextStyle(
                        fontSize: isTablet ? 28 : 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (!isCorrect) ...[
                      const SizedBox(height: 10),
                      Text(
                        'The correct answer is ${questions[currentQuestionIndex].correctAnswer}',
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompletionDialog() {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final percentage = (correctAnswers / questions.length * 100).round();
    
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dash character
            Container(
              width: isTablet ? 100 : 80,
              height: isTablet ? 100 : 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/dash_character.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            Text(
              'Lesson Complete!',
              style: TextStyle(
                fontSize: isTablet ? 28 : 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1976D2),
              ),
            ),
            
            const SizedBox(height: 15),
            
            Text(
              'Table $tableNumber',
              style: TextStyle(
                fontSize: isTablet ? 20 : 18,
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Results
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildResultItem(
                  Icons.check_circle,
                  '$correctAnswers/${questions.length}',
                  'Correct',
                  Colors.green,
                  isTablet,
                ),
                _buildResultItem(
                  Icons.star,
                  '$correctAnswers',
                  'Stars',
                  Colors.amber,
                  isTablet,
                ),
                _buildResultItem(
                  Icons.percent,
                  '$percentage%',
                  'Score',
                  Colors.blue,
                  isTablet,
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Continue button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: EdgeInsets.symmetric(vertical: isTablet ? 15 : 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem(
    IconData icon,
    String value,
    String label,
    Color color,
    bool isTablet,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: isTablet ? 32 : 28,
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: isTablet ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: isTablet ? 14 : 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

