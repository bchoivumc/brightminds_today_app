import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_result.dart';
import '../models/quiz_state.dart';

class StorageService {
  static const String _streakKey = 'streak';
  static const String _lastCompletedDateKey = 'lastCompletedDate';
  static const String _totalCompletionsKey = 'totalCompletions';
  static const String _quizResultsKey = 'quizResults';
  static const String _currentDayIndexKey = 'currentDayIndex';
  static const String _savedQuizStateKey = 'savedQuizState';

  Future<void> saveQuizResult(QuizResult result) async {
    final prefs = await SharedPreferences.getInstance();

    // Save the result
    final results = await getQuizResults();
    results.add(result);
    final resultsJson = results.map((r) => r.toJson()).toList();
    await prefs.setString(_quizResultsKey, jsonEncode(resultsJson));

    // Update streak
    await _updateStreak();

    // Increment total completions
    final totalCompletions = await getTotalCompletions();
    await prefs.setInt(_totalCompletionsKey, totalCompletions + 1);

    // Update last completed date
    await prefs.setString(
      _lastCompletedDateKey,
      DateTime.now().toIso8601String(),
    );
  }

  Future<List<QuizResult>> getQuizResults() async {
    final prefs = await SharedPreferences.getInstance();
    final resultsString = prefs.getString(_quizResultsKey);

    if (resultsString == null) return [];

    final List<dynamic> resultsJson = jsonDecode(resultsString);
    return resultsJson.map((json) => QuizResult.fromJson(json)).toList();
  }

  Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_streakKey) ?? 0;
  }

  Future<int> getTotalCompletions() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_totalCompletionsKey) ?? 0;
  }

  Future<DateTime?> getLastCompletedDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString(_lastCompletedDateKey);

    if (dateString == null) return null;

    return DateTime.parse(dateString);
  }

  Future<bool> hasCompletedToday() async {
    final lastCompleted = await getLastCompletedDate();

    if (lastCompleted == null) return false;

    final today = DateTime.now();
    return lastCompleted.year == today.year &&
        lastCompleted.month == today.month &&
        lastCompleted.day == today.day;
  }

  Future<void> _updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final lastCompleted = await getLastCompletedDate();
    final currentStreak = await getStreak();

    if (lastCompleted == null) {
      // First time completing
      await prefs.setInt(_streakKey, 1);
      return;
    }

    final now = DateTime.now();
    final lastDate = DateTime(
      lastCompleted.year,
      lastCompleted.month,
      lastCompleted.day,
    );
    final today = DateTime(now.year, now.month, now.day);
    final difference = today.difference(lastDate).inDays;

    if (difference == 0) {
      // Already completed today, don't update streak
      return;
    } else if (difference == 1) {
      // Consecutive day
      await prefs.setInt(_streakKey, currentStreak + 1);
    } else {
      // Streak broken
      await prefs.setInt(_streakKey, 1);
    }
  }

  Future<int> getCurrentDayIndex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_currentDayIndexKey) ?? 0;
  }

  Future<void> incrementDayIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final currentIndex = await getCurrentDayIndex();
    await prefs.setInt(_currentDayIndexKey, currentIndex + 1);
  }

  Future<void> resetAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Quiz state management
  Future<void> saveQuizState(QuizState state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_savedQuizStateKey, jsonEncode(state.toJson()));
  }

  Future<QuizState?> getSavedQuizState() async {
    final prefs = await SharedPreferences.getInstance();
    final stateString = prefs.getString(_savedQuizStateKey);

    if (stateString == null) return null;

    try {
      final stateJson = jsonDecode(stateString);
      return QuizState.fromJson(stateJson);
    } catch (e) {
      // If there's an error parsing, clear the saved state
      await clearSavedQuizState();
      return null;
    }
  }

  Future<void> clearSavedQuizState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_savedQuizStateKey);
  }

  Future<bool> hasSavedQuizState() async {
    final state = await getSavedQuizState();
    return state != null;
  }
}
