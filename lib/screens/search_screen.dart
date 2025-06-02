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
                        if (sport.format =='Player') {
                         final competitionList = await ApiService.fetchCompetitions(sport.apiName!, '');
                         print(competitionList);
                        // 2. Für jede Competition die Spieler laden und in einer Liste sammeln
                        List<Player> allPlayers = [];
                        for (final competition in competitionList) {
                          final players = await ApiService.fetchPlayers(competition.id);
                          allPlayers.addAll(players);
                        }
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayersScreen(players: allPlayers)
                          ),
                        );
                          return;
                        }
                        else {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CountrySelectionScreen(sport: sport)
                          ),
                        );
                          return;
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