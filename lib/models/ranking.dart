class Ranking {
  final String title;
  final String emoji;
  final int minCompletions;
  final int maxCompletions;

  Ranking({
    required this.title,
    required this.emoji,
    required this.minCompletions,
    required this.maxCompletions,
  });

  static List<Ranking> get allRankings => [
        Ranking(
          title: 'Beginner Scholar',
          emoji: '📚',
          minCompletions: 0,
          maxCompletions: 19,
        ),
        Ranking(
          title: 'Knowledge Seeker',
          emoji: '🔍',
          minCompletions: 20,
          maxCompletions: 39,
        ),
        Ranking(
          title: 'Wisdom Hunter',
          emoji: '🎯',
          minCompletions: 40,
          maxCompletions: 59,
        ),
        Ranking(
          title: 'Scripture Expert',
          emoji: '⭐',
          minCompletions: 60,
          maxCompletions: 79,
        ),
        Ranking(
          title: 'Bible Master',
          emoji: '🏆',
          minCompletions: 80,
          maxCompletions: 99,
        ),
        Ranking(
          title: 'Divine Champion',
          emoji: '👑',
          minCompletions: 100,
          maxCompletions: 999999,
        ),
      ];

  static Ranking getRankingForCompletions(int completions) {
    return allRankings.firstWhere(
      (ranking) =>
          completions >= ranking.minCompletions &&
          completions <= ranking.maxCompletions,
      orElse: () => allRankings.first,
    );
  }

  static Ranking? getNextRanking(int completions) {
    final currentIndex = allRankings.indexWhere(
      (ranking) =>
          completions >= ranking.minCompletions &&
          completions <= ranking.maxCompletions,
    );

    if (currentIndex == -1 || currentIndex == allRankings.length - 1) {
      return null;
    }

    return allRankings[currentIndex + 1];
  }

  int getProgressToNext(int completions) {
    return completions - minCompletions;
  }

  int getTotalNeededForRank() {
    return maxCompletions - minCompletions + 1;
  }
}
