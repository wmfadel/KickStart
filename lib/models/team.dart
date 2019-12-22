class Team {
  int teamId;
  String name;
  String logo;
  String country;
  int founded;
  String venueName;
  String venueSurface;
  String venueAddress;
  String venueCity;
  int venueCapacity;

  Team(
      {this.teamId,
      this.name,
      this.logo,
      this.country,
      this.founded,
      this.venueName,
      this.venueSurface,
      this.venueAddress,
      this.venueCity,
      this.venueCapacity});

  Team.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    name = json['name'];
    logo = json['logo'];
    country = json['country'];
    founded = json['founded'];
    venueName = json['venue_name'];
    venueSurface = json['venue_surface'];
    venueAddress = json['venue_address'];
    venueCity = json['venue_city'];
    venueCapacity = json['venue_capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['country'] = this.country;
    data['founded'] = this.founded;
    data['venue_name'] = this.venueName;
    data['venue_surface'] = this.venueSurface;
    data['venue_address'] = this.venueAddress;
    data['venue_city'] = this.venueCity;
    data['venue_capacity'] = this.venueCapacity;
    return data;
  }
}
