import 'package:flutter/material.dart';
import 'package:my_sports_app/services/api_service.dart';
import 'package:provider/provider.dart';
import '../models/sport.dart';
import '../providers/favorites_provider.dart';
import 'teams_screen.dart';

class CompetitionsScreen extends StatelessWidget {
  final Sport sport;
  final Country? country;
  final List<Competition> competitions;
  const CompetitionsScreen({super.key, required this.sport, required this.competitions, this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sport.name),
        backgroundColor: Theme.of(context).brightness == Brightness.dark 
            ? Colors.black 
            : const Color(0xFF4ECDC4),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: competitions.length,
        itemBuilder: (context, index) {
          final competition = competitions[index];
          return Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final isFavorite = favoritesProvider.isCompetitionFavorite(competition.id);    
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(
                    competition.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (competition.season != null)
                        Text(
                          'Saison: ${competition.season}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                  onTap: () async {
                    try{
                    final teams = await ApiService.fetchTeams(competition.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeamsScreen(competition: competition, teams: teams),
                      ),
                    );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Fehler beim Laden der Teams: $e'),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}