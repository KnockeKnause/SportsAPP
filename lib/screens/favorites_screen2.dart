import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../models/sport.dart';
import 'competitions_screen.dart';
import '../widgets/team_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final hasCompetitions = favoritesProvider.favoriteCompetitions.isNotEmpty;
        final hasTeams = favoritesProvider.favoriteTeams.isNotEmpty;
        
        // Wenn keine Favoriten vorhanden sind
        if (!hasCompetitions && !hasTeams) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'Keine Favoriten',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Füge Wettbewerbe und Teams zu deinen Favoriten hinzu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Tab Header
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(color: Color(0xFF4A9EFF), width: 2),
                      insets: EdgeInsets.zero,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: const Color(0xFF4A9EFF),
                    unselectedLabelColor: const Color(0xFF666666),
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: const [
                      Tab(text: 'Wettbewerbe'),
                      Tab(text: 'Teams'),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
                        
            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCompetitionsTab(favoritesProvider),
                  _buildTeamsTab(favoritesProvider),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCompetitionsTab(FavoritesProvider favoritesProvider) {
    if (favoritesProvider.favoriteCompetitions.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_soccer,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Keine Wettbewerb-Favoriten',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    // Gruppiere Competitions nach Sportart
    final competitionsBySport = <String, List<Competition>>{};
    for (final competition in favoritesProvider.favoriteCompetitions) {
      final sportType = competition.sportType;
      if (!competitionsBySport.containsKey(sportType)) {
        competitionsBySport[sportType] = [];
      }
      competitionsBySport[sportType]!.add(competition);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: competitionsBySport.entries.map((entry) {
          return _buildSportSection(
            context,
            _getSportDisplayName(entry.key),
            entry.value,
            _getSportIcon(entry.key),
            _getSportColor(entry.key),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTeamsTab(FavoritesProvider favoritesProvider) {
    if (favoritesProvider.favoriteTeams.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.group,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Keine Team-Favoriten',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
// Gruppiere Teams nach Sportart

    final teamsBySport = <String?, List<dynamic>>{};
    for (final team in favoritesProvider.favoriteTeams) {
      final sportType = team.sport; // Annahme: Team hat ein sport
      if (!teamsBySport.containsKey(sportType)) {
        teamsBySport[sportType] = [];
      }
      teamsBySport[sportType]!.add(team);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: favoritesProvider.favoriteTeams.map((team) {
          return _buildTeamItem(team);
        }).toList(),
      ),
    );
  }

  Widget _buildSportSection(BuildContext context, String title, List<Competition> competitions, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
        ),
        ...competitions.map((competition) => _buildCompetitionItem(
          context,
          competition,
          icon,
          color,
          title,
        )),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCompetitionItem(BuildContext context, Competition competition, IconData icon, Color color, String sportTitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          competition.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.grey,
          size: 16,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompetitionsScreen(
                sport: Sport(
                  name: sportTitle,
                  competitions: [],
                ),
                competitions: [
                  Competition(
                    name: competition.name,
                    id: competition.id,
                    sportType: competition.sportType,
                    season: competition.season,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTeamItem(Team team) {
  return TeamCard(team: team);
}

  String _getSportDisplayName(String sportType) {
    switch (sportType.toLowerCase()) {
      case 'soccer':
        return 'Fußball';
      case 'cycling':
        return 'Radsport';
      case 'tennis':
        return 'Tennis';
      default:
        return sportType;
    }
  }

  IconData _getSportIcon(String sportType) {
    switch (sportType.toLowerCase()) {
      case 'soccer':
        return Icons.sports_soccer;
      case 'cycling':
        return Icons.directions_bike;
      case 'tennis':
        return Icons.sports_tennis;
      default:
        return Icons.sports;
    }
  }

  Color _getSportColor(String sportType) {
    switch (sportType.toLowerCase()) {
      case 'soccer':
        return Colors.green;
      case 'cycling':
        return Colors.orange;
      case 'tennis':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}