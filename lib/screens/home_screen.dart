import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'favorites_screen.dart';
import 'search_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const FavoritesScreen(),
    const SearchScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "lib/assets/img/logo.png", // PNG-Logo als Titel
          height: 80, // Höhe anpassen je nach Bedarf
          fit: BoxFit.contain,
          // Optional: Fehlerbehandlung falls Bild nicht gefunden wird
          errorBuilder: (context, error, stackTrace) {
            return const Text(
              'Who Plays',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            );
          },
        ),
        centerTitle: true, // Zentriert das Logo
        backgroundColor: isDark ? Colors.black : const Color.fromRGBO(255, 135, 83, 1),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: isDark ? Colors.black : const Color.fromRGBO(255, 135, 83, 1),
        selectedItemColor: isDark ? const Color.fromRGBO(255, 135, 83, 1) : Colors.black,
        unselectedItemColor: isDark ? Colors.white54 : const Color.fromARGB(115, 0, 0, 0),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}