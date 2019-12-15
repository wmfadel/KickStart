import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kick_start/environment.dart';
import 'package:kick_start/models/event.dart';
import 'package:kick_start/models/fixture.dart';
import 'package:kick_start/models/formation.dart';
import 'package:kick_start/models/statistics.dart';
import 'package:rxdart/rxdart.dart';

class ActiveFixtureProvider with ChangeNotifier {
  BehaviorSubject<Fixture> _currentFixtureSubject = BehaviorSubject<Fixture>();
  BehaviorSubject<Statistics> _currentFixtureStatistics =
      BehaviorSubject<Statistics>();
  BehaviorSubject<Formation> _currentFixtureFormation =
      BehaviorSubject<Formation>();
  BehaviorSubject<List<Event>> _currentFixtureEvents =
      BehaviorSubject<List<Event>>();

  Timer _dataTimer;
  DateTime _statisticsTime;

  Stream get currentFixtureStream => _currentFixtureSubject.stream;

  get currentFixtureAdd => _currentFixtureSubject.sink.add;

  Stream get currentStatisticsStream => _currentFixtureStatistics.stream;

  Stream get currentFormationStream => _currentFixtureFormation.stream;

  Stream get currentEventsStream => _currentFixtureEvents.stream;

  ActiveFixtureProvider() {
    _currentFixtureSubject.stream.listen((Fixture fixture) {
      // check if we will fetch statistics
      if (!_currentFixtureStatistics.hasValue ||
          _currentFixtureStatistics.value.id != fixture.fixtureId ||
          _statisticsTime == null ||
          DateTime.now().difference(_statisticsTime).inMinutes >= 5) {
        _fetchStatistics();
      }

      // fetching formation
      if (!_currentFixtureFormation.hasValue ||
          _currentFixtureFormation.value.id != fixture.fixtureId)
        fetchFormation();

      // fetch events without any conditions
      fetchEvents();
    });
  }

  refreshActiveFixture() {
    if (_dataTimer == null || !_dataTimer.isActive)
      _dataTimer = Timer.periodic(Duration(seconds: 15), (_) async {
        var res =
            await _fetchFixtureByID(_currentFixtureSubject.value.fixtureId);
        if (!res) {
          _currentFixtureSubject.sink.addError('NoData');
        }
      });
  }

  Future<bool> _fetchFixtureByID(int fixtureId) async {
    final url = '${Environment.fixtureById}/$fixtureId?timezone=Africa/Cairo';
    http.Response response =
        await http.get(url, headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) return false;
    if (!_currentFixtureSubject.isClosed)
      _currentFixtureSubject.add(Fixture.fromJson(res['api']['fixtures'][0]));
    // print('getting this ${_currentFixtureSubject.value.homeTeam.teamName}');
    return true;
  }

  _fetchStatistics() async {
    final int id = _currentFixtureSubject.value.fixtureId;
    final String url = '${Environment.statisticsById}/$id';
//    final String url = '${Environment.statisticsById}/157163';
    http.Response response =
        await http.get(url, headers: Environment.requestHeaders);

    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) {
      _currentFixtureStatistics.addError('Statisrics are not available now');
      _statisticsTime = DateTime.now();
      return;
    }
    Statistics statistics = Statistics.fromJson(res['api']['statistics']);
    statistics.id = id;
    _currentFixtureStatistics.add(statistics);
    _statisticsTime = DateTime.now();
  }

  fetchFormation() async {
    final int id = _currentFixtureSubject.value.fixtureId;
    final String url = Environment.lineupsUrl + '/$id';
//    final String url = Environment.lineupsUrl + '/157163';
    final http.Response response =
        await http.get(url, headers: Environment.requestHeaders);

    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) {
      _currentFixtureFormation.addError('Not ready yet, or we just can\'t find it 🐸');
      return;
    }

    Formation _formation = Formation.fromJson(
        res['api']['lineUps'],
        _currentFixtureSubject.value.homeTeam.teamName,
        _currentFixtureSubject.value.awayTeam.teamName);
//    Formation _formation = Formation.fromJson(
//        res['api']['lineUps'],
//        'Crystal Palace',
//        'Bournemouth');
    _formation.id = id;
    _currentFixtureFormation.add(_formation);
  }

  fetchEvents() async {
    final int id = _currentFixtureSubject.value.fixtureId;
    //final int id = 157163;
    final String url = Environment.eventsUrl + '/$id';

    http.Response response =
        await http.get(url, headers: Environment.requestHeaders);

    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'] < 1) {
      _currentFixtureEvents.addError('No Events yet');
      return;
    }

    List<Event> _events = [];
    for (var item in res['api']['events']) {
      _events.add(Event.fromJson(item));
    }
    _currentFixtureEvents.add(_events.reversed.toList());
  }
}
