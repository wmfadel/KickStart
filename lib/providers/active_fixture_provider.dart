import 'package:flutter/foundation.dart';
import 'package:kick_start/models/fixture.dart';
import 'package:rxdart/rxdart.dart';

class ActiveFixtureProvider with ChangeNotifier{

  BehaviorSubject<Fixture> _currentFixtureSubject = BehaviorSubject<Fixture>();


  Stream get currentFixtureStream => _currentFixtureSubject.stream;
  get currentFixtureAdd => _currentFixtureSubject.sink.add;



}