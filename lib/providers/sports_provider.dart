import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/sport.dart';

class SportsProvider extends ChangeNotifier {
  List<Sport> _sports = [];
  bool _isLoading = false;
  String? _error;

  List<Sport> get sports => _sports;
  bool get isLoading => _isLoading;
  String? get error => _error;

  SportsProvider() {
    _loadMockData();
  }

  // Mock data for demonstration - replace with real API calls
  void _loadMockData() {
    _sports = [
      Sport(
        name: 'Tennis',
        icon: Icons.sports_tennis,
        color: Colors.red,
        competitions: [
          Competition(
            name: 'Australian Open',
            description: 'Wimbledon, Australian Open, US Open',
            season: '2024',
            sportType: 'tennis',
            teams: [
              Team(name: 'A. Zverev', city: 'Deutschland'),
              Team(name: 'N. Djokovic', city: 'Serbien'),
            ],
          ),
          Competition(
            name: 'Wimbledon',
            description: 'The Championships',
            season: '2024',
            sportType: 'tennis',
            teams: [],
          ),
        ],
      ),
      Sport(
        name: 'Fußball',
        icon: Icons.sports_soccer,
        color: Colors.green,
        competitions: [
          Competition(
            name: 'DFB Pokal',
            description: 'Arminia Bielefeld - VfB Stuttgart: 3:0',
            season: '2023/24',
            sportType: 'football',
            teams: [
              Team(name: 'VfB Stuttgart', city: 'Stuttgart', league: 'Bundesliga'),
              Team(name: 'Arminia Bielefeld', city: 'Bielefeld', league: '2. Bundesliga'),
            ],
          ),
          Competition(
            name: 'Bundesliga',
            description: '1. Liga, 2. Liga',
            season: '2023/24',
            sportType: 'football',
            teams: [],
          ),
        ],
      ),
      Sport(
        name: 'Badminton',
        icon: Icons.sports_tennis,
        color: Colors.blue,
        competitions: [
          Competition(
            name: 'BWF World Championships',
            description: '1. Bundesliga - Bundesliga',
            season: '2024',
            sportType: 'badminton',
            teams: [],
          ),
        ],
      ),
      Sport(
        name: 'Basketball',
        icon: Icons.sports_basketball,
        color: Colors.orange,
        competitions: [
          Competition(
            name: 'NBA',
            description: 'NBA, WNBA, Euroleague',
            season: '2023/24',
            sportType: 'basketball',
            teams: [],
          ),
        ],
      ),
      Sport(
        name: 'Spikeball',
        icon: Icons.sports_volleyball,
        color: Colors.purple,
        competitions: [
          Competition(
            name: 'Spikeball Tour',
            description: '1. Liga, 2. Liga',
            season: '2024',
            sportType: 'spikeball',
            teams: [],
          ),
        ],
      ),
      Sport(
        name: 'Rugby',
        icon: Icons.sports_rugby,
        color: Colors.brown,
        competitions: [
          Competition(
            name: 'Six Nations',
            description: '1. Liga, 2. Liga',
            season: '2024',
            sportType: 'rugby',
            teams: [],
          ),
        ],
      ),
      Sport(
        name: 'Tischtennis',
        icon: Icons.sports_tennis,
        color: Colors.teal,
        competitions: [
          Competition(
            name: 'Bundesliga',
            description: '1. Liga, 2. Liga',
            season: '2023/24',
            sportType: 'tabletennis',
            teams: [],
          ),
        ],
      ),
      Sport(
        name: 'Turnen',
        icon: Icons.sports_gymnastics,
        color: Colors.pink,
        competitions: [
          Competition(
            name: 'World Championships',
            description: 'WM, EM',
            season: '2024',
            sportType: 'gymnastics',
            teams: [],
          ),
        ],
      ),
      Sport(
        name: 'Reiten',
        icon: Icons.directions_run,
        color: Colors.amber,
        competitions: [
          Competition(
            name: 'Deutsche Meisterschaft',
            description: 'Deutsche Meister...',
            season: '2024',
            sportType: 'equestrian',
            teams: [],
          ),
        ],
      ),
    ];
    notifyListeners();
  }

  // Method to fetch sports from API
  Future<void> fetchSportsFromApi() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Replace with your actual API endpoint
      final response = await http.get(
        Uri.parse('https://api.example.com/sports'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> sportsJson = json.decode(response.body);
        _sports = sportsJson.map((s) => Sport.fromJson(s)).toList();
      } else {
        _error = 'Failed to load sports: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Network error: $e';
      // Keep mock data if API fails
      _loadMockData();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Method to fetch teams for a specific competition
  Future<void> fetchTeamsForCompetition(String competitionId) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.example.com/competitions/$competitionId/teams'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> teamsJson = json.decode(response.body);
        final teams = teamsJson.map((t) => Team.fromJson(t)).toList();

        // Update the competition with the fetched teams
        for (var sport in _sports) {
          for (var competition in sport.competitions) {
            if (competition.id == competitionId) {
              // Create a new competition with updated teams
              final updatedCompetition = Competition(
                id: competition.id,
                name: competition.name,
                description: competition.description,
                season: competition.season,
                sportType: competition.sportType,
                teams: teams,
              );
              
              // Replace the competition in the list
              final competitionIndex = sport.competitions.indexOf(competition);
              sport.competitions[competitionIndex] = updatedCompetition;
              break;
            }
          }
        }
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching teams: $e');
    }
  }

  void refreshData() {
    fetchSportsFromApi();
  }
}