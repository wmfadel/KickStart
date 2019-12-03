class Fixture {
  int fixtureId;
  int leagueId;
  League league;
  String eventDate;
  int eventTimestamp;
  int firstHalfStart;
  int secondHalfStart;
  String round;
  String status;
  String statusShort;
  int elapsed;
  String venue;
  String referee;
  HomeTeam homeTeam;
  HomeTeam awayTeam;
  int goalsHomeTeam;
  int goalsAwayTeam;
  Score score;

  Fixture(
      {this.fixtureId,
        this.leagueId,
        this.league,
        this.eventDate,
        this.eventTimestamp,
        this.firstHalfStart,
        this.secondHalfStart,
        this.round,
        this.status,
        this.statusShort,
        this.elapsed,
        this.venue,
        this.referee,
        this.homeTeam,
        this.awayTeam,
        this.goalsHomeTeam,
        this.goalsAwayTeam,
        this.score});

  Fixture.fromJson(Map<String, dynamic> json) {
    fixtureId = json['fixture_id'];
    leagueId = json['league_id'];
    league =
    json['league'] != null ? new League.fromJson(json['league']) : null;
    eventDate = json['event_date'];
    eventTimestamp = json['event_timestamp'];
    firstHalfStart = json['firstHalfStart'];
    secondHalfStart = json['secondHalfStart'];
    round = json['round'];
    status = json['status'];
    statusShort = json['statusShort'];
    elapsed = json['elapsed'];
    venue = json['venue'];
    venue = json['referee'];
    homeTeam = json['homeTeam'] != null
        ? new HomeTeam.fromJson(json['homeTeam'])
        : null;
    awayTeam = json['awayTeam'] != null
        ? new HomeTeam.fromJson(json['awayTeam'])
        : null;
    goalsHomeTeam = json['goalsHomeTeam']??0;
    goalsAwayTeam = json['goalsAwayTeam']??0;
    score = json['score'] != null ? new Score.fromJson(json['score']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fixture_id'] = this.fixtureId;
    data['league_id'] = this.leagueId;
    if (this.league != null) {
      data['league'] = this.league.toJson();
    }
    data['event_date'] = this.eventDate;
    data['event_timestamp'] = this.eventTimestamp;
    data['firstHalfStart'] = this.firstHalfStart;
    data['secondHalfStart'] = this.secondHalfStart;
    data['round'] = this.round;
    data['status'] = this.status;
    data['statusShort'] = this.statusShort;
    data['elapsed'] = this.elapsed;
    data['venue'] = this.venue;
    data['referee'] = this.referee;
    if (this.homeTeam != null) {
      data['homeTeam'] = this.homeTeam.toJson();
    }
    if (this.awayTeam != null) {
      data['awayTeam'] = this.awayTeam.toJson();
    }
    data['goalsHomeTeam'] = this.goalsHomeTeam;
    data['goalsAwayTeam'] = this.goalsAwayTeam;
    if (this.score != null) {
      data['score'] = this.score.toJson();
    }
    return data;
  }
}

class League {
  String name;
  String country;
  String logo;
  String flag;

  League({this.name, this.country, this.logo, this.flag});

  League.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['country'] = this.country;
    data['logo'] = this.logo;
    data['flag'] = this.flag;
    return data;
  }
}

class HomeTeam {
  int teamId;
  String teamName;
  String logo;

  HomeTeam({this.teamId, this.teamName, this.logo});

  HomeTeam.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    teamName = json['team_name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['team_name'] = this.teamName;
    data['logo'] = this.logo;
    return data;
  }
}

class Score {
  String halftime;
  String fulltime;
  String extratime;
  String penalty;

  Score({this.halftime, this.fulltime, this.extratime, this.penalty});

  Score.fromJson(Map<String, dynamic> json) {
    halftime = json['halftime'];
    fulltime = json['fulltime'];
    extratime = json['extratime'];
    penalty = json['penalty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['halftime'] = this.halftime;
    data['fulltime'] = this.fulltime;
    data['extratime'] = this.extratime;
    data['penalty'] = this.penalty;
    return data;
  }
}
