import 'package:flutter/material.dart';
import 'package:kick_start/models/team.dart';
import 'package:kick_start/models/team_statistics.dart';
import 'package:kick_start/providers/team_provider.dart';
import 'package:kick_start/widgets/flare_error_widget.dart';
import 'package:provider/provider.dart';

class TeamStats extends StatelessWidget {
  final Key key;
  TeamStats(this.key) : super(key: key);

  TeamProvider _teamProvider;
  Size size;

  @override
  Widget build(BuildContext context) {
    _teamProvider = Provider.of<TeamProvider>(context);
    size = MediaQuery.of(context).size;
    return StreamBuilder<TeamStatistics>(
      stream: _teamProvider.statisticsStream,
      builder: (BuildContext context, AsyncSnapshot<TeamStatistics> snapshot) {
        if (snapshot.hasError) return FlareErrorWidget(snapshot.error);
        if (snapshot.hasData && snapshot.data != null) {
          return buildTeamStatistics(
              _teamProvider.teamSubject.value, snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildTeamStatistics(Team team, TeamStatistics statistics) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(width: size.width),

            // Logo and name row
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    team.logo,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text(team.name,
                      overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      Text('${team.country ?? ''}, ${team.founded ?? ''}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          )),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Divider(),
            SizedBox(height: 8),
            Text(
              'Venue',
              style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '${team.venueName}, ${team.venueCity}, ${team.venueAddress},',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(height: 4),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Type: ${team.venueSurface ?? 'unknown'}.',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Capacity: ${team.venueCapacity ?? 'unknown'}.',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Divider(),
            SizedBox(height: 30),
            Text('Statistics.',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: buildStatisticsDataTable(statistics),
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  DataTable buildStatisticsDataTable(TeamStatistics statistics) {
    return DataTable(columnSpacing: 20, columns: [
      DataColumn(label: Text('Entry')),
      DataColumn(label: Text('Home')),
      DataColumn(label: Text('Away')),
      DataColumn(label: Text('Total')),
    ], rows: [
      DataRow(cells: [
        DataCell(Text('Matchs Played',
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
        DataCell(Text('${statistics.matchs.matchsPlayed.home ?? 0}',
            style: TextStyle(color: Colors.black))),
        DataCell(Text('${statistics.matchs.matchsPlayed.away ?? 0}',
            style: TextStyle(color: Colors.black))),
        DataCell(Text('${statistics.matchs.matchsPlayed.total ?? 0}',
            style: TextStyle(color: Colors.black))),
      ]),
      DataRow(cells: [
        DataCell(Text('Wins',
            style:
                TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
        DataCell(Text('${statistics.matchs.wins.home ?? 0}',
            style: TextStyle(color: Colors.green))),
        DataCell(Text('${statistics.matchs.wins.away ?? 0}',
            style: TextStyle(color: Colors.green))),
        DataCell(Text('${statistics.matchs.wins.total ?? 0}',
            style: TextStyle(color: Colors.green))),
      ]),
      DataRow(cells: [
        DataCell(Text('Draws',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))),
        DataCell(Text('${statistics.matchs.draws.home ?? 0}',
            style: TextStyle(color: Colors.blue))),
        DataCell(Text('${statistics.matchs.draws.away ?? 0}',
            style: TextStyle(color: Colors.blue))),
        DataCell(Text('${statistics.matchs.draws.total ?? 0}',
            style: TextStyle(color: Colors.blue))),
      ]),
      DataRow(cells: [
        DataCell(Text('Loses',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
        DataCell(Text('${statistics.matchs.loses.home ?? 0}',
            style: TextStyle(color: Colors.red))),
        DataCell(Text('${statistics.matchs.loses.away ?? 0}',
            style: TextStyle(color: Colors.red))),
        DataCell(Text('${statistics.matchs.loses.total ?? 0}',
            style: TextStyle(color: Colors.red))),
      ]),
      DataRow(cells: [
        DataCell(Text('Goals For',
            style:
                TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
        DataCell(Text('${statistics.goals.goalsFor.home ?? 0}',
            style: TextStyle(color: Colors.green))),
        DataCell(Text('${statistics.goals.goalsFor.away ?? 0}',
            style: TextStyle(color: Colors.green))),
        DataCell(Text('${statistics.goals.goalsFor.total ?? 0}',
            style: TextStyle(color: Colors.green))),
      ]),
      DataRow(cells: [
        DataCell(Text('Goals Against',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
        DataCell(Text('${statistics.goals.goalsAgainst.home ?? 0}',
            style: TextStyle(color: Colors.red))),
        DataCell(Text('${statistics.goals.goalsAgainst.away ?? 0}',
            style: TextStyle(color: Colors.red))),
        DataCell(Text('${statistics.goals.goalsAgainst.total ?? 0}',
            style: TextStyle(color: Colors.red))),
      ]),
      DataRow(cells: [
        DataCell(Text('Goals Avg For',
            style:
                TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
        DataCell(Text('${statistics.goalsAvg.goalsFor.home ?? 0}',
            style: TextStyle(color: Colors.green))),
        DataCell(Text('${statistics.goalsAvg.goalsFor.away ?? 0}',
            style: TextStyle(color: Colors.green))),
        DataCell(Text('${statistics.goalsAvg.goalsFor.total ?? 0}',
            style: TextStyle(color: Colors.green))),
      ]),
      DataRow(cells: [
        DataCell(Text('Goals Avg Against',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
        DataCell(Text('${statistics.goalsAvg.goalsAgainst.home ?? 0}',
            style: TextStyle(color: Colors.red))),
        DataCell(Text('${statistics.goalsAvg.goalsAgainst.away ?? 0}',
            style: TextStyle(color: Colors.red))),
        DataCell(Text('${statistics.goalsAvg.goalsAgainst.total ?? 0}',
            style: TextStyle(color: Colors.red))),
      ]),
    ]);
  }
}
