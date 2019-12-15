import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/country.dart';
import '../environment.dart';

class CountriesProvider with ChangeNotifier {
  List<Country> _allCountries = [];

  bool isLoading = false;

  List<Country> get allCountries => [..._allCountries];


  Future<bool> fetchAllCountries() async {
    if (_allCountries.length > 1) return true;

    http.Response response = await http.get(Environment.countriesUrl,
        headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) {
      return false;
    }
    res['api']['countries'].forEach((country) {
      if (country['country'] != 'Israel')
        _allCountries.add(Country.fromJson(country));
    });
    return true;
  }

  Country getCountryByCode(String code) {
    return _allCountries.firstWhere((Country country) => country.code == code);
  }

  String getFlagByName(String name){
    String flag;
    print('countries count ${_allCountries.length}');
    flag = _allCountries.firstWhere((Country country)=>country.country==name).flag;
    return flag;
  }


}
// https://www.api-football.com/documentation#documentation-v239-api-demo
