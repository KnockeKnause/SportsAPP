import 'package:flutter/material.dart';

class Sport {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final List<Competition> competitions;

  Sport({
    String? id,
    required this.name,
    required this.icon,
    required this.color,
    required this.competitions,
  }) : id = id ?? name.toLowerCase().replaceAll(' ', '_');

  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
      id: json['id'],
      name: json['name'],
      icon: _getIconFromString(json['icon']),
      color: Color(json['color']),
      competitions: (json['competitions'] as List)
          .map((c) => Competition.fromJson(c))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon.codePoint,
      'color': color.value,
      'competitions': competitions.map((c) => c.toJson()).toList(),
    };
  }

  static IconData _getIconFromString(dynamic iconData) {
    if (iconData is int) {
      return IconData(iconData, fontFamily: 'MaterialIcons');
    }
    return Icons.sports;
  }
}

class Competition {
  final String id;
  final String name;
  final String? description;
  final String? season;
  final String sportType;
  final List<Team> teams;

  Competition({
    String? id,
    required this.name,
    this.description,
    this.season,
    required this.sportType,
    this.teams = const [],
  }) : id = id ?? '${sportType}_${name.toLowerCase().replaceAll(' ', '_')}';

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      season: json['season'],
      sportType: json['sportType'],
      teams: (json['teams'] as List?)
          ?.map((t) => Team.fromJson(t))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'season': season,
      'sportType': sportType,
      'teams': teams.map((t) => t.toJson()).toList(),
    };
  }
}

class Team {
  final String id;
  final String name;
  final String? city;
  final String? league;
  final String? country;

  Team({
    String? id,
    required this.name,
    this.city,
    this.league,
    this.country,
  }) : id = id ?? name.toLowerCase().replaceAll(' ', '_');

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      league: json['league'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'league': league,
      'country': country,
    };
  }
}