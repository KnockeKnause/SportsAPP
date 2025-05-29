import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sport.dart';

class ApiService {
  static const String baseUrl = 'https://v3.football.api-sports.io/'; // Ersetzen Sie mit Ihrer API-URL
  static const Duration timeout = Duration(seconds: 10);

  // Headers für alle API-Anfragen
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'x-rapidapi-key': '39c957bce6f19bce08a4858574b55815',
    'x-rapidapi-host': 'v3.football.api-sports.io'
    // Fügen Sie hier API-Keys oder Authentifizierungs-Header hinzu
    // 'Authorization': 'Bearer YOUR_API_KEY',
  };

  // Alle Sportarten abrufen
  static Future<List<Sport>> fetchSports() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/sports'),
            headers: headers,
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> sportsJson = json.decode(response.body);
        return sportsJson.map((s) => Sport.fromJson(s)).toList();
      } else {
        throw ApiException('Failed to fetch sports: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: $e');
    }
  }

  // Wettbewerbe für eine Sportart abrufen
  static Future<List<Competition>> fetchCompetitions(String sportId) async {
    try {
      final response = await http
          .get(
            Uri.parse('https://v3.football.api-sports.io/teams?id=1'),
            headers: headers,
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> competitionsJson = json.decode(response.body);
        return competitionsJson.map((c) => Competition.fromJson(c)).toList();
      } else {
        throw ApiException('Failed to fetch competitions: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: $e');
    }
  }

  // Teams für einen Wettbewerb abrufen
  static Future<List<Team>> fetchTeams(String competitionId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/competitions/$competitionId/teams'),
            headers: headers,
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> teamsJson = json.decode(response.body);
        return teamsJson.map((t) => Team.fromJson(t)).toList();
      } else {
        throw ApiException('Failed to fetch teams: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: $e');
    }
  }

  // Spezifische Sportart suchen
  static Future<List<Sport>> searchSports(String query) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/sports/search?q=${Uri.encodeComponent(query)}'),
            headers: headers,
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> sportsJson = json.decode(response.body);
        return sportsJson.map((s) => Sport.fromJson(s)).toList();
      } else {
        throw ApiException('Failed to search sports: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: $e');
    }
  }

  // Team-Details abrufen
  static Future<Team> fetchTeamDetails(String teamId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/teams/$teamId'),
            headers: headers,
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final teamJson = json.decode(response.body);
        return Team.fromJson(teamJson);
      } else {
        throw ApiException('Failed to fetch team details: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: $e');
    }
  }

  // Wettbewerb-Details abrufen
  static Future<Competition> fetchCompetitionDetails(String competitionId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/competitions/$competitionId'),
            headers: headers,
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final competitionJson = json.decode(response.body);
        return Competition.fromJson(competitionJson);
      } else {
        throw ApiException('Failed to fetch competition details: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: $e');
    }
  }

  // Aktuelle Ergebnisse/Standings abrufen (optional)
  static Future<Map<String, dynamic>> fetchStandings(String competitionId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/competitions/$competitionId/standings'),
            headers: headers,
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ApiException('Failed to fetch standings: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: $e');
    }
  }
}

// Custom Exception für API-Fehler
class ApiException implements Exception {
  final String message;
  
  ApiException(this.message);
  
  @override
  String toString() => 'ApiException: $message';
}