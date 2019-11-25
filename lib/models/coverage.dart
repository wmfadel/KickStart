import './fixtures_available.dart';



class Coverage {
  bool standings;
  FixturesAvailable fixtures;
  bool players;
  bool topScorers;
  bool predictions;
  bool odds;

  Coverage(
      {this.standings,
        this.fixtures,
        this.players,
        this.topScorers,
        this.predictions,
        this.odds});

  Coverage.fromJson(Map<String, dynamic> json) {
    standings = json['standings'];
    fixtures = json['fixtures'] != null
        ? new FixturesAvailable.fromJson(json['fixtures'])
        : null;
    players = json['players'];
    topScorers = json['topScorers'];
    predictions = json['predictions'];
    odds = json['odds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['standings'] = this.standings;
    if (this.fixtures != null) {
      data['fixtures'] = this.fixtures.toJson();
    }
    data['players'] = this.players;
    data['topScorers'] = this.topScorers;
    data['predictions'] = this.predictions;
    data['odds'] = this.odds;
    return data;
  }
}