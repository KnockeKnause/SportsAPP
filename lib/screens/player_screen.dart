import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sport.dart';
import '../providers/favorites_provider.dart';
import '../widgets/player_card.dart';

class PlayersScreen extends StatelessWidget {
  final List<Player> players;

  const PlayersScreen({
    super.key, 
    required this.players,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spieler'),
        backgroundColor: Theme.of(context).brightness == Brightness.dark 
            ? Colors.black 
            : const Color(0xFF4ECDC4),
      ),
      body: players.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Keine Spieler verfügbar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Spieler werden über die API geladen',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: players.length,
              itemBuilder: (context, index) => PlayerCard(player: players[index]),
            ),
    );
  }
}