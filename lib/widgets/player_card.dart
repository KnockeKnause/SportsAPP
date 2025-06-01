import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_sports_app/providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import '../models/sport.dart';

class PlayerCard extends StatelessWidget {
  final Player player;

  const PlayerCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final isFavorite = favoritesProvider.isPlayerFavorite(player.id);
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: _buildPlayerAvatar(context),
            title: Text(
              player.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: _buildPlayerInfo(),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                if (isFavorite) {
                  favoritesProvider.removePlayerFromFavorites(player.id);
                } else {
                  favoritesProvider.addPlayerToFavorites(player);
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlayerAvatar(BuildContext context) {
    final hasPhoto = player.photoUrl != null && player.photoUrl!.isNotEmpty;
    
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      child: hasPhoto
          ? CachedNetworkImage(
              imageUrl: player.photoUrl!,
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
              errorWidget: (context, url, error) => _buildFallbackIcon(),
            )
          : _buildFallbackIcon(),
    );
  }

  Widget _buildFallbackIcon() {
    return const Icon(
      Icons.person,
      color: Colors.white,
      size: 24,
    );
  }

  Widget? _buildPlayerInfo() {
    final List<String> infoItems = [];
    
    if (player.nationality != null && player.nationality!.isNotEmpty) {
      infoItems.add(player.nationality!);
    }
    
    if (infoItems.isEmpty) return null;
    
    return Text(
      infoItems.join(' • '),
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 12,
      ),
    );
  }
}