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
    _loadSports();
  }

  // Mock data for demonstration - replace with real API calls
  void _loadSports() {
    _sports = [
      Sport(id: '1', apiName: 'Soccer', name: 'Fußball', competitions:[]),
      Sport(id: '2', apiName: 'Tennis', name: 'Tennis', competitions:[]),
      Sport(id: '4', apiName: 'Basketball',name: 'Basketball', competitions:[]),
      Sport(id: '5', apiName: 'Spikeball',name: 'Spikeball', competitions:[]),
      Sport(id: '6', apiName: 'Rugby',name: 'Rugby', competitions:[]),
      Sport(id: '7', apiName: 'Baseball',name: 'Baseball', competitions:[]),
      Sport(id: '8', apiName: 'Formel 1',name: 'Formel 1', competitions:[]),
      Sport(id: '9', apiName: 'Handball',name: 'Handball', competitions:[]),
      Sport(id: '10', apiName: 'American Football',name: 'American Football', competitions:[]),
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
      _loadSports();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Method to fetch teams for a specific competition
  /* Future<void> fetchTeamsForCompetition(String competitionId) async {
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
  } */
}