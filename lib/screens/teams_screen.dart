import 'package:flutter/material.dart';
import '../models/sport.dart';
import '../widgets/team_card.dart';

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
            : const Color.fromRGBO(255, 135, 83, 1),
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
              itemBuilder: (context, index) => TeamCard(team: teams[index]),
            ),
    );
  }
}