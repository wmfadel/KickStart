class League {
  int leagueId;
  String name;
  String type;
  String country;
  String countryCode;
  int season;
  String seasonStart;
  String seasonEnd;
  String logo;
  String flag;
  int standings;
  int isCurrent;

  League(
      {this.leagueId,
        this.name,
        this.type,
        this.country,
        this.countryCode,
        this.season,
        this.seasonStart,
        this.seasonEnd,
        this.logo,
        this.flag,
        this.standings,
        this.isCurrent});

  League.fromJson(Map<String, dynamic> json) {
    leagueId = json['league_id'];
    name = json['name'];
    type = json['type'];
    country = json['country'];
    countryCode = json['country_code'];
    season = json['season'];
    seasonStart = json['season_start'];
    seasonEnd = json['season_end'];
    logo = json['logo'];
    flag = json['flag'];
    standings = json['standings'];
    isCurrent = json['is_current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['league_id'] = this.leagueId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['season'] = this.season;
    data['season_start'] = this.seasonStart;
    data['season_end'] = this.seasonEnd;
    data['logo'] = this.logo;
    data['flag'] = this.flag;
    data['standings'] = this.standings;
    data['is_current'] = this.isCurrent;
    return data;
  }
}

