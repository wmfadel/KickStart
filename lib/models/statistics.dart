class Statistics {
  int id;
  ShotsOnGoal shotsOnGoal;
  ShotsOnGoal shotsOffGoal;
  ShotsOnGoal totalShots;
  ShotsOnGoal blockedShots;
  ShotsOnGoal shotsInsidebox;
  ShotsOnGoal shotsOutsidebox;
  ShotsOnGoal fouls;
  ShotsOnGoal cornerKicks;
  ShotsOnGoal offsides;
  ShotsOnGoal ballPossession;
  ShotsOnGoal yellowCards;
  ShotsOnGoal redCards;
  ShotsOnGoal goalkeeperSaves;
  ShotsOnGoal totalPasses;
  ShotsOnGoal passesAccurate;
  ShotsOnGoal passes;

  Statistics(
      { this.shotsOnGoal,
        this.shotsOffGoal,
        this.totalShots,
        this.blockedShots,
        this.shotsInsidebox,
        this.shotsOutsidebox,
        this.fouls,
        this.cornerKicks,
        this.offsides,
        this.ballPossession,
        this.yellowCards,
        this.redCards,
        this.goalkeeperSaves,
        this.totalPasses,
        this.passesAccurate,
        this.passes});



  Statistics.fromJson(Map<String, dynamic> json) {
    shotsOnGoal = json['Shots on Goal'] != null
        ? new ShotsOnGoal.fromJson(json['Shots on Goal'])
        : null;
    shotsOffGoal = json['Shots off Goal'] != null
        ? new ShotsOnGoal.fromJson(json['Shots off Goal'])
        : null;
    totalShots = json['Total Shots'] != null
        ? new ShotsOnGoal.fromJson(json['Total Shots'])
        : null;
    blockedShots = json['Blocked Shots'] != null
        ? new ShotsOnGoal.fromJson(json['Blocked Shots'])
        : null;
    shotsInsidebox = json['Shots insidebox'] != null
        ? new ShotsOnGoal.fromJson(json['Shots insidebox'])
        : null;
    shotsOutsidebox = json['Shots outsidebox'] != null
        ? new ShotsOnGoal.fromJson(json['Shots outsidebox'])
        : null;
    fouls =
    json['Fouls'] != null ? new ShotsOnGoal.fromJson(json['Fouls']) : null;
    cornerKicks = json['Corner Kicks'] != null
        ? new ShotsOnGoal.fromJson(json['Corner Kicks'])
        : null;
    offsides = json['Offsides'] != null
        ? new ShotsOnGoal.fromJson(json['Offsides'])
        : null;
    ballPossession = json['Ball Possession'] != null
        ? new ShotsOnGoal.fromJson(json['Ball Possession'])
        : null;
    yellowCards = json['Yellow Cards'] != null
        ? new ShotsOnGoal.fromJson(json['Yellow Cards'])
        : null;
    redCards = json['Red Cards'] != null
        ? new ShotsOnGoal.fromJson(json['Red Cards'])
        : null;
    goalkeeperSaves = json['Goalkeeper Saves'] != null
        ? new ShotsOnGoal.fromJson(json['Goalkeeper Saves'])
        : null;
    totalPasses = json['Total passes'] != null
        ? new ShotsOnGoal.fromJson(json['Total passes'])
        : null;
    passesAccurate = json['Passes accurate'] != null
        ? new ShotsOnGoal.fromJson(json['Passes accurate'])
        : null;
    passes = json['Passes %'] != null
        ? new ShotsOnGoal.fromJson(json['Passes %'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.shotsOnGoal != null) {
      data['Shots on Goal'] = this.shotsOnGoal.toJson();
    }
    if (this.shotsOffGoal != null) {
      data['Shots off Goal'] = this.shotsOffGoal.toJson();
    }
    if (this.totalShots != null) {
      data['Total Shots'] = this.totalShots.toJson();
    }
    if (this.blockedShots != null) {
      data['Blocked Shots'] = this.blockedShots.toJson();
    }
    if (this.shotsInsidebox != null) {
      data['Shots insidebox'] = this.shotsInsidebox.toJson();
    }
    if (this.shotsOutsidebox != null) {
      data['Shots outsidebox'] = this.shotsOutsidebox.toJson();
    }
    if (this.fouls != null) {
      data['Fouls'] = this.fouls.toJson();
    }
    if (this.cornerKicks != null) {
      data['Corner Kicks'] = this.cornerKicks.toJson();
    }
    if (this.offsides != null) {
      data['Offsides'] = this.offsides.toJson();
    }
    if (this.ballPossession != null) {
      data['Ball Possession'] = this.ballPossession.toJson();
    }
    if (this.yellowCards != null) {
      data['Yellow Cards'] = this.yellowCards.toJson();
    }
    if (this.redCards != null) {
      data['Red Cards'] = this.redCards.toJson();
    }
    if (this.goalkeeperSaves != null) {
      data['Goalkeeper Saves'] = this.goalkeeperSaves.toJson();
    }
    if (this.totalPasses != null) {
      data['Total passes'] = this.totalPasses.toJson();
    }
    if (this.passesAccurate != null) {
      data['Passes accurate'] = this.passesAccurate.toJson();
    }
    if (this.passes != null) {
      data['Passes %'] = this.passes.toJson();
    }
    return data;
  }
}

class ShotsOnGoal {
  String home;
  String away;

  ShotsOnGoal({this.home, this.away});

  ShotsOnGoal.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['home'] = this.home;
    data['away'] = this.away;
    return data;
  }
}
