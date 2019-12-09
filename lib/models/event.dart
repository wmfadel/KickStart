class Event {
  int elapsed;
  int teamId;
  String teamName;
  int playerId;
  String player;
  int assistId;
  String assist;
  String type;
  String detail;

  Event(
      {this.elapsed,
        this.teamId,
        this.teamName,
        this.playerId,
        this.player,
        this.assistId,
        this.assist,
        this.type,
        this.detail});

  Event.fromJson(Map<String, dynamic> json) {
    elapsed = json['elapsed'];
    teamId = json['team_id'];
    teamName = json['teamName'];
    playerId = json['player_id'];
    player = json['player'];
    assistId = json['assist_id'];
    assist = json['assist'];
    type = json['type'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['elapsed'] = this.elapsed;
    data['team_id'] = this.teamId;
    data['teamName'] = this.teamName;
    data['player_id'] = this.playerId;
    data['player'] = this.player;
    data['assist_id'] = this.assistId;
    data['assist'] = this.assist;
    data['type'] = this.type;
    data['detail'] = this.detail;
    return data;
  }
}
