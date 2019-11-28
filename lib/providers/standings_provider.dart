import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kick_start/environment.dart';
import '../models/standings.dart';

class StandingsProvider with ChangeNotifier {
  List<Standings> _standings = [];
  int _currentTeam=0;

  List<Standings> get standings => [..._standings];
  int get currentTeam => _currentTeam;

  Future<bool> fetchStandingsForLeague(int leagueId) async {
   if(_currentTeam == leagueId) return true;
    _currentTeam = leagueId;
    http.Response response = await http.get(
        '${Environment.standingsUrl}/$leagueId',
        headers: Environment.requestHeaders);
    print('standings url: ${Environment.standingsUrl}/$leagueId');
    print('standings response ${response.body.toString()}');
    Map<String, dynamic> res = json.decode(response.body);

    if (res['api']['results'] < 1) return false;

    _standings.clear();
    for (var item in res['api']['standings'][0]) {
      _standings.add(Standings.fromJson(item));
    }
    print('standings: ${_standings[0].teamName}');
    return true;
  }
}
