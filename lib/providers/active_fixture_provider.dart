import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kick_start/environment.dart';
import 'package:kick_start/models/fixture.dart';
import 'package:kick_start/models/statistics.dart';
import 'package:rxdart/rxdart.dart';

class ActiveFixtureProvider with ChangeNotifier {
  BehaviorSubject<Fixture> _currentFixtureSubject = BehaviorSubject<Fixture>();
  BehaviorSubject<Statistics> _currentFixtureStatistics =
      BehaviorSubject<Statistics>();

  Timer _dataTimer;
  DateTime _statisticsTime;

  Stream get currentFixtureStream => _currentFixtureSubject.stream;

  get currentFixtureAdd => _currentFixtureSubject.sink.add;

  Stream get currentStatisticsStream => _currentFixtureStatistics.stream;

  ActiveFixtureProvider() {
    _currentFixtureSubject.stream.listen((Fixture fixture) {
      // check if we will fetch statistics

      if (!_currentFixtureStatistics.hasValue ||
          _currentFixtureStatistics.value.id !=
              fixture.fixtureId ||
          _statisticsTime == null||
          DateTime.now().difference(_statisticsTime).inMinutes >= 5) {
        _fetchStatistics();
      }
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
}
