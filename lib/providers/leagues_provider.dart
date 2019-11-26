import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../environment.dart';
import '../models/league.dart';
import '../models/country.dart';

class LeaguesProvider with ChangeNotifier {
  List<League> _leagues = [];
  List<Country> _countries = [];
  // this will get wrong results for most of the year
  int _season = DateTime.now().year;

  List<League> get leagues => [..._leagues];

  List<Country> get countries => [..._countries];

  LeaguesProvider(this._countries, this._leagues);

  Future<Void> _fetchCurrentSeason() async {
    http.Response response = await http.get(Environment.seasonUrl,
        headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'].length < 1) {
      _season = DateTime.now().year;
    } else {
      List<int> _seasons = res['api']['seasons'];
      _season = _seasons[_seasons.length - 1];
    }
  }

  Future<bool> fetchLeaguesByCountries() async {
    // check if we have the current season
    // if (_season == null) await _fetchCurrentSeason();

    for (Country country in _countries) {
      http.Response response = await http.get(
          Environment.leaguesUrl + '${country.code}/$_season',
          headers: Environment.requestHeaders);
      print('request url' +
          Environment.leaguesUrl +
          '${country.code}/${DateTime.now().year}');
      print(response.body.toString());
      Map<String, dynamic> res = json.decode(response.body);
      for (int i = 0; i < res['api']['leagues'].length; i++) {
        _leagues.add(League.fromJson(res['api']['leagues'][i]));
        print(_leagues[i].name);
      }
    }
    return true;
  }
}
