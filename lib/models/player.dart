class Player {
  int playerId;
  String playerName;
  String firstname;
  String lastname;
  String position;
  int age;
  String birthDate;
  String birthPlace;
  String birthCountry;
  String nationality;
  String height;
  String weight;

  Player(
      {this.playerId,
      this.playerName,
      this.firstname,
      this.lastname,
      this.position,
      this.age,
      this.birthDate,
      this.birthPlace,
      this.birthCountry,
      this.nationality,
      this.height,
      this.weight});

  Player.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerName = json['player_name'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    position = json['position'];
    age = json['age'];
    birthDate = json['birth_date'];
    birthPlace = json['birth_place'];
    birthCountry = json['birth_country'];
    nationality = json['nationality'];
    height = json['height'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['position'] = this.position;
    data['age'] = this.age;
    data['birth_date'] = this.birthDate;
    data['birth_place'] = this.birthPlace;
    data['birth_country'] = this.birthCountry;
    data['nationality'] = this.nationality;
    data['height'] = this.height;
    data['weight'] = this.weight;
    return data;
  }
}
