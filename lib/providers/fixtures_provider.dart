import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:kick_start/environment.dart';
import 'package:kick_start/models/fixture.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class FixturesProvider with ChangeNotifier {
  BehaviorSubject<List<Fixture>> _fixturesSubject =
      BehaviorSubject<List<Fixture>>();

  BehaviorSubject<List<Fixture>> _leagueFixturesSubject =
      BehaviorSubject<List<Fixture>>();

  Timer _fixturesTimer;
  bool stop = false;

  Stream get fixturesStream => _fixturesSubject.stream;

  Stream get leagueFixturesStream => _leagueFixturesSubject.stream;

  getPeriodicStream(int leagueID) async {
    var res = await fetchFixturesByLeague(leagueID);
    if (res == null || !res) {
      _fixturesSubject.sink.addError('No Matches for this day');
    }
    if (!stop) {
      _fixturesTimer = Timer.periodic(Duration(seconds: 50), (_) async {
        var res = await fetchFixturesByLeague(leagueID);
        if (!res) {
          _fixturesSubject.sink.addError('Can\'t get todays matches');
        }
      });
    }
  }

  Future<bool> fetchFixturesByLeague(int leagueId) async {
    final date = DateTime.now();
    final url =
        '${Environment.fixtureByLeagueUrl}/$leagueId/${date.year}-${date.month}-${date.day}?timezone=Africa/Cairo';
    http.Response response =
        await http.get(url, headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    if (res == null || res['api'] == null || res['api']['results'] < 1)
      return false;
    List<Fixture> _fixtures = [];
    for (var item in res['api']['fixtures']) {
      _fixtures.add(Fixture.fromJson(item));
    }
    if (!_fixturesSubject.isClosed) _fixturesSubject.add(_fixtures);
    return true;
  }

  stopFetchingFixtures() {
    stop = true;
    _fixturesSubject.close();
    if (_fixturesTimer != null) _fixturesTimer.cancel();
    _fixturesTimer = null;
  }

  fetchLeagueFixturesByLeague(int leagueId) async {
    final url =
        '${Environment.fixtureByLeagueUrl}/$leagueId?timezone=Africa/Cairo';
    http.Response response =
        await http.get(url, headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) {
      _leagueFixturesSubject.addError('Can\'t get the matches for this league');
      return;
    }
    List<Fixture> _fixtures = [];
    for (var item in res['api']['fixtures']) {
      _fixtures.add(Fixture.fromJson(item));
    }
    _leagueFixturesSubject.add(_fixtures);
  }

// item = 230
// date = 150

  double getNextDayOffset(){
    double position = 0;
      DateTime stopDate = DateTime.now().add(Duration(days: 2));
      if(_leagueFixturesSubject.hasValue){
        DateTime currentItemDate = DateTime.parse(_leagueFixturesSubject.value[0].eventDate);
          for(Fixture fixture in _leagueFixturesSubject.value){
            if(DateTime.parse(fixture.eventDate).isAfter(stopDate)){
               return position;
            }
            if(DateTime.parse(fixture.eventDate).difference(currentItemDate).inDays >= 1){
              currentItemDate = DateTime.parse(fixture.eventDate);
              position += 150;
            }
            position += 230;
          }
      }
    return position;
  }






}
