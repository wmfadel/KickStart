import 'package:flutter/material.dart';
import 'package:kick_start/models/league.dart';
import 'package:kick_start/providers/leagues_provider.dart';
import 'package:provider/provider.dart';

class LeagueDetailsScreen extends StatefulWidget {
  static final String routeName = '/leaguedetailsscreen';

  @override
  _LeagueDetailsScreenState createState() => _LeagueDetailsScreenState();
}

class _LeagueDetailsScreenState extends State<LeagueDetailsScreen> {
  LeaguesProvider _leaguesProvider;
  League _league;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _leaguesProvider = Provider.of<LeaguesProvider>(context);
    _league = _leaguesProvider
        .getLeagueById(ModalRoute.of(context).settings.arguments as int);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_league.name),
      ),
    );
  }
}
