import 'package:flutter/material.dart';

void main() {
  runApp(MySportsApp());
}

class MySportsApp extends StatelessWidget {
  const MySportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY SPORTS',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Color(0xFF4DB6AC),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Data Models
class SportEvent {
  final String homeTeam;
  final String awayTeam;
  final String date;
  final String time;
  final String competition;
  final String sport;
  final String? score;
  final bool isLive;

  SportEvent({
    required this.homeTeam,
    required this.awayTeam,
    required this.date,
    required this.time,
    required this.competition,
    required this.sport,
    this.score,
    this.isLive = false,
  });
}

class TeamPlayer {
  final String name;
  final String sport;
  final String league;
  final String country;
  final String type; // 'team' or 'player'
  final String imageUrl;
  bool isFavorite;

  TeamPlayer({
    required this.name,
    required this.sport,
    required this.league,
    required this.country,
    required this.type,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

class League {
  final String name;
  final String sport;
  final String country;
  final String imageUrl;
  final List<TeamPlayer> teamsPlayers;

  League({
    required this.name,
    required this.sport,
    required this.country,
    required this.imageUrl,
    required this.teamsPlayers,
  });
}

class SportCategory {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<League> leagues;

  SportCategory({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.leagues,
  });
}

// Data Service
class DataService {
  static final List<TeamPlayer> _allTeamsPlayers = [];
  static List<SportEvent> _allEvents = [];

  static void initializeData() {
    // Tennis Players
    _allTeamsPlayers.addAll([
      TeamPlayer(
        name: 'Novak Djokovic',
        sport: 'Tennis',
        league: 'ATP',
        country: 'Serbien',
        type: 'player',
        imageUrl: '🎾',
      ),
      TeamPlayer(
        name: 'Carlos Alcaraz',
        sport: 'Tennis',
        league: 'ATP',
        country: 'Spanien',
        type: 'player',
        imageUrl: '🎾',
      ),
      TeamPlayer(
        name: 'Alexander Zverev',
        sport: 'Tennis',
        league: 'ATP',
        country: 'Deutschland',
        type: 'player',
        imageUrl: '🎾',
      ),
      TeamPlayer(
        name: 'Iga Swiatek',
        sport: 'Tennis',
        league: 'WTA',
        country: 'Polen',
        type: 'player',
        imageUrl: '🎾',
      ),
      TeamPlayer(
        name: 'Aryna Sabalenka',
        sport: 'Tennis',
        league: 'WTA',
        country: 'Belarus',
        type: 'player',
        imageUrl: '🎾',
      ),
      TeamPlayer(
        name: 'Coco Gauff',
        sport: 'Tennis',
        league: 'WTA',
        country: 'USA',
        type: 'player',
        imageUrl: '🎾',
      ),
    ]);

    // Basketball Teams
    _allTeamsPlayers.addAll([
      TeamPlayer(
        name: 'Los Angeles Lakers',
        sport: 'Basketball',
        league: 'NBA',
        country: 'USA',
        type: 'team',
        imageUrl: '🏀',
      ),
      TeamPlayer(
        name: 'Golden State Warriors',
        sport: 'Basketball',
        league: 'NBA',
        country: 'USA',
        type: 'team',
        imageUrl: '🏀',
      ),
      TeamPlayer(
        name: 'Bayern München',
        sport: 'Basketball',
        league: 'BBL',
        country: 'Deutschland',
        type: 'team',
        imageUrl: '🏀',
      ),
      TeamPlayer(
        name: 'Alba Berlin',
        sport: 'Basketball',
        league: 'BBL',
        country: 'Deutschland',
        type: 'team',
        imageUrl: '🏀',
      ),
    ]);

    // Football Teams
    _allTeamsPlayers.addAll([
      TeamPlayer(
        name: 'Bayern München',
        sport: 'Fußball',
        league: 'Bundesliga',
        country: 'Deutschland',
        type: 'team',
        imageUrl: '⚽',
      ),
      TeamPlayer(
        name: 'Borussia Dortmund',
        sport: 'Fußball',
        league: 'Bundesliga',
        country: 'Deutschland',
        type: 'team',
        imageUrl: '⚽',
      ),
      TeamPlayer(
        name: 'Manchester City',
        sport: 'Fußball',
        league: 'Premier League',
        country: 'England',
        type: 'team',
        imageUrl: '⚽',
      ),
      TeamPlayer(
        name: 'Arsenal',
        sport: 'Fußball',
        league: 'Premier League',
        country: 'England',
        type: 'team',
        imageUrl: '⚽',
      ),
    ]);

    // Initialize Events
    _allEvents = [
      SportEvent(
        homeTeam: 'Alexander Zverev',
        awayTeam: 'Carlos Alcaraz',
        date: '28.05.2025',
        time: '14:00',
        competition: 'French Open',
        sport: 'Tennis',
        isLive: true,
      ),
      SportEvent(
        homeTeam: 'Iga Swiatek',
        awayTeam: 'Coco Gauff',
        date: '28.05.2025',
        time: '16:30',
        competition: 'French Open',
        sport: 'Tennis',
      ),
      SportEvent(
        homeTeam: 'Bayern München',
        awayTeam: 'Borussia Dortmund',
        date: '29.05.2025',
        time: '18:30',
        competition: 'Bundesliga',
        sport: 'Fußball',
      ),
      SportEvent(
        homeTeam: 'Los Angeles Lakers',
        awayTeam: 'Golden State Warriors',
        date: '30.05.2025',
        time: '21:00',
        competition: 'NBA Playoffs',
        sport: 'Basketball',
      ),
      SportEvent(
        homeTeam: 'Novak Djokovic',
        awayTeam: 'Alexander Zverev',
        date: '31.05.2025',
        time: '15:00',
        competition: 'French Open',
        sport: 'Tennis',
      ),
      SportEvent(
        homeTeam: 'Alba Berlin',
        awayTeam: 'Bayern München',
        date: '01.06.2025',
        time: '19:00',
        competition: 'BBL',
        sport: 'Basketball',
      ),
    ];
  }

  static List<TeamPlayer> getFavoriteTeamsPlayers() {
    return _allTeamsPlayers.where((tp) => tp.isFavorite).toList();
  }

  static List<SportEvent> getFavoriteEvents() {
    final favorites = getFavoriteTeamsPlayers();
    final favoriteNames = favorites.map((f) => f.name).toSet();

    return _allEvents
        .where(
          (event) =>
              favoriteNames.contains(event.homeTeam) ||
              favoriteNames.contains(event.awayTeam),
        )
        .toList();
  }

  static List<TeamPlayer> searchTeamsPlayers(String query) {
    if (query.isEmpty) return [];
    return _allTeamsPlayers
        .where(
          (tp) =>
              tp.name.toLowerCase().contains(query.toLowerCase()) ||
              tp.league.toLowerCase().contains(query.toLowerCase()) ||
              tp.country.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  static void toggleFavorite(TeamPlayer teamPlayer) {
    final index = _allTeamsPlayers.indexWhere(
      (tp) => tp.name == teamPlayer.name && tp.sport == teamPlayer.sport,
    );
    if (index != -1) {
      _allTeamsPlayers[index].isFavorite = !_allTeamsPlayers[index].isFavorite;
    }
  }

  static List<SportCategory> getSportCategories() {
    return [
      SportCategory(
        name: 'Tennis',
        subtitle: 'ATP, WTA, Grand Slams',
        icon: Icons.sports_tennis,
        color: Colors.blue[800]!,
        leagues: [
          League(
            name: 'ATP Tour',
            sport: 'Tennis',
            country: 'International',
            imageUrl: '🎾',
            teamsPlayers:
                _allTeamsPlayers
                    .where((tp) => tp.sport == 'Tennis' && tp.league == 'ATP')
                    .toList(),
          ),
          League(
            name: 'WTA Tour',
            sport: 'Tennis',
            country: 'International',
            imageUrl: '🎾',
            teamsPlayers:
                _allTeamsPlayers
                    .where((tp) => tp.sport == 'Tennis' && tp.league == 'WTA')
                    .toList(),
          ),
        ],
      ),
      SportCategory(
        name: 'Basketball',
        subtitle: 'NBA, BBL, Euroleague',
        icon: Icons.sports_basketball,
        color: Colors.orange[800]!,
        leagues: [
          League(
            name: 'NBA',
            sport: 'Basketball',
            country: 'USA',
            imageUrl: '🏀',
            teamsPlayers:
                _allTeamsPlayers
                    .where(
                      (tp) => tp.sport == 'Basketball' && tp.league == 'NBA',
                    )
                    .toList(),
          ),
          League(
            name: 'BBL',
            sport: 'Basketball',
            country: 'Deutschland',
            imageUrl: '🏀',
            teamsPlayers:
                _allTeamsPlayers
                    .where(
                      (tp) => tp.sport == 'Basketball' && tp.league == 'BBL',
                    )
                    .toList(),
          ),
        ],
      ),
      SportCategory(
        name: 'Fußball',
        subtitle: 'Bundesliga, Premier League',
        icon: Icons.sports_soccer,
        color: Colors.green[700]!,
        leagues: [
          League(
            name: 'Bundesliga',
            sport: 'Fußball',
            country: 'Deutschland',
            imageUrl: '⚽',
            teamsPlayers:
                _allTeamsPlayers
                    .where(
                      (tp) =>
                          tp.sport == 'Fußball' && tp.league == 'Bundesliga',
                    )
                    .toList(),
          ),
          League(
            name: 'Premier League',
            sport: 'Fußball',
            country: 'England',
            imageUrl: '⚽',
            teamsPlayers:
                _allTeamsPlayers
                    .where(
                      (tp) =>
                          tp.sport == 'Fußball' &&
                          tp.league == 'Premier League',
                    )
                    .toList(),
          ),
        ],
      ),
    ];
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    DataService.initializeData();
  }

  final List<Widget> _pages = [
    FavoritenPage(),
    SuchePage(),
    EinstellungenPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4DB6AC),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.orange,
              child: Icon(Icons.sports_tennis, color: Colors.white, size: 18),
            ),
            SizedBox(width: 8),
            Text(
              'MY SPORTS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Color(0xFF4DB6AC),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoriten',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Suche'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Einstellungen',
          ),
        ],
      ),
    );
  }
}

class EinstellungenPage extends StatelessWidget {
  const EinstellungenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Einstellungen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FavoritenPage extends StatefulWidget {
  const FavoritenPage({super.key});

  @override
  _FavoritenPageState createState() => _FavoritenPageState();
}

class _FavoritenPageState extends State<FavoritenPage> {
  @override
  Widget build(BuildContext context) {
    final favoriteEvents = DataService.getFavoriteEvents();
    final favorites = DataService.getFavoriteTeamsPlayers();

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Favorites Summary
            if (favorites.isNotEmpty) ...[
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4DB6AC), Colors.teal[300]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.favorite, color: Colors.white, size: 24),
                          SizedBox(width: 12),
                          Text(
                            'Meine Favoriten',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${favorites.length} Teams/Spieler favorisiert',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],

            // Favorites List Section
            if (favorites.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Favorisierte Teams/Spieler',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    '${favorites.length}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Favorites List
              SizedBox(
                height: 200, // Fixed height for favorites list
                child: ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final item = favorites[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            item.imageUrl,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        title: Text(
                          item.name,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          '${item.league} • ${item.country}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              DataService.toggleFavorite(item);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${item.name} aus Favoriten entfernt',
                                ),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
            ],

            // Events Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  favoriteEvents.isEmpty ? 'Keine Events' : 'Kommende Events',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                if (favoriteEvents.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 12),

            // Events List or Empty State
            Expanded(
              child:
                  favoriteEvents.isEmpty && favorites.isEmpty
                      ? _buildEmptyState()
                      : favoriteEvents.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_busy,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Keine Events verfügbar',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Events werden angezeigt, sobald\nsie für deine Favoriten verfügbar sind',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        itemCount: favoriteEvents.length,
                        itemBuilder: (context, index) {
                          final event = favoriteEvents[index];
                          return _buildEventCard(event);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 64, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'Keine Favoriten ausgewählt',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Füge Teams oder Spieler in der Suche hinzu,\num ihre Events hier zu sehen',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Switch to search tab
              if (context.findAncestorStateOfType<_MainScreenState>() != null) {
                context.findAncestorStateOfType<_MainScreenState>()!.setState(
                  () {
                    context
                        .findAncestorStateOfType<_MainScreenState>()!
                        ._currentIndex = 1;
                  },
                );
              }
            },
            icon: Icon(Icons.search),
            label: Text('Zur Suche'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4DB6AC),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(SportEvent event) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    event.competition,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Spacer(),
                if (event.isLive)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.homeTeam,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        event.awayTeam,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      event.date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      event.time,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (event.score != null) ...[
              SizedBox(height: 8),
              Text(
                'Ergebnis: ${event.score}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.green[700],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SuchePage extends StatefulWidget {
  const SuchePage({super.key});

  @override
  _SuchePageState createState() => _SuchePageState();
}

class _SuchePageState extends State<SuchePage> {
  TextEditingController searchController = TextEditingController();
  List<TeamPlayer> searchResults = [];
  bool isSearching = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = searchController.text;
      if (searchQuery.isNotEmpty) {
        isSearching = true;
        searchResults = DataService.searchTeamsPlayers(searchQuery);
      } else {
        isSearching = false;
        searchResults = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sportCategories = DataService.getSportCategories();

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Teams, Spieler oder Ligen suchen...',
              prefixIcon: Icon(Icons.search),
              suffixIcon:
                  searchQuery.isNotEmpty
                      ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                        },
                      )
                      : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),

          SizedBox(height: 16),

          // Content
          Expanded(
            child:
                isSearching
                    ? _buildSearchResults()
                    : _buildSportCategories(sportCategories),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              'Keine Ergebnisse für "$searchQuery"',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final item = searchResults[index];
        return _buildTeamPlayerTile(item);
      },
    );
  }

  Widget _buildSportCategories(List<SportCategory> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: category.color,
              child: Icon(category.icon, color: Colors.white),
            ),
            title: Text(
              category.name,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              category.subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SportDetailPage(category: category),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTeamPlayerTile(TeamPlayer item) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(item.imageUrl, style: TextStyle(fontSize: 20)),
        ),
        title: Text(item.name, style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(
          '${item.league} • ${item.country}',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: Icon(
            item.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: item.isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              DataService.toggleFavorite(item);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  item.isFavorite
                      ? '${item.name} zu Favoriten hinzugefügt'
                      : '${item.name} aus Favoriten entfernt',
                ),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

class SportDetailPage extends StatelessWidget {
  final SportCategory category;

  const SportDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4DB6AC),
        title: Text(
          category.name,
          style: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1)),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ligen & Turniere',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: category.leagues.length,
                itemBuilder: (context, index) {
                  final league = category.leagues[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          league.imageUrl,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      title: Text(
                        league.name,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${league.country} • ${league.teamsPlayers.length} ${league.sport == 'Tennis' ? 'Spieler' : 'Teams'}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => LeagueDetailPage(league: league),
                          ),
                        );
                      },
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

class LeagueDetailPage extends StatefulWidget {
  final League league;

  const LeagueDetailPage({super.key, required this.league});

  @override
  _LeagueDetailPageState createState() => _LeagueDetailPageState();
}

class _LeagueDetailPageState extends State<LeagueDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4DB6AC),
        title: Text(widget.league.name, style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.league.sport == 'Tennis' ? 'Spieler' : 'Teams',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.league.teamsPlayers.length,
                itemBuilder: (context, index) {
                  final item = widget.league.teamsPlayers[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 2),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          item.imageUrl,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      title: Text(
                        item.name,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${item.country} • ${item.type == 'player' ? 'Spieler' : 'Team'}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          item.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: item.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            DataService.toggleFavorite(item);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                item.isFavorite
                                    ? '${item.name} zu Favoriten hinzugefügt'
                                    : '${item.name} aus Favoriten entfernt',
                              ),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
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
