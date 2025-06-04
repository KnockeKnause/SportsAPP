import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sports_provider.dart';
import '../models/sport.dart';
import '../widgets/sport_card.dart';
import 'country_screen.dart';
import '../services/api_service.dart';
import 'package:my_sports_app/screens/player_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<Sport> _filteredSports = [];

  @override
  void initState() {
    super.initState();
    _loadSports();
  }

  void _loadSports() {
    final sportsProvider = Provider.of<SportsProvider>(context, listen: false);
    _filteredSports = sportsProvider.sports;
  }

  void _filterSports(String query) {
    final sportsProvider = Provider.of<SportsProvider>(context, listen: false);
    setState(() {
      if (query.isEmpty) {
        _filteredSports = sportsProvider.sports;
      } else {
        _filteredSports = sportsProvider.sports
            .where((sport) => 
                sport.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: TextField(
            controller: _searchController,
            onChanged: _filterSports,
            decoration: InputDecoration(
              hintText: 'Sportart suchen...',
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.grey[900] 
                  : Colors.grey[200],
            ),
          ),
        ),
        Expanded(
          child: _filteredSports.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'failed to find any sports',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: _filteredSports.length,
                  itemBuilder: (context, index) {
                    final sport = _filteredSports[index];
                    return SportCard(
                      sport: sport,
                      onTap: () async {
                        if (sport.format == 'Player') {
                          // Loading Dialog anzeigen
                          showDialog(
                            context: context,
                            barrierDismissible: false, // Verhindert das Schließen durch Tippen außerhalb
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const CircularProgressIndicator(),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Loading...',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Please wait...',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );

                          try {
                            // 1. Competitions laden
                            final competitionList = await ApiService.fetchCompetitions(sport.apiName!, '');
                            print('Competitions loaded: ${competitionList.length}');
                            
                            // 2. Für jede competition die teams laden und in einer Liste sammeln
                            List<Team> allTeams = [];
                            if (competitionList.isNotEmpty) {
                              for (final competition in competitionList) {
                                try {
                                  final teams = await ApiService.fetchTeams(competition.id);
                                  allTeams.addAll(teams);
                                  print('Teams loaded for ${competition.id}: ${teams.length}');
                                } catch (e) {
                                  print('Error loading teams for competition ${competition.id}: $e');
                                  // Weitermachen mit nächster Competition
                                }
                              }
                            }
                            
                            // 3. Für jedes Team die Spieler laden und in einer Liste sammeln
                            List<Player> allPlayers = [];
                            for (final team in allTeams) {
                              try {
                                final players = await ApiService.fetchPlayers(team.id);
                                allPlayers.addAll(players);
                                print('Players loaded for team ${team.id}: ${players.length}');
                              } catch (e) {
                                print('Error loading players for team ${team.id}: $e');
                                // Weitermachen mit nächstem Team
                              }
                            }
                            
                            print('Total players loaded: ${allPlayers.length}');
                            
                            // Loading Dialog schließen
                            Navigator.of(context).pop();
                            
                            if (allPlayers.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayersScreen(players: allPlayers)
                                ),
                              );
                            } else {
                              // Benutzer informieren, dass keine Spieler gefunden wurden
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Keine Spieler für diese Sportart gefunden.'),
                                ),
                              );
                            }
                          } catch (e) {
                            // Loading Dialog schließen falls noch offen
                            Navigator.of(context).pop();
                            
                            print('Error in player loading process: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Fehler beim Laden der Spieler: $e'),
                              ),
                            );
                          }
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CountrySelectionScreen(sport: sport)
                            ),
                          );
                        }
                  },
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}