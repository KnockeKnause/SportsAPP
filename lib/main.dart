// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  'Soccer': [
    '1. Bundesliga',
    '2. Bundesliga',
    '3. Bundesliga',
    'Premier League',
    'National Teams',
    'Champions League',
    'Europa League',
  ],
  'Ice Hockey': ['NHL', 'KHL', 'DEL', 'National Teams'],
  'Darts': ['PDC', 'WDF', 'National Teams'],
  'Tennis': ['ATP', 'WTA', 'ITF', 'National Teams'],
  'Baseball': ['MLB', 'Nippon', 'KBO', 'National Teams'],
  'American Football': ['NFL', 'College', 'National Teams'],
  'Rugby': ['NRL', 'Super League', 'National Teams'],
  'Cricket': ['IPL', 'BBL', 'National Teams'],
  'Golf': ['PGA Tour', 'European Tour', 'National Teams'],
  'Motorsport': ['Formula 1', 'MotoGP', 'NASCAR', 'National Teams'],
  'Cycling': [
    'Tour de France',
    'Giro d\'Italia',
    'Vuelta a España',
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
        children: const [SchedulePage(), Search(), Settings()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
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

/// PAGE 2 – Search bar and league navigation
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _controller = TextEditingController();
  String _query = '';

  final List<Map<String, dynamic>> _sports = [
    {'name': 'Basketball', 'icon': Icons.sports_basketball},
    {'name': 'Soccer', 'icon': Icons.sports_soccer},
    {'name': 'Ice Hockey', 'icon': Icons.sports_hockey},
    {'name': 'Darts', 'icon': Icons.sports},
    {'name': 'Tennis', 'icon': Icons.sports_tennis},
    {'name': 'Baseball', 'icon': Icons.sports_baseball},
    {'name': 'American Football', 'icon': Icons.sports_football},
    {'name': 'Rugby', 'icon': Icons.sports_rugby},
    {'name': 'Cricket', 'icon': Icons.sports_cricket},
    {'name': 'Golf', 'icon': Icons.sports_golf},
    {'name': 'Motorsport', 'icon': Icons.sports_motorsports},
    {'name': 'Cycling', 'icon': Icons.directions_bike},
  ];

  final Set<int> _selected = {};
  
Future<List<String>> fetchLeagues(String sport) async {
  final response = await http.get(Uri.parse('https://www.thesportsdb.com/api/v1/json/3/search_all_leagues.php?c=Germany&s=$sport'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final leagues = (data['countries'] as List?)?.map<String>((league) {
      return league['strLeague'] as String;
    }).toList() ?? [];
    return leagues;
  } else {
    throw Exception('Fehler beim Laden der Ligen');
  }
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final visibleSports =
        _sports.where((s) {
          final name = (s['name'] as String).toLowerCase();
          return name.contains(_query.toLowerCase());
        }).toList();

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
                    onTap: () async {
                      setState(() {
                        isSelected
                            ? _selected.remove(originalIndex)
                            : _selected.add(originalIndex);
                      });
                      final sportName = s['name'] as String;
                      try {
                        final leagues = await fetchLeagues(sportName);
                        if (!mounted) return;
                        if (leagues.isNotEmpty) {
                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (_) => LeaguesPage(
                                sport: sportName,
                                leagues: leagues,
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        if (!mounted) return;
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Fehler beim Laden der Ligen')),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
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

/// PAGE 3 – Settings placeholder
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Settings', style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
