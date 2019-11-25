
class FixturesAvailable {
  bool events;
  bool lineups;
  bool statistics;
  bool playersStatistics;

  FixturesAvailable(
      {this.events, this.lineups, this.statistics, this.playersStatistics});

  FixturesAvailable.fromJson(Map<String, dynamic> json) {
    events = json['events'];
    lineups = json['lineups'];
    statistics = json['statistics'];
    playersStatistics = json['players_statistics'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['events'] = this.events;
    data['lineups'] = this.lineups;
    data['statistics'] = this.statistics;
    data['players_statistics'] = this.playersStatistics;
    return data;
  }
}
