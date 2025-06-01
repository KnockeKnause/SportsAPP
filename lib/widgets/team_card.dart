import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_sports_app/providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import '../models/sport.dart';

class TeamCard extends StatelessWidget {
  final Team team;

  const TeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final isFavorite = favoritesProvider.isTeamFavorite(team.id);
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: _buildTeamAvatar(context),
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
  }

  Widget _buildTeamAvatar(BuildContext context) {
    final hasLogo = team.logoUrl != null && team.logoUrl!.isNotEmpty;
    
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      child: hasLogo
          ? CachedNetworkImage(
              imageUrl: team.logoUrl!,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              placeholder: (context, url) => const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => _buildFallbackText(),
            )
          : _buildFallbackText(),
    );
  }

  Widget _buildFallbackText() {
    return Text(
      team.name.substring(0, 1).toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}