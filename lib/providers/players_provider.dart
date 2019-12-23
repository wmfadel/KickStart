import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:kick_start/environment.dart';
import 'package:kick_start/models/scorer.dart';
import 'package:kick_start/models/standings.dart';

class PlayersProvider with ChangeNotifier{

  List<Scorer> _topScorers = [];
  int currentLeague = -1;
  List<Scorer> get topScorers => [..._topScorers];

  final Function(int) fetchStandings;
  final List<Standings> _standings;

  PlayersProvider(this._topScorers, this.fetchStandings, this._standings);

  Future<bool> fetchTopScorers(int leagueId) async{
    if(currentLeague == leagueId) return true;
    currentLeague = leagueId;
    if(_standings.length < 1)
    await fetchStandings(leagueId);
    final String url = '${Environment.topScorersUrl}/$leagueId';
    http.Response response = await http.get(url, headers: Environment.requestHeaders);


    Map<String, dynamic> res = json.decode(response.body);
    if(res['api']['results'] < 1) return false;
    _topScorers.clear();
    for(var scorer in res['api']['topscorers'])
      _topScorers.add(Scorer.fromJson(scorer));
    
    return true;

  }


  String getTamFlagById(int teamId) {
    String flag;
    flag = _standings.firstWhere((Standings s) => s.teamId == teamId).logo;
    return flag;
  }

}