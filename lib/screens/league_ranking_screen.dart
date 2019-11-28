import 'package:flutter/material.dart';
import 'package:kick_start/models/league.dart';
import 'package:kick_start/providers/leagues_provider.dart';
import 'package:kick_start/providers/standings_provider.dart';
import 'package:provider/provider.dart';

class LeagueRankingScreen extends StatefulWidget {
  final Key key;

  LeagueRankingScreen(this.key) : super(key: key);

  @override
  _LeagueRankingScreenState createState() => _LeagueRankingScreenState();
}

class _LeagueRankingScreenState extends State<LeagueRankingScreen> {
  LeaguesProvider _leaguesProvider;
  StandingsProvider _standingsProvider;
  League _league;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _leaguesProvider = Provider.of<LeaguesProvider>(context);
    _league = _leaguesProvider
        .getLeagueById(ModalRoute.of(context).settings.arguments as int);
    _standingsProvider = Provider.of<StandingsProvider>(context);
  //  if(_standingsProvider.currentTeam != _league.leagueId)
    _standingsProvider.fetchStandingsForLeague(_league.leagueId);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('ranking'),
    );
  }
}
