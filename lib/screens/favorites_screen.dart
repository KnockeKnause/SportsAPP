import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../models/sport.dart';
//import '../widgets/sport_card.dart';
import 'competitions_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        if (favoritesProvider.favoriteCompetitions.isEmpty && 
            favoritesProvider.favoriteTeams.isEmpty) {
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
            children: [
              // Cycling Section
              if (favoritesProvider.favoriteCompetitions.any((c) => c.sportType == 'cycling'))
                _buildSportSection(
                  context,
                  'Radsport',
                  favoritesProvider.favoriteCompetitions.where((c) => c.sportType == 'cycling').toList(),
                  Icons.directions_bike,
                  Colors.orange,
                ),
              
              // Football Section
              if (favoritesProvider.favoriteCompetitions.any((c) => c.sportType == 'football'))
                _buildSportSection(
                  context,
                  'Fußball',
                  favoritesProvider.favoriteCompetitions.where((c) => c.sportType == 'football').toList(),
                  Icons.sports_soccer,
                  Colors.green,
                ),
              
              // Tennis Section
              if (favoritesProvider.favoriteCompetitions.any((c) => c.sportType == 'tennis'))
                _buildSportSection(
                  context,
                  'Tennis',
                  favoritesProvider.favoriteCompetitions.where((c) => c.sportType == 'tennis').toList(),
                  Icons.sports_tennis,
                  Colors.red,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSportSection(BuildContext context, String title, List<Competition> competitions, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...competitions.map((competition) => 
          Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                child: Icon(icon, color: Colors.white),
              ),
              title: Text(competition.name),
              subtitle: Text(competition.description ?? ''),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompetitionsScreen(
                      sport: Sport(
                        name: title,
                        icon: icon,
                        color: color,
                        competitions: [competition],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ).toList(),
        const SizedBox(height: 16),
      ],
    );
  }
}