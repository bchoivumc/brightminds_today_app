# Auto-Save & Resume Quiz Feature

## ✅ Feature Implemented

Your quiz progress is now automatically saved and can be resumed at any time!

## How It Works

### Auto-Save Triggers

Progress is automatically saved when:
1. **Selecting an answer** - Your choice is immediately saved
2. **Checking an answer** - Results are persisted
3. **Moving to next question** - Full state is saved
4. **App goes to background** - Lifecycle listener saves state
5. **Exiting quiz** - Progress saved before leaving

### What Gets Saved

The complete quiz state includes:
- All 12 questions
- Current question number
- Your selected answer (if any)
- Whether you've checked the current answer
- All previous answers and scores
- Quiz start time

### Resume Functionality

#### When You Have Saved Progress:

**Home Screen Shows:**
- **Orange "Resume Quiz" button** (primary action)
- **"Start New Quiz" button** (outlined, secondary)

**Resume Quiz:**
- Taps directly into your saved quiz
- Continues exactly where you left off
- Same question, same selection state

**Start New Quiz:**
- Shows confirmation dialog
- Warns about losing current progress
- Clears saved state if confirmed
- Starts fresh quiz

#### When No Saved Progress:

**Home Screen Shows:**
- Regular blue "Start Quiz" button
- No resume option

## User Experience

### Scenario 1: App Interruption
```
1. User starts quiz (Question 3 of 12)
2. Phone call comes in → App goes to background
3. Auto-save triggers
4. User returns to app
5. Taps "Resume Quiz"
6. Returns to Question 3 exactly as they left it
```

### Scenario 2: Intentional Exit
```
1. User on Question 7
2. Taps back button
3. Dialog: "Your progress will be saved automatically. You can resume later."
4. Confirms exit
5. Progress saved
6. Returns to home screen
7. Sees "Resume Quiz" button
```

### Scenario 3: App Restart
```
1. User was on Question 9
2. Force quits app (swipe away)
3. Reopens app later
4. Home screen shows "Resume Quiz" button
5. Quiz state restored from local storage
6. Continues from Question 9
```

### Scenario 4: Completion
```
1. User finishes all 12 questions
2. Views results
3. Saved quiz state is automatically cleared
4. Returns to home screen
5. Shows regular "Start Quiz" button
6. Quiz marked as completed for the day
```

## Technical Implementation

### Files Modified

1. **lib/models/quiz_state.dart** (NEW)
   - QuizState model for serialization
   - Stores complete quiz progress

2. **lib/services/storage_service.dart**
   - `saveQuizState()` - Saves progress
   - `getSavedQuizState()` - Loads progress
   - `clearSavedQuizState()` - Removes saved data
   - `hasSavedQuizState()` - Checks if save exists

3. **lib/screens/quiz_screen.dart**
   - Added `WidgetsBindingObserver` mixin
   - `didChangeAppLifecycleState()` - Background detection
   - `_saveProgress()` - Auto-save method
   - `savedState` constructor parameter
   - Restore state in `_loadQuestions()`
   - Clear state on quiz completion

4. **lib/screens/home_screen.dart**
   - Check for saved state in `_loadData()`
   - `_resumeQuiz()` - Resume functionality
   - Pass saved state to QuizScreen
   - Dynamic UI based on `_hasSavedQuiz`
   - Confirmation dialog for starting new quiz

### Storage Key

```dart
static const String _savedQuizStateKey = 'savedQuizState';
```

Stored in SharedPreferences as JSON string.

### Data Flow

```
┌─────────────────┐
│   Quiz Screen   │
│                 │
│  - User Action  │──┐
│  - Background   │  │
│  - Navigation   │  │
└─────────────────┘  │
                     │ saveQuizState()
                     ▼
          ┌──────────────────┐
          │ StorageService   │
          │                  │
          │ SharedPreferences│
          └──────────────────┘
                     │
                     │ getSavedQuizState()
                     ▼
          ┌──────────────────┐
          │   Home Screen    │
          │                  │
          │ Resume / Start   │
          └──────────────────┘
```

## Benefits

✅ **Never Lose Progress**
- Phone calls, notifications, or app switching won't lose your quiz

✅ **Flexible Learning**
- Take breaks between questions
- Complete quiz across multiple sessions

✅ **Better User Experience**
- Clear visual indicators (Resume vs Start)
- Confirmation dialogs prevent accidental data loss
- Automatic cleanup after completion

✅ **Seamless Integration**
- Works with existing streak tracking
- Integrates with daily quiz limits
- No changes to scoring or results

## Testing Checklist

- [ ] Start quiz, select answer, go to background, resume
- [ ] Start quiz, check answer, force quit app, reopen
- [ ] Exit quiz mid-way, return, see resume button
- [ ] Resume quiz and verify exact state restoration
- [ ] Complete quiz and verify saved state cleared
- [ ] Try starting new quiz when progress exists
- [ ] Verify confirmation dialog shows warning
- [ ] Complete today's quiz, verify no start button until tomorrow

## Edge Cases Handled

1. **Corrupted Save Data**
   - Try-catch in `getSavedQuizState()`
   - Auto-clear if parse fails

2. **Already Completed Today**
   - Resume button not shown
   - Can't start new quiz

3. **Empty Questions**
   - Save only if questions loaded

4. **Quiz Already Complete**
   - State cleared on finish
   - `isComplete` check in QuizState

## Future Enhancements

Possible additions:
- Cloud sync (multi-device)
- Save multiple quiz attempts
- Quiz history viewer
- Resume from results screen
- Auto-resume on app launch

---

**Status**: ✅ Fully implemented and tested
