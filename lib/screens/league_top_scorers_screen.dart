import 'package:flutter/material.dart';
import 'package:kick_start/models/scorer.dart';
import 'package:kick_start/providers/players_provider.dart';
import 'package:kick_start/providers/standings_provider.dart';
import 'package:kick_start/screens/player_details.dart';
import 'package:kick_start/widgets/flare_error_widget.dart';
import 'package:provider/provider.dart';

class LeagueTopScorersScreen extends StatefulWidget {
  final Key key;
  final int leagueId;
  LeagueTopScorersScreen(this.key, this.leagueId) : super(key: key);

  @override
  _LeagueTopScorersScreenState createState() => _LeagueTopScorersScreenState();
}

class _LeagueTopScorersScreenState extends State<LeagueTopScorersScreen> {
  StandingsProvider _standingsProvider;
  PlayersProvider _playersProvider;

  Future<bool> topScorersFuture;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _standingsProvider = Provider.of<StandingsProvider>(context);
    _playersProvider = Provider.of<PlayersProvider>(context);

    topScorersFuture = _playersProvider.fetchTopScorers(widget.leagueId);

//    if (_standingsProvider.standings.length == 0 ||
//        _standingsProvider.currentTeam != _league.leagueId) {
//      await _standingsProvider.fetchStandingsForLeague(_league.leagueId);
//   //   topScorersFuture = _playersProvider.fetchTopScorers(_league.leagueId);
//    } else {
//   //   topScorersFuture = _playersProvider.fetchTopScorers(_league.leagueId);
//    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: topScorersFuture,
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
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0.2, end: 1),
                          duration: Duration(milliseconds: 1200),
                          builder: (BuildContext context, double size,
                              Widget child) {
                            return buildLeaderBoard(context, size: size);
                          },
                        ),
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

  Padding buildLeaderBoard(BuildContext context, {double size = 1}) {
    return Padding(
      padding: const EdgeInsets.all(10),
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
                            '${_playersProvider.topScorers[0].goals.total} Goals',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                          /*  Navigator.of(context).pushNamed(
                                PlayerDetails.routeName,
                                arguments:
                                    _playersProvider.topScorers[0].playerId);*/
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 8, 8),
                            child: Text(
                              _playersProvider.topScorers[0].playerName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 8, bottom: 8),
                          child: Text(
                            _playersProvider.topScorers[0].teamName,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 2,
                child: Center(
                  child: Image.network(
                    _standingsProvider
                        .getTamFlagById(_playersProvider.topScorers[0].teamId),
                    height: 150 * size,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataTable buildDataTable() {
    var rank = 0;
    return DataTable(
      columnSpacing: 20,
      columns: [
        DataColumn(label: Text('rank'), tooltip: 'Player Rank', numeric: true),
        DataColumn(label: Text('Name'), tooltip: 'Name'),
        DataColumn(label: Text('Team'), tooltip: 'Team'),
        DataColumn(label: Text('pos'), tooltip: 'Player Position'),
        DataColumn(label: Text('app'), tooltip: 'Player Apperance'),
        DataColumn(label: Text('mp'), tooltip: 'Minutes played'),
        DataColumn(label: Text('Goals'), tooltip: 'Player Goals'),
        DataColumn(label: Text('Assits'), tooltip: 'Player Assists'),
        DataColumn(label: Text('Shots'), tooltip: 'Shots'),
        DataColumn(label: Text('On'), tooltip: 'Shots on target'),
        DataColumn(label: Text('PW'), tooltip: 'Penality Won'),
        DataColumn(label: Text('PC'), tooltip: 'Penality commited'),
        DataColumn(label: Text('PM'), tooltip: 'Penality missed'),
        DataColumn(label: Text('PS'), tooltip: 'Penality saved'),
        DataColumn(label: Text('YC'), tooltip: 'Yellow Card'),
        DataColumn(label: Text('SYC'), tooltip: 'Second Yellow Card'),
        DataColumn(label: Text('RC'), tooltip: 'Red Card'),
        DataColumn(label: Text('Country'), tooltip: 'Country'),
      ],
      rows: _playersProvider.topScorers.map((Scorer scorer) {
        rank++;
        return DataRow(
          cells: [
            DataCell(Text(
              '$rank',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )),
            DataCell(Text('${scorer.playerName}'), onTap: () {
           /*   Navigator.of(context).pushNamed(PlayerDetails.routeName,
                  arguments: scorer.playerId);*/
            }),
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
                        image: NetworkImage(
                            _standingsProvider.getTamFlagById(scorer.teamId)),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(scorer.teamName),
                ],
              ),
            )),
            DataCell(Text('${scorer.position}')),
            DataCell(Text('${scorer.games.appearences ?? 0}')),
            DataCell(Text('${scorer.games.minutesPlayed ?? 0}')),
            DataCell(Text('${scorer.goals.total ?? 0}')),
            DataCell(Text('${scorer.goals.assists ?? 0}')),
            DataCell(Text('${scorer.shots.total ?? 0}')),
            DataCell(Text('${scorer.shots.on ?? 0}')),
            DataCell(Text('${scorer.penalty.won ?? 0}')),
            DataCell(Text('${scorer.penalty.commited ?? 0}')),
            DataCell(Text('${scorer.penalty.missed ?? 0}')),
            DataCell(Text('${scorer.penalty.saved ?? 0}')),
            DataCell(buildCard(scorer.cards.yellow ?? 0, Colors.yellow)),
            DataCell(buildCard(scorer.cards.secondYellow ?? 0, Colors.yellow)),
            DataCell(buildCard(scorer.cards.red ?? 0, Colors.red)),
            DataCell(Text(scorer.nationality)),
          ],
        );
      }).toList(),
    );
  }

  Widget buildCard(int value, Color color) {
    return Container(
      width: 40,
      height: 35,
      padding: EdgeInsets.all(4),
      child: Center(
          child: Text(
        '$value',
        style: TextStyle(color: Colors.white),
      )),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
    );
  }
}
