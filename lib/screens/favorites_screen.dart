import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../models/sport.dart';
import '../widgets/team_card.dart';
import '../widgets/player_card.dart';
import '../providers/sports_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        bool hasTeams = favoritesProvider.favoriteTeams.isNotEmpty;
        bool hasPlayers = favoritesProvider.favoritePlayer.isNotEmpty;
        
        if (!hasTeams && !hasPlayers) {
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
                  'Füge Wettbewerbe, Teams und Spieler zu deinen Favoriten hinzu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildTeamSections(context, favoritesProvider),
              if (hasTeams && hasPlayers) const SizedBox(height: 32),
              ..._buildPlayerSections(context, favoritesProvider),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildTeamSections(BuildContext context, FavoritesProvider favoritesProvider) {
    List<Widget> sections = [];

    final sportsProvider = Provider.of<SportsProvider>(context, listen: false);
    List<Sport> sports = sportsProvider.sports;
    
    // Durchlaufe alle Sportarten und erstelle Sektionen für die, die Team-Favoriten haben
    for (Sport sport in sports) {
      List<Team> teamsForSport = favoritesProvider.favoriteTeams
          .where((team) => team.sport == sport.apiName)
          .toList();
      
      if (teamsForSport.isNotEmpty) {
        sections.add(
          _buildTeamSection(
            context,
            sport.name,
            _getSportIcon(sport.apiName ?? ''),
            teamsForSport,
          ),
        );
      }
    }
    
    return sections;
  }

  List<Widget> _buildPlayerSections(BuildContext context, FavoritesProvider favoritesProvider) {
    List<Widget> sections = [];

    final sportsProvider = Provider.of<SportsProvider>(context, listen: false);
    List<Sport> sports = sportsProvider.sports;
    
    // Durchlaufe alle Sportarten und erstelle Sektionen für die, die Player-Favoriten haben
    for (Sport sport in sports) {
      List<Player> playersForSport = favoritesProvider.favoritePlayer
          .where((player) => player.sport == sport.apiName)
          .toList();
      
      if (playersForSport.isNotEmpty) {
        sections.add(
          _buildPlayerSection(
            context,
            sport.name,
            _getSportIcon(sport.apiName ?? ''),
            playersForSport,
          ),
        );
      }
    }
    
    return sections;
  }

  Widget _buildTeamSection(BuildContext context, String title, IconData icon, List<Team> teams) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: Colors.grey[700] ?? Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700] ?? Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${teams.length}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Teams List
        ...teams.map((team) => TeamCard(team: team)),
        
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPlayerSection(BuildContext context, String title, IconData icon, List<Player> players) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              Icon(
                Icons.person,
                size: 24,
                color: Colors.grey[700] ?? Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700] ?? Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: (Colors.blue[700] ?? Theme.of(context).colorScheme.secondary).withValues(alpha: 50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${players.length}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700] ?? Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Players List
        ...players.map((player) => PlayerCard(player: player)),
        
        const SizedBox(height: 24),
      ],
    );
  }

  IconData _getSportIcon(String apiName) {
    switch (apiName) {
      case 'Soccer':
        return Icons.sports_soccer;
      case 'Tennis':
        return Icons.sports_tennis;
      case 'Basketball':
        return Icons.sports_basketball;
      case 'Spikeball':
        return Icons.sports_volleyball;
      case 'Rugby':
        return Icons.sports_rugby;
      case 'Baseball':
        return Icons.sports_baseball;
      case 'Formel 1':
        return Icons.sports_motorsports;
      case 'Handball':
        return Icons.sports_handball;
      case 'American Football':
        return Icons.sports_football;
      default:
        return Icons.sports;
    }
  }
}