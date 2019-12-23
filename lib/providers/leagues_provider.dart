import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../environment.dart';
import '../models/league.dart';
import '../models/country.dart';

class LeaguesProvider with ChangeNotifier {
  List<League> _leagues = [];

  List<League> get leagues => [..._leagues];


  Future<List<League>> fetchLeaguesByCountry(Country country, int season) async {
    // check if we have the current season
    // if (_season == null) await _fetchCurrentSeason();

    http.Response response = await http.get(
        Environment.leaguesUrl + '${country.code??country.country}/$season',
        headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    List<League> _fetchedLeagues = [];
    for (int i = 0; i < res['api']['leagues'].length; i++) {
      _fetchedLeagues.add(League.fromJson(res['api']['leagues'][i]));
    }
    return _fetchedLeagues;
  }


    

  addLeagueToFavorite(League league) {
    _leagues.add(league);
    notifyListeners();
  }

  removeLeagueFromFavorite(League league) {
    _leagues.removeWhere((League l) => l.leagueId == league.leagueId);
    notifyListeners();
  }

  isFavoriteLeague(int leagueId) {
    bool isFavorite = false;
    _leagues.forEach((League league) {
      if (leagueId == league.leagueId) isFavorite = true;
    });
    return isFavorite;
  }

  isLeagueFromCountry(String countryCode) {
    bool isFavorite = false;
    _leagues.forEach((League league) {
      if (league.countryCode == countryCode) isFavorite = true;
    });
    return isFavorite;
  }

  League getLeagueById(int leagueId) {
    return _leagues.firstWhere((League league) => league.leagueId == leagueId);
  }

  storeUserPrefs(String userId) async {
    if (userId == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('user');
    }
    if(userId == null) return;
    var reference = Firestore.instance.collection(userId);
    final QuerySnapshot result = await reference.getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    documents.forEach((DocumentSnapshot doc){
      reference.document(doc.documentID).delete();
    });
    _leagues.forEach((League league) {
      reference.add(league.toJson());
    });
  }

  Future<bool> fetchUserPrefs(String userId) async {
    if (userId == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('user');
    }
    var reference = Firestore.instance.collection(userId);
    final QuerySnapshot result = await reference.getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    _leagues.clear();
    documents.forEach(
        (DocumentSnapshot doc) => _leagues.add(League.fromJson(doc.data)));
    return true;
  }

  flushLeagues(){
    _leagues.clear();
  }
}
