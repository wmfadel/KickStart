class Country {
  String country;
  String code;
  String flag;

  Country({this.country, this.code, this.flag});

  Country.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    code = json['code'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['code'] = this.code;
    data['flag'] = this.flag;
    return data;
  }
}
