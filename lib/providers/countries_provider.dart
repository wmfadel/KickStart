import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/country.dart';
import '../environment.dart';

class CountriesProvider with ChangeNotifier {
  List<Country> _allCountries = [];
  List<Country> _selectedCountries = [];

  List<Country> get allCountries => [..._allCountries];

  List<Country> get selectedCountries => [..._selectedCountries];

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
    // TODO delete this. checking for data
    print('we got ${_allCountries.length} country');
    print('request url: ${Environment.countriesUrl}');
    print(
        'first one: ${_allCountries[0].country} - ${_allCountries[0].code} - ${_allCountries[0].flag}');

    for (int i = 0; i < _allCountries.length; i++) {
      print('flag ${_allCountries[i].code}: ${_allCountries[i].flag}');
    }
    return true;
  }

  addToFavorite(String code) {
    _selectedCountries.add(_allCountries.firstWhere((Country c) {
      return c.code == code;
    }));
  }

  removeFromFavorite(String code) {
    _selectedCountries.removeWhere((Country c) {
      return c.code == code;
    });
  }

  bool isFavorite(String code) {
    bool isFavorite = false;
    _selectedCountries.forEach((Country country) {
      if (country.code == code) isFavorite = true;
      return;
    });
    return isFavorite;
  }
}
