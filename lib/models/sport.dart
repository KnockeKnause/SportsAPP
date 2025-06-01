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
  final String? season;
  final String sportType;

  Competition({
    required this.id,
    required this.name,
    this.season,
    required this.sportType,
  });

  @override
  String toString() {
    return 'Competition{id: $id, name: $name, season: $season, sportType: $sportType}';
  }

  // Universelle fromJson die beide Formate unterstützt
  factory Competition.fromJson(Map<String, dynamic> json) {

    String id;
    String name;
    String? season;
    String sportType;

    // Prüfe ob es API-Format oder SharedPreferences-Format ist
    if (json.containsKey('idLeague')) {
      // API-Format
      id = json['idLeague']?.toString() ?? '';
      name = json['strLeague']?.toString() ?? '';
      season = json['strCurrentSeason']?.toString();
      sportType = json['strSport']?.toString() ?? '';
    } else {
      // SharedPreferences-Format
      id = json['id']?.toString() ?? '';
      name = json['name']?.toString() ?? '';
      season = json['season']?.toString();
      sportType = json['sportType']?.toString() ?? '';
    }
    
    final competition = Competition(
      id: id,
      name: name,
      season: season,
      sportType: sportType,
    );
    return competition;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'season': season,
      'sportType': sportType,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Competition && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
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

  @override
  String toString() {
    return 'Team{id: $id, name: $name, sport: $sport, logoUrl: $logoUrl}';
  }

  factory Team.fromJson(Map<String, dynamic> json) {

    String id;
    String name;
    String? sport;
    String? logoUrl;

    // Prüfe ob es API-Format oder SharedPreferences-Format ist
   if (json.containsKey('idTeam')) { 
      id= json['idTeam']?.toString() ?? '';
      name= json['strTeam']?.toString() ?? '';
      sport= json['strSport']?.toString() ?? '';
      logoUrl= json['strBadge']?.toString() ?? '';
    } else {
      
        id= json['id']?.toString() ?? '';
        name= json['name']?.toString() ?? '';
        sport= json['sport']?.toString();
        logoUrl= json['logoUrl']?.toString();
    }

    final team = Team(
      id: id,
      name: name,
      sport: sport,
      logoUrl: logoUrl,
    );
    return team;

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