import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../models/sport.dart';
import '../widgets/team_card.dart';
import 'competitions_screen.dart';
import '../providers/sports_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        if (favoritesProvider.favoriteTeams.isEmpty) {
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
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildSportSections(context, favoritesProvider),
          ),
        );
      },
    );
  }

  List<Widget> _buildSportSections(BuildContext context, FavoritesProvider favoritesProvider) {
    List<Widget> sections = [];

    final sportsProvider = Provider.of<SportsProvider>(context, listen: false);
    List<Sport> sports = sportsProvider.sports;
    
    // Durchlaufe alle Sportarten und erstelle Sektionen für die, die Favoriten haben
    for (Sport sport in sports) {
      List<Team> teamsForSport = favoritesProvider.favoriteTeams
          .where((team) => team.sport == sport.apiName)
          .toList();
      
      if (teamsForSport.isNotEmpty) {
        sections.add(
          _buildSportSection(
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

  Widget _buildSportSection(BuildContext context, String title, IconData icon, List<Team> teams) {
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
                  color: Theme.of(context).primaryColor.withValues(alpha: 50,),
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