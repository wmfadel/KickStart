import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kick_start/environment.dart';
import 'package:kick_start/models/fixture.dart';
import 'package:rxdart/rxdart.dart';

class ActiveFixtureProvider with ChangeNotifier {
  BehaviorSubject<Fixture> _currentFixtureSubject = BehaviorSubject<Fixture>();
  Timer _dataTimer;

  Stream get currentFixtureStream => _currentFixtureSubject.stream;
  get currentFixtureAdd => _currentFixtureSubject.sink.add;

  refreshActiveFixture() {
    if(_dataTimer == null || !_dataTimer.isActive)

    _dataTimer = Timer.periodic(Duration(seconds: 15), (_) async {
      var res = await _fetchFixtureByID(_currentFixtureSubject.value.fixtureId);
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
}
