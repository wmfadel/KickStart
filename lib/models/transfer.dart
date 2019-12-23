class Transfer {
  int playerId;
  String playerName;
  String transferDate;
  String type;
  TeamIn teamIn;
  TeamIn teamOut;
  int lastUpdate;

  Transfer(
      {this.playerId,
      this.playerName,
      this.transferDate,
      this.type,
      this.teamIn,
      this.teamOut,
      this.lastUpdate});

  Transfer.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerName = json['player_name'];
    transferDate = json['transfer_date'];
    type = json['type'];
    teamIn =
        json['team_in'] != null ? new TeamIn.fromJson(json['team_in']) : null;
    teamOut =
        json['team_out'] != null ? new TeamIn.fromJson(json['team_out']) : null;
    lastUpdate = json['lastUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['transfer_date'] = this.transferDate;
    data['type'] = this.type;
    if (this.teamIn != null) {
      data['team_in'] = this.teamIn.toJson();
    }
    if (this.teamOut != null) {
      data['team_out'] = this.teamOut.toJson();
    }
    data['lastUpdate'] = this.lastUpdate;
    return data;
  }
}

class TeamIn {
  int teamId;
  String teamName;

  TeamIn({this.teamId, this.teamName});

  TeamIn.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    teamName = json['team_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['team_name'] = this.teamName;
    return data;
  }
}
