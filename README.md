# Dash Math Learning App

A responsive Flutter mobile application designed to teach multiplication tables (2-12) to children aged 4-10, inspired by gamified learning experiences like Duolingo.

## 🌟 Features

### Core Learning Experience
- **Multiplication Tables**: Complete coverage of times tables from 2 to 12
- **Interactive Questions**: Three different question types:
  - Type the Answer: Fill-in-the-blank format with number input
  - Multiple Choice: Select from 4 answer choices
  - Follow the Pattern: Complete division patterns to find the answer
- **Adaptive Difficulty**: Questions are randomized for variety
- **Progress Tracking**: Visual progress bars for each multiplication table

### Gamification Elements
- **Lives System**: 5 hearts that decrease with wrong answers
- **Star Rewards**: Earn stars for correct answers
- **Progress Visualization**: Color-coded progress bars for each table
- **Achievement Tracking**: Completion status for each table

### User Experience
- **Responsive Design**: Optimized for both phone and tablet screen sizes
- **Kid-Friendly UI**: Colorful, engaging interface with large touch targets
- **Character Companion**: Dash character provides visual feedback
- **Smooth Animations**: Flutter animations for engaging interactions
- **Immediate Feedback**: Instant visual feedback for correct/incorrect answers

### Visual Design
- **Dash Character**: Friendly blue mascot as app icon and companion
- **Vibrant Colors**: Each multiplication table has its own color theme
- **Modern UI**: Material Design components with custom styling
- **Gradient Backgrounds**: Beautiful gradient backgrounds throughout

## 🎮 How to Play

1. **Launch App**: Start with animated splash screen featuring Dash
2. **Select Table**: Choose a multiplication table to practice (2-12)
3. **Answer Questions**: Solve 12 randomized questions for each table
4. **Earn Stars**: Get stars for correct answers
5. **Track Progress**: Watch your progress grow with visual indicators
6. **Complete Tables**: Finish all questions to mark a table as complete

## 📱 Responsive Design

The application adapts to different screen sizes:

- **Phone (< 600px width)**: Optimized touch interface with appropriate sizing
- **Tablet (≥ 600px width)**: Enhanced layout with larger elements and better spacing
- **Portrait Orientation**: Locked to portrait mode for consistent experience

## 🛠 Technology Stack

- **Framework**: Flutter 3.24.5
- **Language**: Dart 3.5.4
- **State Management**: StatefulWidget with local state
- **Animations**: Flutter's built-in animation system
- **Icons**: Material Icons and custom app icons
- **Responsive Design**: MediaQuery-based responsive layouts

## 🏗 Building and Running

### Prerequisites
- Flutter SDK 3.24.5 or later
- Dart SDK 3.5.4 or later
- Android Studio / VS Code with Flutter extensions

### Development Setup
```bash
# Install dependencies
flutter pub get

# Generate app icons
flutter pub run flutter_launcher_icons

# Run the app
flutter run
```

### Building for Production
```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS (requires macOS and Xcode)
flutter build ios --release
```

## 📊 Learning Analytics

The app tracks:
- Questions answered correctly/incorrectly per table
- Overall progress percentage for each table
- Stars earned per correct answer
- Completion status for each multiplication table
- Lives remaining during lessons

## 🎯 Educational Goals

- **Multiplication Mastery**: Focus on times tables 2-12
- **Pattern Recognition**: Follow-the-pattern questions help identify mathematical patterns
- **Mental Math**: Quick recall of multiplication facts
- **Confidence Building**: Positive reinforcement through stars and progress tracking
- **Adaptive Learning**: Randomized questions prevent memorization of question order

---

Made with ❤️ for young learners everywhere using Flutter!
