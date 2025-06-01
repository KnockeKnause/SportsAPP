import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/sport.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Competition> _favoriteCompetitions = [];
  List<Team> _favoriteTeams = [];
  List<Player> _favoritePlayer = [];
  bool _isLoaded = false;

  List<Competition> get favoriteCompetitions => _favoriteCompetitions;
  List<Team> get favoriteTeams => _favoriteTeams;
  List<Player> get favoritePlayer => _favoritePlayer;
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

  // Player favorites
    // Competition favorites
  bool isPlayerFavorite(String playerid) {
    return _favoritePlayer.any((p) => p.id == playerid);
  }

  void addPlayerToFavorites(Player player) {
    if (!isCompetitionFavorite(player.id)) {
      _favoritePlayer.add(player);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removePlayerFromFavorites(String playerid) {
    _favoritePlayer.removeWhere((p) => p.id == playerid);
    _saveFavorites();
    notifyListeners();
  }

  // Persistence
  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load competitions
      final competitionsJson = prefs.getString('favorite_competitions');
      
      if (competitionsJson != null && competitionsJson.isNotEmpty) {
        try {
          final List<dynamic> competitionsList = json.decode(competitionsJson);
          _favoriteCompetitions = competitionsList
              .map((c) => Competition.fromJson(c))
              .toList();
        } catch (e) {
          // Silent error handling - corrupted data will be ignored
        }
      }

      // Load teams
      final teamsJson = prefs.getString('favorite_teams');
      
      if (teamsJson != null && teamsJson.isNotEmpty) {
        try {
          final List<dynamic> teamsList = json.decode(teamsJson);
          _favoriteTeams = teamsList
              .map((t) => Team.fromJson(t))
              .toList();
        } catch (e) {
          // Silent error handling - corrupted data will be ignored
        }
      }

      // Load players
      final playersJson = prefs.getString('favorite_players');
      if (playersJson != null && playersJson.isNotEmpty) {
        try {
          final List<dynamic> playersList = json.decode(playersJson);
          _favoritePlayer = playersList
              .map((p) => Player.fromJson(p))
              .toList();
        } catch (e) {
          // Silent error handling - corrupted data will be ignored
        }
      }

      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      _isLoaded = true;
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    try {
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

      // Save players
      final playersJson = json.encode(
        _favoritePlayer.map((p) => p.toJson()).toList()
      );
      await prefs.setString('favorite_players', playersJson);
      
    } catch (e) {
      // Silent error handling
    }
  }

  void clearAllFavorites() {
    _favoriteCompetitions.clear();
    _favoriteTeams.clear();
    _favoritePlayer.clear();
    _saveFavorites();
    notifyListeners();
  }

  // Methode zum manuellen Neuladen der Favoriten
  Future<void> reloadFavorites() async {
    _isLoaded = false;
    await _loadFavorites();
  }
}