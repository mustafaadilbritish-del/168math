import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lesson_screen.dart';
import 'screens/info_screens.dart';

void main() {
  runApp(const DashMathApp());
}

class DashMathApp extends StatelessWidget {
  const DashMathApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set preferred orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Dash Math Learning',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/lesson': (context) => const LessonScreen(),
        '/about_app': (context) => const AboutAppScreen(),
        '/about_developer': (context) => const AboutDeveloperScreen(),
        '/roadmap': (context) => const RoadmapScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
