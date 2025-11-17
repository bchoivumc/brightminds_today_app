class QuizResult {
  final DateTime date;
  final int score;
  final int totalQuestions;
  final List<QuestionAnswer> answers;

  QuizResult({
    required this.date,
    required this.score,
    required this.totalQuestions,
    required this.answers,
  });

  double get percentage => (score / totalQuestions) * 100;

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'score': score,
        'totalQuestions': totalQuestions,
        'answers': answers.map((a) => a.toJson()).toList(),
      };

  factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
        date: DateTime.parse(json['date']),
        score: json['score'],
        totalQuestions: json['totalQuestions'],
        answers: (json['answers'] as List)
            .map((a) => QuestionAnswer.fromJson(a))
            .toList(),
      );
}

class QuestionAnswer {
  final String questionId;
  final String question;
  final int selectedAnswerIndex;
  final int correctAnswerIndex;
  final bool isCorrect;

  QuestionAnswer({
    required this.questionId,
    required this.question,
    required this.selectedAnswerIndex,
    required this.correctAnswerIndex,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'question': question,
        'selectedAnswerIndex': selectedAnswerIndex,
        'correctAnswerIndex': correctAnswerIndex,
        'isCorrect': isCorrect,
      };

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
        questionId: json['questionId'],
        question: json['question'],
        selectedAnswerIndex: json['selectedAnswerIndex'],
        correctAnswerIndex: json['correctAnswerIndex'],
        isCorrect: json['isCorrect'],
      );
}
