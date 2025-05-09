// // //
// // import 'package:flutter/material.dart';

// // void main() => runApp(const MyApp());

// // /// Entry point of the app
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Who Plays Tonight?',
// //       theme: ThemeData.dark().copyWith(
// //         scaffoldBackgroundColor: Colors.black,
// //         cardColor: const Color(0xFF121212),
// //         primaryColor: Colors.blueAccent,
// //         bottomNavigationBarTheme: const BottomNavigationBarThemeData(
// //           backgroundColor: Color(0xFF111111),
// //           selectedItemColor: Colors.blueAccent,
// //           unselectedItemColor: Colors.grey,
// //         ),
// //         textTheme: ThemeData.dark().textTheme.copyWith(
// //           headlineLarge: const TextStyle(
// //             fontSize: 36,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //           ),
// //           titleMedium: const TextStyle(
// //             fontSize: 18,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //           ),
// //           bodyMedium: TextStyle(color: Colors.grey.shade400, fontSize: 14),
// //         ),
// //       ),
// //       home: const HomePage(),
// //     );
// //   }
// // }

// // /// Data model for one fixture
// // class Fixture {
// //   final IconData icon;
// //   final String home, away, time;
// //   const Fixture({
// //     required this.icon,
// //     required this.home,
// //     required this.away,
// //     required this.time,
// //   });
// // }

// // /// Dummy data until the API is wired up
// // const fixtures = [
// //   Fixture(
// //     icon: Icons.sports_basketball,
// //     home: 'Lakers',
// //     away: 'Warriors',
// //     time: '7:00 pm',
// //   ),
// //   Fixture(
// //     icon: Icons.sports_soccer,
// //     home: 'Liverpool',
// //     away: 'Chelsea',
// //     time: '8:30 pm',
// //   ),
// //   Fixture(
// //     icon: Icons.sports_hockey,
// //     home: 'Capitals',
// //     away: 'Bruins',
// //     time: '9:00 pm',
// //   ),
// //   Fixture(
// //     icon: Icons.sports,
// //     home: 'Van Gerwen',
// //     away: 'Wright',
// //     time: '10:00 pm',
// //   ),
// //   Fixture(
// //     icon: Icons.sports_tennis,
// //     home: 'Zverev',
// //     away: 'Djokovic',
// //     time: '10:30 pm',
// //   ),
// // ];

// // /// Wrapper that holds the BottomNavigationBar and switches between pages
// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   int _currentIndex = 0;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: IndexedStack(
// //         index: _currentIndex,
// //         children: const [SchedulePage(), FavouritesPage(), AlertsPage()],
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _currentIndex,
// //         onTap: (i) => setState(() => _currentIndex = i),
// //         items: const [
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.calendar_month),
// //             label: 'Schedule',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.star_border),
// //             label: 'Favourite Teams',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.notifications_none),
// //             label: 'Manage Alerts',
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // /// PAGE 1 – Schedule list (as seen on the mock-up)
// // class SchedulePage extends StatelessWidget {
// //   const SchedulePage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final t = Theme.of(context);
// //     return SafeArea(
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text('Who Plays\nTonight?', style: t.textTheme.headlineLarge),
// //             const SizedBox(height: 8),
// //             Text(
// //               "Today's games in your local time",
// //               style: t.textTheme.bodyMedium,
// //             ),
// //             const SizedBox(height: 24),
// //             Expanded(
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   color: t.cardColor,
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: ListView.separated(
// //                   padding: const EdgeInsets.all(16),
// //                   itemCount: fixtures.length,
// //                   separatorBuilder: (_, __) => const SizedBox(height: 24),
// //                   itemBuilder: (context, i) {
// //                     final g = fixtures[i];
// //                     return Row(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         CircleAvatar(
// //                           radius: 18,
// //                           backgroundColor: Colors.white10,
// //                           child: Icon(g.icon, color: Colors.white, size: 20),
// //                         ),
// //                         const SizedBox(width: 12),
// //                         Expanded(
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text(g.home, style: t.textTheme.titleMedium),
// //                               const SizedBox(height: 4),
// //                               Text(
// //                                 'vs ${g.away}',
// //                                 style: t.textTheme.bodyMedium,
// //                               ),
// //                               const SizedBox(height: 2),
// //                               Text(g.time, style: t.textTheme.bodyMedium),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // /// PAGE 2 – Favourite Teams (placeholder)
// // class FavouritesPage extends StatelessWidget {
// //   const FavouritesPage({super.key});

// //   @override
// //   Widget build(BuildContext context) =>
// //       const Center(child: Text('Favourite Teams coming soon…'));
// // }

// // /// PAGE 3 – Alerts management (placeholder)
// // class AlertsPage extends StatelessWidget {
// //   const AlertsPage({super.key});

// //   @override
// //   Widget build(BuildContext context) =>
// //       const Center(child: Text('Manage Alerts coming soon…'));
// // }

// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// /// Entry point of the app
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'My Sports',
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: Colors.black,
//         cardColor: const Color(0xFF121212),
//         primaryColor: Colors.blueAccent,
//         bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//           backgroundColor: Color(0xFF111111),
//           selectedItemColor: Colors.blueAccent,
//           unselectedItemColor: Colors.grey,
//         ),
//         textTheme: ThemeData.dark().textTheme.copyWith(
//           headlineLarge: const TextStyle(
//             fontSize: 36,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//           titleMedium: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//           bodyMedium: TextStyle(color: Colors.grey.shade400, fontSize: 14),
//         ),
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// /// Data model for one fixture
// class Fixture {
//   final IconData icon;
//   final String home, away, time;
//   const Fixture({
//     required this.icon,
//     required this.home,
//     required this.away,
//     required this.time,
//   });
// }

// /// Dummy data until the API is wired up
// const fixtures = [
//   Fixture(
//     icon: Icons.sports_basketball,
//     home: 'Lakers',
//     away: 'Warriors',
//     time: '7:00 pm',
//   ),
//   Fixture(
//     icon: Icons.sports_soccer,
//     home: 'Liverpool',
//     away: 'Chelsea',
//     time: '8:30 pm',
//   ),
//   Fixture(
//     icon: Icons.sports_hockey,
//     home: 'Capitals',
//     away: 'Bruins',
//     time: '9:00 pm',
//   ),
//   Fixture(
//     icon: Icons.sports,
//     home: 'Van Gerwen',
//     away: 'Wright',
//     time: '10:00 pm',
//   ),
//   Fixture(
//     icon: Icons.sports_tennis,
//     home: 'Zverev',
//     away: 'Djokovic',
//     time: '10:30 pm',
//   ),
// ];

// /// Wrapper that holds the BottomNavigationBar and switches between pages
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _currentIndex,
//         children: const [SchedulePage(), FavouritesPage(), AlertsPage()],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (i) => setState(() => _currentIndex = i),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_month),
//             label: 'Schedule',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.star_border),
//             label: 'Favourite Teams',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications_none),
//             label: 'Manage Alerts',
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// PAGE 1 – Schedule list (as seen on the mock‑up)
// class SchedulePage extends StatelessWidget {
//   const SchedulePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final t = Theme.of(context);
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('My Sports', style: t.textTheme.headlineLarge),
//             const SizedBox(height: 8),

//             const SizedBox(height: 24),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: t.cardColor,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: ListView.separated(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: fixtures.length,
//                   separatorBuilder: (_, __) => const SizedBox(height: 24),
//                   itemBuilder: (context, i) {
//                     final g = fixtures[i];
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CircleAvatar(
//                           radius: 18,
//                           backgroundColor: Colors.white10,
//                           child: Icon(g.icon, color: Colors.white, size: 20),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(g.home, style: t.textTheme.titleMedium),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'vs ${g.away}',
//                                 style: t.textTheme.bodyMedium,
//                               ),
//                               const SizedBox(height: 2),
//                               Text(g.time, style: t.textTheme.bodyMedium),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// PAGE 2 – Favourite Teams with 5 clickable sports
// class FavouritesPage extends StatefulWidget {
//   const FavouritesPage({super.key});

//   @override
//   State<FavouritesPage> createState() => _FavouritesPageState();
// }

// class _FavouritesPageState extends State<FavouritesPage> {
//   final _sports = [
//     {'name': 'Basketball', 'icon': Icons.sports_basketball},
//     {'name': 'Football', 'icon': Icons.sports_soccer},
//     {'name': 'Ice Hockey', 'icon': Icons.sports_hockey},
//     {'name': 'Darts', 'icon': Icons.sports},
//     {'name': 'Tennis', 'icon': Icons.sports_tennis},
//   ];

//   final Set<int> _selected = {};

//   @override
//   Widget build(BuildContext context) {
//     final t = Theme.of(context);
//     return SafeArea(
//       child: ListView.separated(
//         padding: const EdgeInsets.all(24),
//         itemCount: _sports.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 12),
//         itemBuilder: (context, i) {
//           final s = _sports[i];
//           final isSelected = _selected.contains(i);

//           return GestureDetector(
//             onTap:
//                 () => setState(() {
//                   isSelected ? _selected.remove(i) : _selected.add(i);
//                 }),
//             child: Container(
//               decoration: BoxDecoration(
//                 color:
//                     isSelected ? t.primaryColor.withOpacity(0.15) : t.cardColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 children: [
//                   Icon(s['icon'] as IconData, color: Colors.white),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Text(
//                       s['name'] as String,
//                       style: t.textTheme.titleMedium,
//                     ),
//                   ),
//                   if (isSelected)
//                     const Icon(Icons.check, color: Colors.blueAccent),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// /// PAGE 3 – Alerts management (placeholder)
// class AlertsPage extends StatelessWidget {
//   const AlertsPage({super.key});

//   @override
//   Widget build(BuildContext context) =>
//       const Center(child: Text('Manage Alerts coming soon…'));
// }
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// Entry point of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Who Plays Tonight?',
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
            Text('Who Plays\nTonight?', style: t.textTheme.headlineLarge),
            const SizedBox(height: 8),
            Text(
              "Today's games in your local time",
              style: t.textTheme.bodyMedium,
            ),
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

/// PAGE 2 – Favourite Teams with clickable sports that open league lists
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  final _sports = [
    {'name': 'Basketball', 'icon': Icons.sports_basketball},
    {'name': 'Football', 'icon': Icons.sports_soccer},
    {'name': 'Ice Hockey', 'icon': Icons.sports_hockey},
    {'name': 'Darts', 'icon': Icons.sports},
    {'name': 'Tennis', 'icon': Icons.sports_tennis},
  ];

  final Set<int> _selected = {};

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: _sports.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final s = _sports[i];
          final isSelected = _selected.contains(i);

          return GestureDetector(
            onTap: () {
              setState(() {
                isSelected ? _selected.remove(i) : _selected.add(i);
              });
              // If sport has leagues defined, open league list page
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
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
    );
  }
}

/// PAGE – Lists leagues for a selected sport
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
        itemBuilder:
            (context, i) => Container(
              decoration: BoxDecoration(
                color: t.cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(leagues[i], style: t.textTheme.titleMedium),
            ),
      ),
    );
  }
}

/// PAGE 3 – Alerts management (placeholder)
class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Manage Alerts coming soon…'));
}
