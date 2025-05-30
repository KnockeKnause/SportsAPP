class Sport {
  final String id;
  final String name;
  final String? apiName;
  //final Bool isTeamSport;
  //final ImageProvider? image;
  final List<Competition> competitions;

  Sport( {
    String? id,
    this.apiName,
    required this.name,
    //required this.isTeamSport,
    required this.competitions,
  }) : id = id ?? name.toLowerCase().replaceAll(' ', '_');

  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
      apiName: json['api_name'] ?? json['name'].toLowerCase().replaceAll(' ', '_'),
      id: json['id'],
      name: json['name'],
      competitions: (json['competitions'] as List)
          .map((c) => Competition.fromJson(c))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'competitions': competitions.map((c) => c.toJson()).toList(),
      'apiName': apiName,
    };
  }
}

class Competition {
  final String id;
  final String name;
  final String? description;
  final String? season;
  final String sportType;

  Competition({
    String? id,
    required this.name,
    this.description,
    this.season,
    required this.sportType,
  }) : id = id ?? '${sportType}_${name.toLowerCase().replaceAll(' ', '_')}';

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      id: json['idLeague'],
      name: json['strLeague'] ?? '',
      description: json['strDescriptionEN'],
      season: json['strCurrentSeason'],
      sportType: json['strSport'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'season': season,
      'sportType': sportType,
    };
  }
}

class Team {
  final String id;
  final String name;
  final String? sport;
  final String? logoUrl;

  Team({
    String? id,
    this.logoUrl,
    this.sport,
    required this.name,
  }) : id = id ?? name.toLowerCase().replaceAll(' ', '_');

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['idTeam'],
      name: json['strTeam'] ?? '',
      sport: json['strSport'] ?? '',
      logoUrl: json['strBadge'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sport': sport,
      'logoUrl': logoUrl,
    };
  }
}

class Country {
  final String apiName;
  final String name;
  final String? flagUrl;

  Country({
    required this.apiName,
    required this.name,
    this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      apiName: json['api_name'] ?? json['name'].toLowerCase().replaceAll(' ', '_'),
      name: json['name'],
      flagUrl: json['flag_url'],
    );
  }
}