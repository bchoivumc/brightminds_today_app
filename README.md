# BrightMinds 🧠

A Flutter quiz app for biblical logic training with daily challenges, streaks, and rankings.

## Features

### 📱 Core Features
- **Splash Animation**: Eye-catching animated splash screen with smooth transitions
- **Daily Quizzes**: 12 biblical logic questions refreshed daily
- **Check Answers**: Review each answer before moving to the next question
- **Question Explanations**: Learn from detailed explanations for each question
- **Progress Tracking**: Visual progress indicator showing quiz completion

### 🔥 Streak System
- Track consecutive days of quiz completion
- Streak counter displayed prominently on home screen
- Prevents streak loss by encouraging daily engagement
- One quiz per day limit to maintain quality learning

### 🏆 Ranking System
- 6 ranking levels based on total completions:
  - 📚 **Beginner Scholar** (0-19 completions)
  - 🔍 **Knowledge Seeker** (20-39 completions)
  - 🎯 **Wisdom Hunter** (40-59 completions)
  - ⭐ **Scripture Expert** (60-79 completions)
  - 🏆 **Bible Master** (80-99 completions)
  - 👑 **Divine Champion** (100+ completions)
- Progress bar showing advancement to next rank
- Every 20 completions unlocks a new ranking level

### 🔔 Daily Reminders
- Customizable notification time
- Daily reminder to complete quiz
- Helps maintain streaks and consistency
- Easy to enable/disable in settings

### 📊 Results & Sharing
- Detailed score breakdown after each quiz
- Review all questions with correct/incorrect indicators
- Share achievements with friends
- Track total completions and current ranking

### 💾 Local Storage
- All data stored locally using SharedPreferences
- Tracks quiz history, streaks, and completions
- No internet required after initial install
- Option to reset all progress

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   ├── question.dart           # Question data model
│   ├── quiz_result.dart        # Quiz result and answer models
│   └── ranking.dart            # Ranking system logic
├── services/
│   ├── storage_service.dart    # Local data persistence
│   ├── question_service.dart   # Question management
│   └── notification_service.dart # Daily reminder notifications
└── screens/
    ├── splash_screen.dart      # Animated splash screen
    ├── home_screen.dart        # Main dashboard
    ├── quiz_screen.dart        # Quiz interface
    ├── results_screen.dart     # Results and review
    └── settings_screen.dart    # App settings
```

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- iOS Simulator or Android Emulator (or physical device)

### Installation

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### iOS
For notifications to work on iOS, ensure you have the proper permissions in `Info.plist`:
```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
```

#### Android
Notifications should work out of the box with the flutter_local_notifications package.

## Dependencies

- `shared_preferences` - Local data storage
- `flutter_local_notifications` - Daily reminder notifications
- `timezone` - Notification scheduling
- `intl` - Date formatting
- `share_plus` - Share results functionality

## Customization

### Adding More Questions

Edit [lib/services/question_service.dart](lib/services/question_service.dart) to add more question sets. Each question set contains 12 questions that rotate daily.

Example:
```dart
Question(
  id: 'unique_id',
  question: 'Your question text',
  options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
  correctAnswerIndex: 1, // 0-based index
  explanation: 'Explanation of the correct answer',
)
```

### Customizing Colors

The primary color scheme is defined in [lib/main.dart](lib/main.dart):
```dart
seedColor: const Color(0xFF4361EE), // Blue theme
```

### Adjusting Ranking Levels

Modify [lib/models/ranking.dart](lib/models/ranking.dart) to change ranking thresholds, titles, or emojis.

## Design

The app follows a clean, modern design with:
- **Primary Color**: Blue (#4361EE)
- **Typography**: System default font for optimal readability
- **Layout**: Card-based design with rounded corners
- **Animations**: Smooth transitions and scale animations
- **Icons**: Emoji-based for universal appeal

Design reference based on [resource_materials/sample_quiz_design.png](resource_materials/sample_quiz_design.png)

## Data Flow

1. User opens app → Splash screen (3 seconds)
2. Navigate to Home screen → Display streak and ranking
3. Start Quiz → Load 12 daily questions
4. Answer questions → Check answer before proceeding
5. Complete quiz → Save results and update streak
6. View results → Review performance and share

## Future Enhancements

Potential features to add:
- Question categories (Old Testament, New Testament, etc.)
- Difficulty levels
- Weekly/monthly statistics
- Achievement badges
- Leaderboard (with backend)
- Question submission by users
- Audio explanations
- Dark mode theme

## License

This project is created for educational purposes.

## Support

For issues or questions, refer to the resource materials in the `resource_materials/` folder.
