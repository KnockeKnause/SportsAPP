import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/sport.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Competition> _favoriteCompetitions = [];
  List<Team> _favoriteTeams = [];

  List<Competition> get favoriteCompetitions => _favoriteCompetitions;
  List<Team> get favoriteTeams => _favoriteTeams;

  FavoritesProvider() {
    _loadFavorites();
  }

  // Competition favorites
  bool isCompetitionFavorite(String competitionId) {
    return _favoriteCompetitions.any((c) => c.id == competitionId);
  }

  void addCompetitionToFavorites(Competition competition) {
    if (!isCompetitionFavorite(competition.id)) {
      _favoriteCompetitions.add(competition);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeCompetitionFromFavorites(String competitionId) {
    _favoriteCompetitions.removeWhere((c) => c.id == competitionId);
    _saveFavorites();
    notifyListeners();
  }

  // Team favorites
  bool isTeamFavorite(String teamId) {
    return _favoriteTeams.any((t) => t.id == teamId);
  }

  void addTeamToFavorites(Team team) {
    if (!isTeamFavorite(team.id)) {
      _favoriteTeams.add(team);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeTeamFromFavorites(String teamId) {
    _favoriteTeams.removeWhere((t) => t.id == teamId);
    _saveFavorites();
    notifyListeners();
  }

  // Persistence
  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load competitions
    final competitionsJson = prefs.getString('favorite_competitions');
    if (competitionsJson != null) {
      final List<dynamic> competitionsList = json.decode(competitionsJson);
      _favoriteCompetitions = competitionsList
          .map((c) => Competition.fromJson(c))
          .toList();
    }

    // Load teams
    final teamsJson = prefs.getString('favorite_teams');
    if (teamsJson != null) {
      final List<dynamic> teamsList = json.decode(teamsJson);
      _favoriteTeams = teamsList
          .map((t) => Team.fromJson(t))
          .toList();
    }

    notifyListeners();
  }

  void _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Save competitions
    final competitionsJson = json.encode(
      _favoriteCompetitions.map((c) => c.toJson()).toList()
    );
    await prefs.setString('favorite_competitions', competitionsJson);

    // Save teams
    final teamsJson = json.encode(
      _favoriteTeams.map((t) => t.toJson()).toList()
    );
    await prefs.setString('favorite_teams', teamsJson);
  }

  void clearAllFavorites() {
    _favoriteCompetitions.clear();
    _favoriteTeams.clear();
    _saveFavorites();
    notifyListeners();
  }
}