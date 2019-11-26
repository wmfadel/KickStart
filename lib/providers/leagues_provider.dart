import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../environment.dart';
import '../models/league.dart';
import '../models/country.dart';

class LeaguesProvider with ChangeNotifier {
  List<League> _leagues = [];
  List<Country> _countries = [];

  List<League> get leagues => [..._leagues];

  List<Country> get countries => [..._countries];

  LeaguesProvider(this._countries, this._leagues);

  Future<bool> fetchLeaguesByCountries() async {
    for (Country country in _countries) {
      http.Response response = await http.get(
          Environment.leaguesUrl + '${country.code}/${DateTime.now().year}',
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
