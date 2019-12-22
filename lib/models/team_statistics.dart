class TeamStatistics {
  Matchs matchs;
  Goals goals;
  Goals goalsAvg;

  TeamStatistics({this.matchs, this.goals, this.goalsAvg});

  TeamStatistics.fromJson(Map<String, dynamic> json) {
    matchs =
        json['matchs'] != null ? new Matchs.fromJson(json['matchs']) : null;
    goals = json['goals'] != null ? new Goals.fromJson(json['goals']) : null;
    goalsAvg =
        json['goalsAvg'] != null ? new Goals.fromJson(json['goalsAvg']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.matchs != null) {
      data['matchs'] = this.matchs.toJson();
    }
    if (this.goals != null) {
      data['goals'] = this.goals.toJson();
    }
    if (this.goalsAvg != null) {
      data['goalsAvg'] = this.goalsAvg.toJson();
    }
    return data;
  }
}

class Matchs {
  MatchsPlayed matchsPlayed;
  MatchsPlayed wins;
  MatchsPlayed draws;
  MatchsPlayed loses;

  Matchs({this.matchsPlayed, this.wins, this.draws, this.loses});

  Matchs.fromJson(Map<String, dynamic> json) {
    matchsPlayed = json['matchsPlayed'] != null
        ? new MatchsPlayed.fromJson(json['matchsPlayed'])
        : null;
    wins =
        json['wins'] != null ? new MatchsPlayed.fromJson(json['wins']) : null;
    draws =
        json['draws'] != null ? new MatchsPlayed.fromJson(json['draws']) : null;
    loses =
        json['loses'] != null ? new MatchsPlayed.fromJson(json['loses']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.matchsPlayed != null) {
      data['matchsPlayed'] = this.matchsPlayed.toJson();
    }
    if (this.wins != null) {
      data['wins'] = this.wins.toJson();
    }
    if (this.draws != null) {
      data['draws'] = this.draws.toJson();
    }
    if (this.loses != null) {
      data['loses'] = this.loses.toJson();
    }
    return data;
  }
}

class MatchsPlayed {
  String home;
  String away;
  String total;

  MatchsPlayed({this.home, this.away, this.total});

  MatchsPlayed.fromJson(Map<String, dynamic> json) {
    home = json['home'].toString();
    away = json['away'].toString();
    total = json['total'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['home'] = this.home;
    data['away'] = this.away;
    data['total'] = this.total;
    return data;
  }
}

class Goals {
  MatchsPlayed goalsFor;
  GoalsFor goalsAgainst;

  Goals({this.goalsFor, this.goalsAgainst});

  Goals.fromJson(Map<String, dynamic> json) {
    goalsFor = json['goalsFor'] != null
        ? new MatchsPlayed.fromJson(json['goalsFor'])
        : null;
    goalsAgainst = json['goalsAgainst'] != null
        ? new GoalsFor.fromJson(json['goalsAgainst'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goalsFor != null) {
      data['goalsFor'] = this.goalsFor.toJson();
    }
    if (this.goalsAgainst != null) {
      data['goalsAgainst'] = this.goalsAgainst.toJson();
    }
    return data;
  }
}

class GoalsFor {
  String home;
  String away;
  String total;

  GoalsFor({this.home, this.away, this.total});

  GoalsFor.fromJson(Map<String, dynamic> json) {
    home = json['home'].toString();
    away = json['away'].toString();
    total = json['total'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['home'] = this.home;
    data['away'] = this.away;
    data['total'] = this.total;
    return data;
  }
}
