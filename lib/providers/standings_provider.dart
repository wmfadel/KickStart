import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kick_start/environment.dart';
import '../models/standings.dart';

class StandingsProvider with ChangeNotifier {
  List<Standings> _standings = [];
  int _currentTeam = 0;

  List<Standings> get standings => [..._standings];

  int get currentTeam => _currentTeam;

  Future<bool> fetchStandingsForLeague(int leagueId) async {
    if (_currentTeam == leagueId) return true;
    _currentTeam = leagueId;
    http.Response response = await http.get(
        '${Environment.standingsUrl}/$leagueId',
        headers: Environment.requestHeaders);

    Map<String, dynamic> res = json.decode(response.body);

    if (res['api']['results'] < 1) return false;

    _standings.clear();
    for (var item in res['api']['standings'][0]) {
      _standings.add(Standings.fromJson(item));
    }

    return true;
  }

  String getTamFlagById(int teamId) {
    String flag = '';
    bool complete = false;

    _standings.forEach((Standings s) {
      if (s.teamId == teamId) complete = true;
    });
    if (complete)
      flag = _standings.firstWhere((Standings s) => s.teamId == teamId).logo;

    return flag;
  }
}
