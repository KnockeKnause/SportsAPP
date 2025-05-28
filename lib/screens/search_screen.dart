import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sports_provider.dart';
import '../models/sport.dart';
import '../widgets/sport_card.dart';
import 'competitions_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
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
          padding: EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            onChanged: _filterSports,
            decoration: InputDecoration(
              hintText: 'Suche Sportarten',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.grey[800] 
                  : Colors.grey[100],
            ),
          ),
        ),
        Expanded(
          child: _filteredSports.isEmpty
              ? Center(
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
                        'Keine Sportarten gefunden',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredSports.length,
                  itemBuilder: (context, index) {
                    final sport = _filteredSports[index];
                    return SportCard(
                      sport: sport,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompetitionsScreen(sport: sport),
                          ),
                        );
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