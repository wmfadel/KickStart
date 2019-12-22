import 'package:flutter/material.dart';
import 'package:kick_start/models/standings.dart';
import 'package:kick_start/providers/standings_provider.dart';
import 'package:kick_start/screens/team_details.dart';
import 'package:kick_start/widgets/flare_error_widget.dart';
import 'package:kick_start/widgets/forme_row.dart';
import 'package:provider/provider.dart';

class LeagueRankingScreen extends StatefulWidget {
  final Key key;
  final int leagueId;

  LeagueRankingScreen(this.key, this.leagueId) : super(key: key);

  @override
  _LeagueRankingScreenState createState() => _LeagueRankingScreenState();
}

class _LeagueRankingScreenState extends State<LeagueRankingScreen> {
  StandingsProvider _standingsProvider;
  Future<bool> standingsFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _standingsProvider = Provider.of<StandingsProvider>(context);
    standingsFuture =
        _standingsProvider.fetchStandingsForLeague(widget.leagueId);
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
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30),
                        buildLeaderBoard(context),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: buildDataTable(),
                        ),
                      ],
                    ),
                  )
                : FlareErrorWidget(snapshots.error);
      },
    );
  }

  Padding buildLeaderBoard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            TeamDetails.routeName,
            arguments: {'teamID':_standingsProvider.standings[0].teamId, 'leagueID':widget.leagueId},
          );
        },
        child: Material(
          elevation: 15,
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepOrangeAccent,
          clipBehavior: Clip.hardEdge,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              '#1',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 8, 8),
                            child: Text(
                              _standingsProvider.standings[0].teamName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 15),
                            child: Text(
                              '${_standingsProvider.standings[0].points} Points',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.2, end: 1),
                    duration: Duration(milliseconds: 1200),
                    builder: (BuildContext context, double size, Widget child) {
                      return Center(
                        child: Image.network(
                          _standingsProvider.standings[0].logo,
                          height: 200 * size,
                          width: MediaQuery.of(context).size.width * 0.8 ,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataTable buildDataTable() {
    return DataTable(
      columnSpacing: 20,
      columns: [
        DataColumn(label: Text('Pos'), tooltip: 'Team Position', numeric: true),
        DataColumn(label: Text('Club'), tooltip: 'Club 🐸'),
        DataColumn(label: Text('Pts'), tooltip: 'Points', numeric: true),
        DataColumn(
            label: Text('GD'), tooltip: 'Goals Difference', numeric: true),
        DataColumn(label: Text('P'), tooltip: 'matchs Played', numeric: true),
        DataColumn(
            label: Text(
              'GF',
              style: TextStyle(color: Colors.green),
            ),
            tooltip: 'Goals For',
            numeric: true),
        DataColumn(
            label: Text(
              'GA',
              style: TextStyle(color: Colors.redAccent),
            ),
            tooltip: 'Goals Againts',
            numeric: true),
        DataColumn(
          label: Text(
            'W',
            style: TextStyle(color: Colors.green),
          ),
          tooltip: 'Won',
          numeric: true,
        ),
        DataColumn(
          label: Text(
            'L',
            style: TextStyle(color: Colors.redAccent),
          ),
          tooltip: 'Lost',
          numeric: true,
        ),
        DataColumn(
            label: Text(
              'D',
              style: TextStyle(color: Colors.blueAccent),
            ),
            tooltip: 'Drawn',
            numeric: true),
        DataColumn(label: Text('Form'), tooltip: 'Form'),
      ],
      rows: _standingsProvider.standings.map((Standings standings) {
        return DataRow(cells: [
          DataCell(Text(
            '${standings.rank}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          )),
          DataCell(
            FittedBox(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(TeamDetails.routeName,
                      arguments: standings.teamId);
                },
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
              ),
            ),
          ),
          DataCell(Text('${standings.points}')),
          DataCell(Text('${standings.goalsDiff}')),
          DataCell(Text('${standings.all.matchsPlayed}')),
          DataCell(Text(
            '${standings.all.goalsFor}',
            style: TextStyle(color: Colors.green),
          )),
          DataCell(Text(
            '${standings.all.goalsAgainst}',
            style: TextStyle(color: Colors.redAccent),
          )),
          DataCell(Text(
            '${standings.all.win}',
            style: TextStyle(color: Colors.green),
          )),
          DataCell(Text(
            '${standings.all.lose}',
            style: TextStyle(color: Colors.redAccent),
          )),
          DataCell(Text(
            '${standings.all.draw}',
            style: TextStyle(color: Colors.blueAccent),
          )),
          DataCell(FormRow(standings.forme)),
        ]);
      }).toList(),
    );
  }
}
