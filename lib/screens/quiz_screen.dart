import 'package:flutter/material.dart';
import '../models/question.dart';
import '../models/quiz_result.dart';
import '../models/quiz_state.dart';
import '../services/question_service.dart';
import '../services/storage_service.dart';
import 'results_screen.dart';

class QuizScreen extends StatefulWidget {
  final QuizState? savedState;

  const QuizScreen({super.key, this.savedState});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with WidgetsBindingObserver {
  final QuestionService _questionService = QuestionService();
  final StorageService _storage = StorageService();
  final ScrollController _scrollController = ScrollController();

  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  bool _hasCheckedAnswer = false;
  final List<QuestionAnswer> _answers = [];
  bool _isLoading = true;
  DateTime? _startedAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadQuestions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Save quiz state when app goes to background
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _saveProgress();
    }
  }

  Future<void> _loadQuestions() async {
    // Check if we have a saved state to restore
    if (widget.savedState != null) {
      setState(() {
        _questions = widget.savedState!.questions;
        _currentQuestionIndex = widget.savedState!.currentQuestionIndex;
        _selectedAnswerIndex = widget.savedState!.selectedAnswerIndex;
        _hasCheckedAnswer = widget.savedState!.hasCheckedAnswer;
        _answers.addAll(widget.savedState!.answers);
        _startedAt = widget.savedState!.startedAt;
        _isLoading = false;
      });
    } else {
      final questions = await _questionService.getDailyQuestions();
      setState(() {
        _questions = questions;
        _startedAt = DateTime.now();
        _isLoading = false;
      });
    }
  }

  Future<void> _saveProgress() async {
    if (_questions.isEmpty || _currentQuestionIndex >= _questions.length) {
      return;
    }

    final state = QuizState(
      questions: _questions,
      currentQuestionIndex: _currentQuestionIndex,
      selectedAnswerIndex: _selectedAnswerIndex,
      hasCheckedAnswer: _hasCheckedAnswer,
      answers: _answers,
      startedAt: _startedAt ?? DateTime.now(),
    );

    await _storage.saveQuizState(state);
  }

  void _selectAnswer(int index) {
    if (!_hasCheckedAnswer) {
      setState(() {
        _selectedAnswerIndex = index;
      });
      _saveProgress();
    }
  }

  void _checkAnswer() {
    if (_selectedAnswerIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an answer first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _hasCheckedAnswer = true;
    });

    final currentQuestion = _questions[_currentQuestionIndex];
    final isCorrect =
        _selectedAnswerIndex == currentQuestion.correctAnswerIndex;

    _answers.add(QuestionAnswer(
      questionId: currentQuestion.id,
      question: currentQuestion.question,
      selectedAnswerIndex: _selectedAnswerIndex!,
      correctAnswerIndex: currentQuestion.correctAnswerIndex,
      isCorrect: isCorrect,
    ));

    _saveProgress();
  }

  void _nextQuestion() {
    if (!_hasCheckedAnswer) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please check your answer first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      // Reset scroll position to top before moving to next question
      _scrollController.jumpTo(0);

      setState(() {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
        _hasCheckedAnswer = false;
      });

      _saveProgress();
    } else {
      _finishQuiz();
    }
  }

  Future<void> _finishQuiz() async {
    final score = _answers.where((a) => a.isCorrect).length;
    final result = QuizResult(
      date: DateTime.now(),
      score: score,
      totalQuestions: _questions.length,
      answers: _answers,
    );

    await _storage.saveQuizResult(result);

    // Clear saved quiz state after completion
    await _storage.clearSavedQuizState();

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultsScreen(result: result),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF4361EE),
          ),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Exit Quiz?'),
                content: const Text(
                    'Your progress will be saved automatically. You can resume later.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _saveProgress();
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Exit'),
                  ),
                ],
              ),
            );
          },
        ),
        title: Text(
          '${_currentQuestionIndex + 1} / ${_questions.length}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: List.generate(_questions.length, (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(
                      left: index == 0 ? 0 : 4,
                    ),
                    decoration: BoxDecoration(
                      color: index <= _currentQuestionIndex
                          ? const Color(0xFF4361EE)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    currentQuestion.question,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ...List.generate(currentQuestion.options.length, (index) {
                    final isSelected = _selectedAnswerIndex == index;
                    final isCorrect =
                        index == currentQuestion.correctAnswerIndex;
                    final showCorrect = _hasCheckedAnswer && isCorrect;
                    final showIncorrect =
                        _hasCheckedAnswer && isSelected && !isCorrect;

                    Color borderColor = Colors.grey[300]!;
                    Color backgroundColor = Colors.white;

                    if (showCorrect) {
                      borderColor = Colors.green;
                      backgroundColor = Colors.green.withValues(alpha: 0.1);
                    } else if (showIncorrect) {
                      borderColor = Colors.red;
                      backgroundColor = Colors.red.withValues(alpha: 0.1);
                    } else if (isSelected) {
                      borderColor = const Color(0xFF4361EE);
                      backgroundColor =
                          const Color(0xFF4361EE).withValues(alpha: 0.05);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () => _selectAnswer(index),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            border: Border.all(
                              color: borderColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  currentQuestion.options[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              if (showCorrect)
                                const Icon(Icons.check_circle,
                                    color: Colors.green),
                              if (showIncorrect)
                                const Icon(Icons.cancel, color: Colors.red),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  if (_hasCheckedAnswer &&
                      currentQuestion.explanation != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue[200]!,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('💡', style: TextStyle(fontSize: 20)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              currentQuestion.explanation!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[900],
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Bottom Button
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _hasCheckedAnswer ? _nextQuestion : _checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4361EE),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  _hasCheckedAnswer
                      ? (_currentQuestionIndex < _questions.length - 1
                          ? 'Next Question'
                          : 'Finish Quiz')
                      : 'Check Answer',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
