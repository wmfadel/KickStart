import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/country.dart';
import '../environment.dart';

class CountriesProvider with ChangeNotifier {
  List<Country> _allCountries = [];
  List<Country> _selectedCountries = [];
  bool isLoading = false;

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
    return true;
  }

  addToFavorite(String code) {
    _selectedCountries.add(_allCountries.firstWhere((Country c) {
      return c.code == code;
    }));
    notifyListeners();
  }

  removeFromFavorite(String code) {
    _selectedCountries.removeWhere((Country c) {
      return c.code == code;
    });
    notifyListeners();
  }

  bool isFavorite(String code) {
    bool isFavorite = false;
    _selectedCountries.forEach((Country country) {
      if (country.code == code) isFavorite = true;
      return;
    });
    return isFavorite;
  }

  Country getCountryByCode(String code) {
    return _allCountries.firstWhere((Country country) => country.code == code);
  }
}
// https://www.api-football.com/documentation#documentation-v239-api-demo
