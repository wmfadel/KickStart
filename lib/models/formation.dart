class Formation {
  TeamData homeTeam;
  TeamData awayTeam;
  int id;

  Formation({this.homeTeam, this.awayTeam});

  Formation.fromJson(Map<String, dynamic> json, String home, String away) {

    homeTeam = json[home] != null
        ? new TeamData.fromJson(json[home])
        : null;
    awayTeam = json[away] != null
        ? new TeamData.fromJson(json[away])
        : null;
  }

}

class TeamData {
  String formation;
  List<StartXI> startXI;
  List<StartXI> substitutes;
  String coach;

  TeamData({this.formation, this.startXI, this.substitutes, this.coach});

  TeamData.fromJson(Map<String, dynamic> json) {
    formation = json['formation'];
    if (json['startXI'] != null) {
      startXI = new List<StartXI>();
      json['startXI'].forEach((v) {
        startXI.add(new StartXI.fromJson(v));
      });
    }
    if (json['substitutes'] != null) {
      substitutes = new List<StartXI>();
      json['substitutes'].forEach((v) {
        substitutes.add(new StartXI.fromJson(v));
      });
    }
    coach = json['coach'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formation'] = this.formation;
    if (this.startXI != null) {
      data['startXI'] = this.startXI.map((v) => v.toJson()).toList();
    }
    if (this.substitutes != null) {
      data['substitutes'] = this.substitutes.map((v) => v.toJson()).toList();
    }
    data['coach'] = this.coach;
    return data;
  }
}

class StartXI {
  int teamId;
  int playerId;
  String player;
  int number;
  String pos;

  StartXI({this.teamId, this.playerId, this.player, this.number, this.pos});

  StartXI.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    playerId = json['player_id'];
    player = json['player'];
    number = json['number'];
    pos = json['pos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['player_id'] = this.playerId;
    data['player'] = this.player;
    data['number'] = this.number;
    data['pos'] = this.pos;
    return data;
  }
}
