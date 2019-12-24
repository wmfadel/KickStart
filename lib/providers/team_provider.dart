import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:kick_start/environment.dart';

import 'package:kick_start/models/coach.dart';
import 'package:kick_start/models/player.dart';
import 'package:kick_start/models/team.dart';

import 'package:kick_start/models/team_statistics.dart';
import 'package:kick_start/models/transfer.dart';
import 'package:kick_start/models/trophie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class TeamProvider with ChangeNotifier {
  int teamID;
  int leagueID;

  BehaviorSubject<Team> teamSubject = BehaviorSubject<Team>();
  Stream<Team> get teamStream => teamSubject.stream;

  BehaviorSubject<TeamStatistics> _teamStatisticsSubject = BehaviorSubject();
  Stream<TeamStatistics> get statisticsStream => _teamStatisticsSubject.stream;

  BehaviorSubject<List<Player>> _squadSubject = BehaviorSubject();
  Stream<List<Player>> get squadStream => _squadSubject.stream;

  BehaviorSubject<List<Transfer>> _transfersSubject = BehaviorSubject();
  Stream<List<Transfer>> get transfersStream => _transfersSubject.stream;

  BehaviorSubject<List<Coach>> coachsSubject = BehaviorSubject();
  Stream<List<Coach>> get coachsStream => coachsSubject.stream;

  BehaviorSubject<List<Trophie>> _trophieSubject = BehaviorSubject();
  Stream<List<Trophie>> get trophieStream => _trophieSubject.stream;

  TeamProvider() {
    teamStream.listen((value) {
      // we have team start fetching all its data
      if (value != null) {
        fetchTeamSttistics();
        fetchSquad();
        fetchTransfers();
        fetchCoachs();
      }
    });

    coachsStream.listen((List<Coach> coaches) {
      if (coaches != null && coaches.length > 0)
        fetchCoachTrophies(coaches[0].id);
    });
  }

  removeCurrentValues() {
    // delete the values from all the subjects by adding null
    // to prevent showing another team data when switching between teams
    teamSubject.add(null);
    _teamStatisticsSubject.add(null);
    _squadSubject.add(null);
    _transfersSubject.add(null);
    coachsSubject.add(null);
    _trophieSubject.add(null);
  }

  fetchTeam(int teamId, int leagueId) async {
    // donot fetch new value if we already have this teams data
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
      _teamStatisticsSubject.addError('Cannot fetch team statistics 😿');
      return;
    }
    _teamStatisticsSubject
        .add(TeamStatistics.fromJson(res['api']['statistics']));
  }

  fetchSquad() async {
    String url = Environment.squadUrl + '/$teamID/${DateTime.now().year}';

    http.Response response =
        await http.get(url, headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) {
      _squadSubject.addError('Cannot find squad for this season 😿');
      return;
    }
    List<Player> players = [];
    for (var player in res['api']['players']) {
      players.add(Player.fromJson(player));
    }
    _squadSubject.add(players);
  }

  fetchTransfers() async {
    String url = Environment.transfersUrl + '/$teamID';

    http.Response response =
        await http.get(url, headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) {
      _squadSubject.addError('No transfers for this team');
      return;
    }
    List<Transfer> transfers = [];
    for (var transfer in res['api']['transfers']) {
      transfers.add(Transfer.fromJson(transfer));
    }
    _transfersSubject.add(transfers);
  }

  fetchCoachs() async {
    String url = Environment.coachUrl + '/$teamID';

    http.Response response =
        await http.get(url, headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) {
      _squadSubject.addError('Cannot find Coachs for this team');
      return;
    }
    List<Coach> coachs = [];
    for (var coach in res['api']['coachs']) {
      coachs.add(Coach.fromJson(coach));
    }
    coachsSubject.add(coachs);
  }

  fetchCoachTrophies(int id) async {
    String url = Environment.coacTrophieshUrl + '/$id';

    http.Response response =
        await http.get(url, headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) {
      _squadSubject.addError('Cannot find Coach Trophies');
      return;
    }
    List<Trophie> trophies = [];
    for (var trophie in res['api']['trophies']) {
      trophies.add(Trophie.fromJson(trophie));
    }
    _trophieSubject.add(trophies);
  }
} // end of class
