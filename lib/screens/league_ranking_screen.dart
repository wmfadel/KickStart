import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:kick_start/models/league.dart';
import 'package:kick_start/models/standings.dart';
import 'package:kick_start/providers/leagues_provider.dart';
import 'package:kick_start/providers/standings_provider.dart';
import 'package:kick_start/widgets/forme_row.dart';
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
  Future<bool> standingsFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _leaguesProvider = Provider.of<LeaguesProvider>(context);
    _league = _leaguesProvider
        .getLeagueById(ModalRoute.of(context).settings.arguments as int);
    _standingsProvider = Provider.of<StandingsProvider>(context);
    standingsFuture =
        _standingsProvider.fetchStandingsForLeague(_league.leagueId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: standingsFuture,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshots) {
        return snapshots.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : snapshots.hasData
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 20,
                        columns: [
                          DataColumn(
                              label: Text('Pos'),
                              tooltip: 'Team Position',
                              numeric: true),
                          DataColumn(label: Text('Club'), tooltip: 'Club 🐸'),
                          DataColumn(
                              label: Text('Pts'),
                              tooltip: 'Points',
                              numeric: true),
                          DataColumn(
                              label: Text('GD'),
                              tooltip: 'Goals Difference',
                              numeric: true),
                          DataColumn(
                              label: Text('P'),
                              tooltip: 'matchs Played',
                              numeric: true),
                          DataColumn(
                              label: Text('GF',style: TextStyle(color: Colors.green),),
                              tooltip: 'Goals For',
                              numeric: true),
                          DataColumn(
                              label: Text('GA',style: TextStyle(color: Colors.redAccent),),
                              tooltip: 'Goals Againts',
                              numeric: true),
                          DataColumn(
                            label: Text('W',style: TextStyle(color: Colors.green),),
                            tooltip: 'Won',
                            numeric: true,
                          ),
                          DataColumn(
                            label: Text('L',style: TextStyle(color: Colors.redAccent),),
                            tooltip: 'Lost',
                            numeric: true,
                          ),
                          DataColumn(
                              label: Text('D',style: TextStyle(color: Colors.blueAccent),),
                              tooltip: 'Drawn',
                              numeric: true),
                          DataColumn(label: Text('Form'), tooltip: 'Form'),
                        ],
                        rows: _standingsProvider.standings
                            .map((Standings standings) {
                          return DataRow(cells: [
                            DataCell(Text('${standings.rank}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                            DataCell(FittedBox(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(standings.logo),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(standings.teamName),
                                ],
                              ),
                            )),
                            DataCell(Text('${standings.points}')),
                            DataCell(Text('${standings.goalsDiff}')),
                            DataCell(Text('${standings.all.matchsPlayed}')),
                            DataCell(Text('${standings.all.goalsFor}',style: TextStyle(color: Colors.green),)),
                            DataCell(Text('${standings.all.goalsAgainst}',style: TextStyle(color: Colors.redAccent),)),
                            DataCell(Text('${standings.all.win}',style: TextStyle(color: Colors.green),)),
                            DataCell(Text('${standings.all.lose}',style: TextStyle(color: Colors.redAccent),)),
                            DataCell(Text('${standings.all.draw}',style: TextStyle(color: Colors.blueAccent),)),
                            DataCell(FormRow(standings.forme)),
                          ]);
                        }).toList(),
                      ),
                    ),
                  )
                : Container(
                    width: 300,
                    height: 300,
                    child: FlareActor("assets/flare/no_internet.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: "Untitled"),
                  );
      },
    );
  }
}
