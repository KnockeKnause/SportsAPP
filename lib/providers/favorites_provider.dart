import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/sport.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Competition> _favoriteCompetitions = [];
  List<Team> _favoriteTeams = [];
  bool _isLoaded = false;

  List<Competition> get favoriteCompetitions => _favoriteCompetitions;
  List<Team> get favoriteTeams => _favoriteTeams;
  bool get isLoaded => _isLoaded;

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
      print('DEBUG: Competition added to favorites: ${competition.name}');
      print('DEBUG: Total competitions in favorites: ${_favoriteCompetitions.length}');
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeCompetitionFromFavorites(String competitionId) {
    _favoriteCompetitions.removeWhere((c) => c.id == competitionId);
    print('DEBUG: Competition removed from favorites: $competitionId');
    print('DEBUG: Total competitions in favorites: ${_favoriteCompetitions.length}');
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
      print('DEBUG: Team added to favorites: ${team.name}');
      print('DEBUG: Total teams in favorites: ${_favoriteTeams.length}');
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeTeamFromFavorites(String teamId) {
    _favoriteTeams.removeWhere((t) => t.id == teamId);
    print('DEBUG: Team removed from favorites: $teamId');
    print('DEBUG: Total teams in favorites: ${_favoriteTeams.length}');
    _saveFavorites();
    notifyListeners();
  }

  // Persistence
  Future<void> _loadFavorites() async {
    try {
      print('DEBUG: Starting to load favorites...');
      final prefs = await SharedPreferences.getInstance();
      
      // Debug: Alle Keys in SharedPreferences anzeigen
      final allKeys = prefs.getKeys();
      print('DEBUG: All keys in SharedPreferences: $allKeys');
      
      // Load competitions
      final competitionsJson = prefs.getString('favorite_competitions');
      print('DEBUG: Raw competitions JSON: $competitionsJson');
      
      if (competitionsJson != null && competitionsJson.isNotEmpty) {
        try {
          final List<dynamic> competitionsList = json.decode(competitionsJson);
          _favoriteCompetitions = competitionsList
              .map((c) => Competition.fromJson(c))
              .toList();
          print('DEBUG: Loaded ${_favoriteCompetitions.length} competitions');
        } catch (e) {
          print('DEBUG: Error parsing competitions JSON: $e');
        }
      } else {
        print('DEBUG: No competitions found in SharedPreferences');
      }

      // Load teams
      final teamsJson = prefs.getString('favorite_teams');
      print('DEBUG: Raw teams JSON: $teamsJson');
      
      if (teamsJson != null && teamsJson.isNotEmpty) {
        try {
          final List<dynamic> teamsList = json.decode(teamsJson);
          _favoriteTeams = teamsList
              .map((t) => Team.fromJson(t))
              .toList();
          print('DEBUG: Loaded ${_favoriteTeams.length} teams');
        } catch (e) {
          print('DEBUG: Error parsing teams JSON: $e');
        }
      } else {
        print('DEBUG: No teams found in SharedPreferences');
      }

      _isLoaded = true;
      print('DEBUG: Favorites loading completed');
      notifyListeners();
    } catch (e) {
      print('DEBUG: Error loading favorites: $e');
      _isLoaded = true;
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    try {
      print('DEBUG: Starting to save favorites...');
      final prefs = await SharedPreferences.getInstance();
      
      // Save competitions
      final competitionsJson = json.encode(
        _favoriteCompetitions.map((c) => c.toJson()).toList()
      );
      print('DEBUG: Saving competitions JSON: $competitionsJson');
      
      final competitionsSaved = await prefs.setString('favorite_competitions', competitionsJson);
      print('DEBUG: Competitions saved successfully: $competitionsSaved');

      // Save teams
      final teamsJson = json.encode(
        _favoriteTeams.map((t) => t.toJson()).toList()
      );
      print('DEBUG: Saving teams JSON: $teamsJson');
      
      final teamsSaved = await prefs.setString('favorite_teams', teamsJson);
      print('DEBUG: Teams saved successfully: $teamsSaved');
      
      // Verify save by reading back
      final verifyCompetitions = prefs.getString('favorite_competitions');
      final verifyTeams = prefs.getString('favorite_teams');
      print('DEBUG: Verification - competitions: ${verifyCompetitions != null}');
      print('DEBUG: Verification - teams: ${verifyTeams != null}');
      
    } catch (e) {
      print('DEBUG: Error saving favorites: $e');
    }
  }

  void clearAllFavorites() {
    _favoriteCompetitions.clear();
    _favoriteTeams.clear();
    _saveFavorites();
    notifyListeners();
  }

  // Debug-Funktion zum manuellen Testen
  Future<void> debugSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys();
    print('DEBUG: All SharedPreferences keys: $allKeys');
    
    for (String key in allKeys) {
      final value = prefs.get(key);
      print('DEBUG: $key = $value');
    }
  }

  // Methode zum manuellen Neuladen der Favoriten
  Future<void> reloadFavorites() async {
    _isLoaded = false;
    await _loadFavorites();
  }
}