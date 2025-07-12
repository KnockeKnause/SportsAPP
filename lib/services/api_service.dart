import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sport.dart';

class ApiService {
  static const String baseUrl = 'https://www.thesportsdb.com/api/v1/json/123';
  static const Duration timeout = Duration(seconds: 10);

  static Future<List<Country>> fetchCountries(String sport) async {
    final response = await http.get(
      Uri.parse('your-api-endpoint/countries?sport_id=$sport'),
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }

  // Wettbewerbe für eine Sportart abrufen
  static Future<List<Competition>> fetchCompetitions(String sportName, String countryApiName) async {
    try {
      http.Response response;
      if (countryApiName.isEmpty) {
        response = await http
            .get(
              Uri.parse('$baseUrl/search_all_leagues.php?s=$sportName'),
            )
            .timeout(timeout);
      } else {
        response = await http
            .get(
              Uri.parse('$baseUrl/search_all_leagues.php?c=$countryApiName&s=$sportName'),
            )
            .timeout(timeout);
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        final List<dynamic> responseList = jsonBody['countries'];
        // Extrahiere alle Ligen als Competition-Objekte
        final List<Competition> competitions = responseList
            .map((item) => Competition.fromJson(item))
            .toList();
        return competitions;
      } else {
        throw ApiException('Failed to fetch competitions: ${response.statusCode}');
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

  //Teams für Competition abrufen 
  static Future<List<Team>> fetchTeams(String competition) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/search_all_teams.php?id=$competition'),
            //headers: headers,
          )
          .timeout(timeout);

            if (response.statusCode == 200) {
              final Map<String, dynamic> jsonBody = json.decode(response.body);

              final dynamic responseList = jsonBody['teams'];

              if (responseList == null) {
                // Kein Ergebnis, "teams": null
                throw ApiException('Keine Teams gefunden für diese Anfrage.');
              }

              final List<Team> teams = (responseList as List<dynamic>)
                  .map((item) => Team.fromJson(item))
                  .toList();

              return teams;
            } else {
              throw ApiException('Failed to fetch teams: ${response.statusCode}');
            }
          } catch (e) {
            if (e is ApiException) rethrow;
            throw ApiException('Network error: $e');
          }
  }
  // Spieler für eine Competition abrufen
  static Future<List<Player>> fetchPlayers(String competitionId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/lookup_all_players.php?id=$competitionId'),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        final dynamic responseList = jsonBody['player'];
        
        if (responseList == null) {
          // Kein Ergebnis, "players": null
          throw ApiException('Keine Spieler gefunden für diese Anfrage.');
        }

        return (responseList as List<dynamic>)
          .map((item) => Player.fromJson(item))
          .toList();
      } else {
        throw ApiException('Failed to fetch players: ${response.statusCode}');
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