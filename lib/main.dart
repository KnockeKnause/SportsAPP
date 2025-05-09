// Created by: [Lukas]

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// App root
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Sports',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        cardColor: const Color(0xFF121212),
        primaryColor: Colors.blueAccent,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF111111),
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
          headlineLarge: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        ),
      ),
      home: const HomePage(),
    );
  }
}

/// Data model for one fixture
class Fixture {
  final IconData icon;
  final String home, away, time;
  const Fixture({
    required this.icon,
    required this.home,
    required this.away,
    required this.time,
  });
}

/// Dummy data until the API is wired up
const fixtures = [
  Fixture(
    icon: Icons.sports_basketball,
    home: 'Lakers',
    away: 'Warriors',
    time: '7:00 pm',
  ),
  Fixture(
    icon: Icons.sports_soccer,
    home: 'Liverpool',
    away: 'Chelsea',
    time: '8:30 pm',
  ),
  Fixture(
    icon: Icons.sports_hockey,
    home: 'Capitals',
    away: 'Bruins',
    time: '9:00 pm',
  ),
  Fixture(
    icon: Icons.sports,
    home: 'Van Gerwen',
    away: 'Wright',
    time: '10:00 pm',
  ),
  Fixture(
    icon: Icons.sports_tennis,
    home: 'Zverev',
    away: 'Djokovic',
    time: '10:30 pm',
  ),
];

/// SPORT ➔ LIST OF LEAGUES mapping
const Map<String, List<String>> kLeagueLookup = {
  'Basketball': ['NBA', 'BBL 1', 'BBL 2', 'National Teams'],
  'Football': [
    '1. Bundesliga',
    '2. Bundesliga',
    '3. Bundesliga',
    'Premier League',
    'National Teams',
  ],
};

/// Wrapper that holds the BottomNavigationBar and switches between pages
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [SchedulePage(), FavouritesPage(), AlertsPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Favourite Teams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Manage Alerts',
          ),
        ],
      ),
    );
  }
}

/// PAGE 1 – Schedule list (mock‑up screen)
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Sports', style: t.textTheme.headlineLarge),
            const SizedBox(height: 8),
            Text("Today's Favourites", style: t.textTheme.bodyMedium),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: t.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: fixtures.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 24),
                  itemBuilder: (context, i) {
                    final g = fixtures[i];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white10,
                          child: Icon(g.icon, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(g.home, style: t.textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Text(
                                'vs ${g.away}',
                                style: t.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 2),
                              Text(g.time, style: t.textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// PAGE 2 – Favourite Teams with search bar and league navigation
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  final _controller = TextEditingController();
  String _query = '';

  final _sports = [
    {'name': 'Basketball', 'icon': Icons.sports_basketball},
    {'name': 'Football', 'icon': Icons.sports_soccer},
    {'name': 'Ice Hockey', 'icon': Icons.sports_hockey},
    {'name': 'Darts', 'icon': Icons.sports},
    {'name': 'Tennis', 'icon': Icons.sports_tennis},
  ];

  final Set<int> _selected = {};

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final visibleSports =
        _sports
            .where(
              (s) => (s['name'] as String).toLowerCase().contains(
                _query.toLowerCase(),
              ),
            )
            .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (val) => setState(() => _query = val),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search sports…',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: t.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: visibleSports.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final s = visibleSports[i];
                  final originalIndex = _sports.indexWhere(
                    (e) => e['name'] == s['name'],
                  );
                  final isSelected = _selected.contains(originalIndex);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected
                            ? _selected.remove(originalIndex)
                            : _selected.add(originalIndex);
                      });
                      final sportName = s['name'] as String;
                      if (kLeagueLookup.containsKey(sportName)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => LeaguesPage(
                                  sport: sportName,
                                  leagues: kLeagueLookup[sportName]!,
                                ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? t.primaryColor.withOpacity(0.15)
                                : t.cardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Icon(s['icon'] as IconData, color: Colors.white),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              s['name'] as String,
                              style: t.textTheme.titleMedium,
                            ),
                          ),
                          if (isSelected)
                            const Icon(Icons.check, color: Colors.blueAccent),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// PAGE – Shows list of leagues for a sport
class LeaguesPage extends StatelessWidget {
  final String sport;
  final List<String> leagues;
  const LeaguesPage({super.key, required this.sport, required this.leagues});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('$sport Leagues'),
        backgroundColor: Colors.black,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: leagues.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          return Container(
            decoration: BoxDecoration(
              color: t.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(leagues[i], style: t.textTheme.titleMedium),
          );
        },
      ),
    );
  }
}

/// PAGE 3 – Alerts placeholder
class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return SafeArea(
      child: Center(
        child: Text(
          'Alerts Page – coming soon',
          style: t.textTheme.titleMedium,
        ),
      ),
    );
  }
}
