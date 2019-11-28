class Standings {
  int rank;
  int teamId;
  String teamName;
  String logo;
  String group;
  String forme;
  String description;
  All all;
  All home;
  All away;
  int goalsDiff;
  int points;
  String lastUpdate;

  Standings(
      {this.rank,
        this.teamId,
        this.teamName,
        this.logo,
        this.group,
        this.forme,
        this.description,
        this.all,
        this.home,
        this.away,
        this.goalsDiff,
        this.points,
        this.lastUpdate});

  Standings.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    teamId = json['team_id'];
    teamName = json['teamName'];
    logo = json['logo'];
    group = json['group'];
    forme = json['forme'];
    description = json['description'];
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
    home = json['home'] != null ? new All.fromJson(json['home']) : null;
    away = json['away'] != null ? new All.fromJson(json['away']) : null;
    goalsDiff = json['goalsDiff'];
    points = json['points'];
    lastUpdate = json['lastUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rank'] = this.rank;
    data['team_id'] = this.teamId;
    data['teamName'] = this.teamName;
    data['logo'] = this.logo;
    data['group'] = this.group;
    data['forme'] = this.forme;
    data['description'] = this.description;
    if (this.all != null) {
      data['all'] = this.all.toJson();
    }
    if (this.home != null) {
      data['home'] = this.home.toJson();
    }
    if (this.away != null) {
      data['away'] = this.away.toJson();
    }
    data['goalsDiff'] = this.goalsDiff;
    data['points'] = this.points;
    data['lastUpdate'] = this.lastUpdate;
    return data;
  }
}

class All {
  int matchsPlayed;
  int win;
  int draw;
  int lose;
  int goalsFor;
  int goalsAgainst;

  All(
      {this.matchsPlayed,
        this.win,
        this.draw,
        this.lose,
        this.goalsFor,
        this.goalsAgainst});

  All.fromJson(Map<String, dynamic> json) {
    matchsPlayed = json['matchsPlayed'];
    win = json['win'];
    draw = json['draw'];
    lose = json['lose'];
    goalsFor = json['goalsFor'];
    goalsAgainst = json['goalsAgainst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matchsPlayed'] = this.matchsPlayed;
    data['win'] = this.win;
    data['draw'] = this.draw;
    data['lose'] = this.lose;
    data['goalsFor'] = this.goalsFor;
    data['goalsAgainst'] = this.goalsAgainst;
    return data;
  }
}
