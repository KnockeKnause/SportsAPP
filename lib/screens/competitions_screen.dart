import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sport.dart';
import '../providers/favorites_provider.dart';
import 'teams_screen.dart';
import '../services/api_service.dart';

class CompetitionsScreen extends StatelessWidget {
  final Sport sport;
  final List<Competition> competitions;

  const CompetitionsScreen({super.key, required this.sport, required this.competitions});
  competitions = fetchCompetitions(sport.name);
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
          final competition = sport.competitions[index];
          return Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final isFavorite = favoritesProvider.isCompetitionFavorite(competition.id);
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    competition.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (competition.description != null)
                        Text(competition.description!),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          if (isFavorite) {
                            favoritesProvider.removeCompetitionFromFavorites(competition.id);
                          } else {
                            favoritesProvider.addCompetitionToFavorites(competition);
                          }
                        },
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeamsScreen(
                          competition: competition,
                        ),
                      ),
                    );
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