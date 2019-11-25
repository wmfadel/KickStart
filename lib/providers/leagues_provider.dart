import 'package:flutter/foundation.dart';
import '../models/league.dart';
import '../models/country.dart';

class LeaguesProvider with ChangeNotifier{
  List<League> _leagues;
  List<Country> _countries;


  List<League> get leagues => [..._leagues];
  List<Country> get countries => [..._countries];

  LeaguesProvider(this._countries, this._leagues);




}