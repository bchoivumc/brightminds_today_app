import 'question.dart';
import 'quiz_result.dart';

class QuizState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final int? selectedAnswerIndex;
  final bool hasCheckedAnswer;
  final List<QuestionAnswer> answers;
  final DateTime startedAt;

  QuizState({
    required this.questions,
    required this.currentQuestionIndex,
    this.selectedAnswerIndex,
    required this.hasCheckedAnswer,
    required this.answers,
    required this.startedAt,
  });

  Map<String, dynamic> toJson() => {
        'questions': questions.map((q) => q.toJson()).toList(),
        'currentQuestionIndex': currentQuestionIndex,
        'selectedAnswerIndex': selectedAnswerIndex,
        'hasCheckedAnswer': hasCheckedAnswer,
        'answers': answers.map((a) => a.toJson()).toList(),
        'startedAt': startedAt.toIso8601String(),
      };

  factory QuizState.fromJson(Map<String, dynamic> json) => QuizState(
        questions: (json['questions'] as List)
            .map((q) => Question.fromJson(q))
            .toList(),
        currentQuestionIndex: json['currentQuestionIndex'],
        selectedAnswerIndex: json['selectedAnswerIndex'],
        hasCheckedAnswer: json['hasCheckedAnswer'],
        answers: (json['answers'] as List)
            .map((a) => QuestionAnswer.fromJson(a))
            .toList(),
        startedAt: DateTime.parse(json['startedAt']),
      );

  bool get isComplete => currentQuestionIndex >= questions.length;
}
