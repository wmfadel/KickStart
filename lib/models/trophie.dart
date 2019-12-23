class Trophie {
  String league;
  String country;
  String season;
  String place;

  Trophie({this.league, this.country, this.season, this.place});

  Trophie.fromJson(Map<String, dynamic> json) {
    league = json['league'];
    country = json['country'];
    season = json['season'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['league'] = this.league;
    data['country'] = this.country;
    data['season'] = this.season;
    data['place'] = this.place;
    return data;
  }
}
