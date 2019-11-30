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
  Timer _fixturesTimer;
  bool stop = false;

  Stream get fixturesStream => _fixturesSubject.stream;

  getPeriodicStream(int leagueID) async {
    var res = await fetchFixturesByLeague(leagueID);
    if (!res) _fixturesSubject.sink.addError('NoData, Fuck');
    if(!stop){
      _fixturesTimer = Timer.periodic(Duration(seconds: 5), (_) async {
        print('calling stream time');
        var res = await fetchFixturesByLeague(leagueID);
        if (!res) _fixturesSubject.sink.addError('NoData, Fuck');
      });
    }
  }

  fetchFixturesByLeague(int leagueId) async {
    final date = DateTime.now();
    final url =
        '${Environment.fixtureByLeagueUrl}/$leagueId/${date.year}-${date.month}-${date.day}';
    http.Response response =
        await http.get(url, headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) return false;
    List<Fixture> _fixtures = [];
    for (var item in res['api']['fixtures']) {
      _fixtures.add(Fixture.fromJson(item));
    }
    if(!_fixturesSubject.isClosed)
    _fixturesSubject.add(_fixtures);
    return true;
  }

  bool isStreamOpen() {
    return !_fixturesSubject.isClosed;
  }

  stopFetchingFixtures() {
    stop = true;
    _fixturesSubject.close();
    if(_fixturesTimer != null)
    _fixturesTimer.cancel();
    _fixturesTimer = null;
  }
}
