import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:kick_start/environment.dart';
import 'package:kick_start/models/team.dart';
import 'package:kick_start/models/team_statistics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class TeamProvider with ChangeNotifier {
  int teamID;
  int leagueID;

  BehaviorSubject<Team> teamSubject = BehaviorSubject<Team>();
  Stream<Team> get teamStream => teamSubject.stream;

  BehaviorSubject<TeamStatistics> _teamStatisticsSubject = BehaviorSubject();
  Stream<TeamStatistics> get statisticsStream => _teamStatisticsSubject.stream;

  TeamProvider() {
    teamStream.listen((value) {
      // TODO we have team start fetching all its data
      if (value != null) {
        fetchTeamSttistics();

      }
    });
  }

  removeCurrentValues(){
    teamSubject.add(null);
    _teamStatisticsSubject.add(null);
  }

  fetchTeam(int teamId, int leagueId) async {
    if (teamId == this.teamID) {
      return;
    } else {
     removeCurrentValues();
      
      this.teamID = teamId;
      this.leagueID = leagueId;
    }
    String url = Environment.teamUrl + '/$teamID';
    http.Response response =
        await http.get(url, headers: Environment.requestHeaders);

    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) {
      teamSubject.addError('Cannot find this team now 😿');
      return;
    }

    teamSubject.add(Team.fromJson(res['api']['teams'][0]));
  } // end of fetchTeam

  fetchTeamSttistics() async {
    DateTime now = DateTime.now();
    String date = '${now.day}-${now.month}-${now.year}';
    String url = Environment.statisticsUrl + '/$leagueID/$teamID/$date';

    http.Response response =
        await http.get(url, headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) {
      _teamStatisticsSubject.addError('Cannot fetch team statistics');
      return;
    }
    _teamStatisticsSubject
        .add(TeamStatistics.fromJson(res['api']['statistics']));
  }
} // end of class
