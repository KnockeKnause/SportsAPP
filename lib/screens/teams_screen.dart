import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sport.dart';
import '../providers/favorites_provider.dart';

class TeamsScreen extends StatelessWidget {
  final Competition competition;
  final List<Team> teams;

  const TeamsScreen({
    super.key, 
    required this.competition,
    required this.teams,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(competition.name),
        backgroundColor: Theme.of(context).brightness == Brightness.dark 
            ? Colors.black 
            : const Color(0xFF4ECDC4),
      ),
      body: teams.isEmpty
          ? const Center(
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
              padding: const EdgeInsets.all(16),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return Consumer<FavoritesProvider>(
                  builder: (context, favoritesProvider, child) {
                    final isFavorite = favoritesProvider.isTeamFavorite(team.id);
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          child: team.logoUrl != null && team.logoUrl!.isNotEmpty
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: team.logoUrl!,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => const SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Text(
                                      team.name.substring(0, 1).toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  team.name.substring(0, 1).toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        title: Text(
                          team.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
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