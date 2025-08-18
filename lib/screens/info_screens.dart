import 'package:flutter/material.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  bool _isArabic = false;

  static const String _enText =
      'Dash Math Learning App is a fun and interactive mobile application created to help children between the ages of 4–12 master multiplication tables in an engaging way.\n\n'
      'Inspired by gamified learning platforms like Duolingo, the app turns math practice into a playful adventure where kids can earn stars, keep lives, unlock achievements, and track progress while learning tables from 2 to 12.\n\n'
      'With a colorful kid-friendly design, smooth animations, and the cheerful Dash mascot, the app makes math enjoyable, motivating children to practice more often and build confidence in their skills.\n\n'
      'Our mission is simple:\n\n'
      '✨ Make math learning fun, easy, and rewarding for kids everywhere.';

  static const String _arText =
      'تطبيق Dash Math Learning هو تطبيق جوّال ممتع وتفاعلي صُمّم لمساعدة الأطفال بين سن 4–12 على إتقان جداول الضرب بطريقة مشوّقة.\n\n'
      'مستوحى من منصات التعلّم المعتمدة على التلعيب مثل Duolingo، يحوّل التطبيق ممارسة الرياضيات إلى مغامرة ممتعة حيث يمكن للأطفال كسب النجوم، والحفاظ على القلوب، وفتح الإنجازات، وتتبع التقدّم أثناء تعلّم الجداول من 2 إلى 12.\n\n'
      'بتصميم ملوّن مناسب للأطفال، ورسوميات سلسة، ودمية Dash المرحة، يجعل التطبيق الرياضيات أكثر متعة ويحفّز الأطفال على التدريب أكثر وبناء الثقة في مهاراتهم.\n\n'
      'مهمتنا بسيطة:\n\n'
      '✨ جعل تعلّم الرياضيات ممتعًا وسهلًا ومجزياً للأطفال في كل مكان.';

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFBBDEFB),
              Color(0xFF90CAF9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back, color: const Color(0xFF1976D2), size: isTablet ? 30 : 26),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'About the App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTablet ? 26 : 22,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1976D2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildLangButton(context, label: 'English', selected: !_isArabic, onTap: () {
                              setState(() => _isArabic = false);
                            }),
                            const SizedBox(width: 10),
                            _buildLangButton(context, label: 'العربية', selected: _isArabic, onTap: () {
                              setState(() => _isArabic = true);
                            }),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          switchInCurve: Curves.easeIn,
                          switchOutCurve: Curves.easeOut,
                          child: Directionality(
                            key: ValueKey(_isArabic),
                            textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
                            child: Text(
                              _isArabic ? _arText : _enText,
                              style: TextStyle(
                                fontSize: isTablet ? 20 : 16,
                                height: 1.6,
                                color: const Color(0xFF37474F),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLangButton(BuildContext context, {required String label, required bool selected, required VoidCallback onTap}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? const Color(0xFF1976D2) : Colors.white,
          foregroundColor: selected ? Colors.white : const Color(0xFF1976D2),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFF1976D2), width: 2),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class AboutDeveloperScreen extends StatelessWidget {
  const AboutDeveloperScreen({super.key});

  static const String _text =
      'This app was created by Mustafa Adil, a dedicated Mathematics and ICT teacher with a passion for making learning interactive and enjoyable for students. '
      'With years of experience in teaching and technology, I combine my background in education with modern app development to design tools that support children in building strong foundations in math.';

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    return _InfoScaffold(
      title: 'About the Developer',
      icon: Icons.school,
      gradientColors: const [Color(0xFFF3E5F5), Color(0xFFE1BEE7), Color(0xFFCE93D8)],
      child: Text(
        _text,
        style: TextStyle(
          fontSize: isTablet ? 20 : 16,
          height: 1.6,
          color: const Color(0xFF37474F),
        ),
      ),
    );
  }
}

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  static const String _text =
      'Looking ahead, I aim to expand these efforts beyond mathematics to other subjects such as Science, ICT, and Languages. '
      'Planned features include interactive virtual 3D science labs, digital flashcards for quick revision, gamified quizzes, and collaborative learning platforms—all designed to encourage active participation and make learning both innovative and effective.';

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    return _InfoScaffold(
      title: 'Future Vision',
      icon: Icons.emoji_events,
      gradientColors: const [Color(0xFFE8F5E9), Color(0xFFC8E6C9), Color(0xFFA5D6A7)],
      child: Text(
        _text,
        style: TextStyle(
          fontSize: isTablet ? 20 : 16,
          height: 1.6,
          color: const Color(0xFF37474F),
        ),
      ),
    );
  }
}

class _InfoScaffold extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradientColors;
  final Widget child;

  const _InfoScaffold({
    required this.title,
    required this.icon,
    required this.gradientColors,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back, color: gradientColors.last, size: isTablet ? 30 : 26),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, color: gradientColors.last, size: isTablet ? 26 : 22),
                          const SizedBox(width: 8),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: isTablet ? 24 : 20,
                              fontWeight: FontWeight.bold,
                              color: gradientColors.last,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  bool _isArabic = false;

  static const String _enText =
      'Dash Math Learning App is a fun and interactive mobile application created to help children between the ages of 4–12 master multiplication tables in an engaging way.\n\n'
      'Inspired by gamified learning platforms like Duolingo, the app turns math practice into a playful adventure where kids can earn stars, keep lives, unlock achievements, and track progress while learning tables from 2 to 12.\n\n'
      'With a colorful kid-friendly design, smooth animations, and the cheerful Dash mascot, the app makes math enjoyable, motivating children to practice more often and build confidence in their skills.\n\n'
      'Our mission is simple:\n\n'
      '✨ Make math learning fun, easy, and rewarding for kids everywhere.';

  static const String _arText =
      'تطبيق Dash Math Learning هو تطبيق جوّال ممتع وتفاعلي صُمّم لمساعدة الأطفال بين سن 4–12 على إتقان جداول الضرب بطريقة مشوّقة.\n\n'
      'مستوحى من منصات التعلّم المعتمدة على التلعيب مثل Duolingo، يحوّل التطبيق ممارسة الرياضيات إلى مغامرة ممتعة حيث يمكن للأطفال كسب النجوم، والحفاظ على القلوب، وفتح الإنجازات، وتتبع التقدّم أثناء تعلّم الجداول من 2 إلى 12.\n\n'
      'بتصميم ملوّن مناسب للأطفال، ورسوميات سلسة، ودمية Dash المرحة، يجعل التطبيق الرياضيات أكثر متعة ويحفّز الأطفال على التدريب أكثر وبناء الثقة في مهاراتهم.\n\n'
      'مهمتنا بسيطة:\n\n'
      '✨ جعل تعلّم الرياضيات ممتعًا وسهلًا ومجزياً للأطفال في كل مكان.';

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFBBDEFB),
              Color(0xFF90CAF9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back, color: const Color(0xFF1976D2), size: isTablet ? 30 : 26),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'About the App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTablet ? 26 : 22,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1976D2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildLangButton(context, label: 'English', selected: !_isArabic, onTap: () {
                              setState(() => _isArabic = false);
                            }),
                            const SizedBox(width: 10),
                            _buildLangButton(context, label: 'العربية', selected: _isArabic, onTap: () {
                              setState(() => _isArabic = true);
                            }),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          switchInCurve: Curves.easeIn,
                          switchOutCurve: Curves.easeOut,
                          child: Directionality(
                            key: ValueKey(_isArabic),
                            textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
                            child: Text(
                              _isArabic ? _arText : _enText,
                              style: TextStyle(
                                fontSize: isTablet ? 20 : 16,
                                height: 1.6,
                                color: const Color(0xFF37474F),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLangButton(BuildContext context, {required String label, required bool selected, required VoidCallback onTap}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? const Color(0xFF1976D2) : Colors.white,
          foregroundColor: selected ? Colors.white : const Color(0xFF1976D2),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFF1976D2), width: 2),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class AboutDeveloperScreen extends StatelessWidget {
  const AboutDeveloperScreen({super.key});

  static const String _text =
      'This app was created by Mustafa Adil, a dedicated Mathematics and ICT teacher with a passion for making learning interactive and enjoyable for students. '
      'With years of experience in teaching and technology, I combine my background in education with modern app development to design tools that support children in building strong foundations in math.';

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    return _InfoScaffold(
      title: 'About the Developer',
      icon: Icons.school,
      gradientColors: const [Color(0xFFF3E5F5), Color(0xFFE1BEE7), Color(0xFFCE93D8)],
      child: Text(
        _text,
        style: TextStyle(
          fontSize: isTablet ? 20 : 16,
          height: 1.6,
          color: const Color(0xFF37474F),
        ),
      ),
    );
  }
}

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  static const String _text =
      'Looking ahead, I aim to expand these efforts beyond mathematics to other subjects such as Science, ICT, and Languages. '
      'Planned features include interactive virtual 3D science labs, digital flashcards for quick revision, gamified quizzes, and collaborative learning platforms—all designed to encourage active participation and make learning both innovative and effective.';

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    return _InfoScaffold(
      title: 'Future Vision',
      icon: Icons.emoji_events,
      gradientColors: const [Color(0xFFE8F5E9), Color(0xFFC8E6C9), Color(0xFFA5D6A7)],
      child: Text(
        _text,
        style: TextStyle(
          fontSize: isTablet ? 20 : 16,
          height: 1.6,
          color: const Color(0xFF37474F),
        ),
      ),
    );
  }
}

class _InfoScaffold extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradientColors;
  final Widget child;

  const _InfoScaffold({
    required this.title,
    required this.icon,
    required this.gradientColors,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back, color: gradientColors.last, size: isTablet ? 30 : 26),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, color: gradientColors.last, size: isTablet ? 26 : 22),
                          const SizedBox(width: 8),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: isTablet ? 24 : 20,
                              fontWeight: FontWeight.bold,
                              color: gradientColors.last,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

