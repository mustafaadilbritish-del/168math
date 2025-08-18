import 'package:flutter/material.dart';
import '../models/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppState appState = AppState();

  @override
  void initState() {
    super.initState();
    appState.resetLives();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final crossAxisCount = isTablet ? 4 : 3;
    
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
              // Header with Dash character and title
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Dash character
                    Container(
                      width: isTablet ? 80 : 60,
                      height: isTablet ? 80 : 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/dash_character.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 15),
                    
                    // Title and stats
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dash',
                            style: TextStyle(
                              fontSize: isTablet ? 32 : 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1976D2),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: isTablet ? 24 : 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${appState.currentLives}',
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: isTablet ? 24 : 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${appState.totalStars}',
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Multiplication tables grid
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: 11, // Tables 2-12
                    itemBuilder: (context, index) {
                      final tableNumber = index + 2;
                      final progress = appState.tableProgress[tableNumber];
                      final isCompleted = progress?.isCompleted ?? false;
                      final progressValue = progress?.progressPercentage ?? 0.0;
                      
                      return _buildTableButton(
                        context,
                        tableNumber,
                        progressValue,
                        isCompleted,
                        isTablet,
                      );
                    },
                  ),
                ),
              ),
              
              // Bottom decoration with Dash character
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBottomIcon(
                      Icons.school,
                      Colors.blue,
                      isTablet,
                      onTap: () => Navigator.of(context).pushNamed('/about_developer'),
                    ),
                    _buildBottomIcon(
                      Icons.emoji_events,
                      Colors.orange,
                      isTablet,
                      onTap: () => Navigator.of(context).pushNamed('/roadmap'),
                    ),
                    _buildBottomIcon(
                      Icons.person,
                      Colors.green,
                      isTablet,
                      onTap: () => Navigator.of(context).pushNamed('/about_app'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableButton(
    BuildContext context,
    int tableNumber,
    double progress,
    bool isCompleted,
    bool isTablet,
  ) {
    final colors = _getTableColors(tableNumber);
    
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/lesson',
          arguments: tableNumber,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colors[0].withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Table number
            Container(
              width: isTablet ? 60 : 50,
              height: isTablet ? 60 : 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  '$tableNumber',
                  style: TextStyle(
                    fontSize: isTablet ? 28 : 24,
                    fontWeight: FontWeight.bold,
                    color: colors[0],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Progress indicator
            Container(
              width: isTablet ? 80 : 60,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Completion status
            if (isCompleted)
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: isTablet ? 24 : 20,
              )
            else
              Text(
                '${(progress * (appState.tableProgress[tableNumber]?.totalQuestions ?? 30)).round()}/${appState.tableProgress[tableNumber]?.totalQuestions ?? 30}',
                style: TextStyle(
                  fontSize: isTablet ? 14 : 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomIcon(IconData icon, Color color, bool isTablet, {VoidCallback? onTap}) {
    final content = Container(
      width: isTablet ? 60 : 50,
      height: isTablet ? 60 : 50,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        icon,
        color: color,
        size: isTablet ? 30 : 24,
      ),
    );
    if (onTap == null) return content;
    return GestureDetector(onTap: onTap, child: content);
  }

  List<Color> _getTableColors(int tableNumber) {
    final colorMap = {
      2: [const Color(0xFFE57373), const Color(0xFFEF5350)],
      3: [const Color(0xFFFF8A65), const Color(0xFFFF7043)],
      4: [const Color(0xFFFFD54F), const Color(0xFFFFCA28)],
      5: [const Color(0xFF81C784), const Color(0xFF66BB6A)],
      6: [const Color(0xFF64B5F6), const Color(0xFF42A5F5)],
      7: [const Color(0xFF9575CD), const Color(0xFF7E57C2)],
      8: [const Color(0xFFBA68C8), const Color(0xFFAB47BC)],
      9: [const Color(0xFFEC407A), const Color(0xFFE91E63)],
      10: [const Color(0xFF26A69A), const Color(0xFF009688)],
      11: [const Color(0xFF29B6F6), const Color(0xFF03A9F4)],
      12: [const Color(0xFF66BB6A), const Color(0xFF4CAF50)],
    };
    
    return colorMap[tableNumber] ?? [Colors.blue, Colors.blueAccent];
  }
}

