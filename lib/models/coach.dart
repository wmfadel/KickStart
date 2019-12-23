class Coach {
  int id;
  String name;
  String firstname;
  String lastname;
  int age;
  String birthDate;
  String birthPlace;
  String birthCountry;
  String nationality;
  String height;
  String weight;
  TeamModel team;
  List<Career> career;

  Coach(
      {this.id,
      this.name,
      this.firstname,
      this.lastname,
      this.age,
      this.birthDate,
      this.birthPlace,
      this.birthCountry,
      this.nationality,
      this.height,
      this.weight,
      this.team,
      this.career});

  Coach.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    age = json['age'];
    birthDate = json['birth_date'];
    birthPlace = json['birth_place'];
    birthCountry = json['birth_country'];
    nationality = json['nationality'];
    height = json['height'];
    weight = json['weight'];
    team = json['team'] != null ? new TeamModel.fromJson(json['team']) : null;
    if (json['career'] != null) {
      career = new List<Career>();
      json['career'].forEach((v) {
        career.add(new Career.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['age'] = this.age;
    data['birth_date'] = this.birthDate;
    data['birth_place'] = this.birthPlace;
    data['birth_country'] = this.birthCountry;
    data['nationality'] = this.nationality;
    data['height'] = this.height;
    data['weight'] = this.weight;
    if (this.team != null) {
      data['team'] = this.team.toJson();
    }
    if (this.career != null) {
      data['career'] = this.career.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamModel {
  int id;
  String name;

  TeamModel({this.id, this.name});

  TeamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Career {
  TeamModel team;
  String start;
  String end;

  Career({this.team, this.start, this.end});

  Career.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? new TeamModel.fromJson(json['team']) : null;
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.team != null) {
      data['team'] = this.team.toJson();
    }
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}
