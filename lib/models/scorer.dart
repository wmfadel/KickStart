class Scorer {
  int playerId;
  String playerName;
  String firstname;
  String lastname;
  String position;
  String nationality;
  int teamId;
  String teamName;
  Games games;
  Goals goals;
  Shots shots;
  Penalty penalty;
  Cards cards;

  Scorer(
      {this.playerId,
        this.playerName,
        this.firstname,
        this.lastname,
        this.position,
        this.nationality,
        this.teamId,
        this.teamName,
        this.games,
        this.goals,
        this.shots,
        this.penalty,
        this.cards});

  Scorer.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerName = json['player_name'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    position = json['position'];
    nationality = json['nationality'];
    teamId = json['team_id'];
    teamName = json['team_name'];
    games = json['games'] != null ? new Games.fromJson(json['games']) : null;
    goals = json['goals'] != null ? new Goals.fromJson(json['goals']) : null;
    shots = json['shots'] != null ? new Shots.fromJson(json['shots']) : null;
    penalty =
    json['penalty'] != null ? new Penalty.fromJson(json['penalty']) : null;
    cards = json['cards'] != null ? new Cards.fromJson(json['cards']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['position'] = this.position;
    data['nationality'] = this.nationality;
    data['team_id'] = this.teamId;
    data['team_name'] = this.teamName;
    if (this.games != null) {
      data['games'] = this.games.toJson();
    }
    if (this.goals != null) {
      data['goals'] = this.goals.toJson();
    }
    if (this.shots != null) {
      data['shots'] = this.shots.toJson();
    }
    if (this.penalty != null) {
      data['penalty'] = this.penalty.toJson();
    }
    if (this.cards != null) {
      data['cards'] = this.cards.toJson();
    }
    return data;
  }
}

class Games {
  int appearences;
  int minutesPlayed;

  Games({this.appearences, this.minutesPlayed});

  Games.fromJson(Map<String, dynamic> json) {
    appearences = json['appearences'];
    minutesPlayed = json['minutes_played'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appearences'] = this.appearences;
    data['minutes_played'] = this.minutesPlayed;
    return data;
  }
}

class Goals {
  int total;
  int assists;
  int conceded;

  Goals({this.total, this.assists, this.conceded});

  Goals.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    assists = json['assists'];
    conceded = json['conceded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['assists'] = this.assists;
    data['conceded'] = this.conceded;
    return data;
  }
}

class Shots {
  int total;
  int on;

  Shots({this.total, this.on});

  Shots.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    on = json['on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['on'] = this.on;
    return data;
  }
}

class Penalty {
  int won;
  int commited;
  int success;
  int missed;
  int saved;

  Penalty({this.won, this.commited, this.success, this.missed, this.saved});

  Penalty.fromJson(Map<String, dynamic> json) {
    won = json['won'];
    commited = json['commited'];
    success = json['success'];
    missed = json['missed'];
    saved = json['saved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['won'] = this.won;
    data['commited'] = this.commited;
    data['success'] = this.success;
    data['missed'] = this.missed;
    data['saved'] = this.saved;
    return data;
  }
}

class Cards {
  int yellow;
  int secondYellow;
  int red;

  Cards({this.yellow, this.secondYellow, this.red});

  Cards.fromJson(Map<String, dynamic> json) {
    yellow = json['yellow'];
    secondYellow = json['second_yellow'];
    red = json['red'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yellow'] = this.yellow;
    data['second_yellow'] = this.secondYellow;
    data['red'] = this.red;
    return data;
  }
}
