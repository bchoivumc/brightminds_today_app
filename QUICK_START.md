# BrightMinds - Quick Start Guide 🚀

## What Was Built

A complete Flutter quiz app with the following features:

### ✅ Implemented Features

1. **Splash Screen** - Animated intro with BrightMinds logo
2. **Home Screen** - Displays streak, ranking, and daily quiz button
3. **Quiz Interface** - 12 daily questions with "Check Answer" functionality
4. **Results Screen** - Score display, per-question review, and share option
5. **Settings Screen** - Daily reminder notifications configuration
6. **Streak Tracking** - Consecutive days counter with local storage
7. **Ranking System** - 6 levels (every 20 completions = new rank)
8. **Local Storage** - All progress saved locally
9. **Daily Reminders** - Customizable notification time
10. **Share Functionality** - Share your achievements

## Run the App

```bash
# Make sure dependencies are installed
flutter pub get

# Run on connected device or simulator
flutter run

# Or run on specific device
flutter run -d <device-id>
```

## App Flow

1. **Launch** → Splash screen (3 seconds)
2. **Home** → View streak, ranking, and start quiz
3. **Quiz** → Answer 12 questions (check each before proceeding)
4. **Results** → Review performance and share
5. **Settings** → Configure daily reminders

## Key Files to Customize

### Add More Questions
Edit: `lib/services/question_service.dart`

```dart
// Add new question sets in the _questionSets list
Question(
  id: 'unique_id',
  question: 'Your biblical logic question?',
  options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
  correctAnswerIndex: 1,
  explanation: 'Explanation text',
)
```

### Modify Rankings
Edit: `lib/models/ranking.dart`

Change the `allRankings` list to adjust:
- Ranking titles
- Emoji icons
- Completion thresholds

### Change Theme Colors
Edit: `lib/main.dart`

```dart
seedColor: const Color(0xFF4361EE), // Change this hex code
```

## Testing the App

### Test Streak System
1. Complete a quiz
2. Check Home screen - streak should show "1 Day Streak"
3. Come back tomorrow to maintain streak
4. Or manually adjust device date to test

### Test Ranking System
- Complete 20 quizzes to advance from "Beginner Scholar" to "Knowledge Seeker"
- Rankings update automatically after each quiz

### Test Notifications
1. Go to Settings
2. Toggle "Daily Reminders"
3. Select a time (e.g., 1 minute from now)
4. Wait for notification

### Test Share Feature
1. Complete a quiz
2. On results screen, tap share icon
3. Share via available apps

## Sample Questions Included

Currently includes 24 biblical logic questions (2 sets of 12):
- **Day 1**: Apostles, parables, prophets, faith & works, love, Scripture inspiration
- **Day 2**: Salvation, blessings, narrow gate, refuge, calling on the Lord, grace

Questions rotate daily based on date calculation.

## Architecture

```
Models (Data Structures)
├── Question - Quiz question with options
├── QuizResult - Score and answer history
└── Ranking - Level system logic

Services (Business Logic)
├── StorageService - Local data persistence
├── QuestionService - Question management
└── NotificationService - Daily reminders

Screens (UI)
├── SplashScreen - Animated intro
├── HomeScreen - Main dashboard
├── QuizScreen - Quiz interface
├── ResultsScreen - Score review
└── SettingsScreen - App settings
```

## Design Highlights

- **Color Scheme**: Blue (#4361EE) primary with gradients
- **Clean Layout**: Card-based with rounded corners
- **Smooth Animations**: Fade, scale transitions
- **Material 3**: Modern Flutter design system
- **Emoji Icons**: Universal, friendly visual language

## Troubleshooting

### Notifications Not Working?

**iOS**: Check that permissions were granted when prompted

**Android**: Should work automatically with flutter_local_notifications

### Streak Not Updating?

- Complete the full quiz (all 12 questions)
- Check results screen appears
- Return to home screen - streak updates on quiz completion

### "Already Completed Today" Message?

- App allows one quiz per day
- Streak data stored locally
- Reset progress in Settings if needed for testing

### Questions Not Loading?

- Ensure `QuestionService` has valid question sets
- Check that each question has 4 options
- Verify correctAnswerIndex is 0-3

## Next Steps

1. **Add More Questions**: Expand the question bank from your PDF resources
2. **Categories**: Group questions by biblical book or topic
3. **Difficulty Levels**: Easy, medium, hard modes
4. **Statistics**: Weekly/monthly performance tracking
5. **Achievements**: Special badges for milestones
6. **Social Features**: Leaderboard with backend integration

## Resources

- Question content: `resource_materials/New Testament Logic Questions - Student Version.pdf`
- Answer key: `resource_materials/New Testament Logic Questions - Answer Key.pdf`
- Design reference: `resource_materials/sample_quiz_design.png`

## Support

For issues:
1. Run `flutter doctor` to check Flutter setup
2. Run `flutter clean && flutter pub get` to reset dependencies
3. Check Flutter version compatibility (3.8.1+)

---

**Built with Flutter 💙**
Ready to deploy to iOS App Store and Google Play Store!
