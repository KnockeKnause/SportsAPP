import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sport.dart';
import '../providers/favorites_provider.dart';

class TeamsScreen extends StatelessWidget {
  final Competition competition;
  final Color sportColor;

  const TeamsScreen({
    Key? key, 
    required this.competition,
    required this.sportColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(competition.name),
        backgroundColor: Theme.of(context).brightness == Brightness.dark 
            ? Colors.black 
            : Color(0xFF4ECDC4),
      ),
      body: competition.teams.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.groups,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Keine Teams verfügbar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Teams werden über die API geladen',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: competition.teams.length,
              itemBuilder: (context, index) {
                final team = competition.teams[index];
                return Consumer<FavoritesProvider>(
                  builder: (context, favoritesProvider, child) {
                    final isFavorite = favoritesProvider.isTeamFavorite(team.id);
                    
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: sportColor,
                          child: Text(
                            team.name.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          team.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (team.city != null)
                              Text('Stadt: ${team.city}'),
                            if (team.league != null)
                              Text(
                                'Liga: ${team.league}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            if (isFavorite) {
                              favoritesProvider.removeTeamFromFavorites(team.id);
                            } else {
                              favoritesProvider.addTeamToFavorites(team);
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}