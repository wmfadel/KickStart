import 'package:flutter/material.dart';
import 'package:kick_start/models/statistics.dart';
import 'package:kick_start/providers/active_fixture_provider.dart';
import 'package:provider/provider.dart';

class FixtureStatistics extends StatefulWidget {
  @override
  _FixtureStatisticsState createState() => _FixtureStatisticsState();
}

class _FixtureStatisticsState extends State<FixtureStatistics> {
  ActiveFixtureProvider activeFixtureProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    activeFixtureProvider =
        Provider.of<ActiveFixtureProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Statistics>(
      stream: activeFixtureProvider.currentStatisticsStream,
      builder: (BuildContext context, AsyncSnapshot<Statistics> snapshot) {
        if (snapshot.hasError) return Center(child: Text('not available'));
        return snapshot.hasData
            ? buildStatisticsBody(snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildStatisticsBody(Statistics statistics) {
    return ListView(
      children: <Widget>[
        statesticsRow('Ball Possession', statistics.ballPossession.home,
            statistics.ballPossession.away),
        statesticsRow('Shots on Goal', statistics.shotsOnGoal.home,
            statistics.shotsOnGoal.away),
        statesticsRow('Shots off Goal', statistics.shotsOffGoal.home,
            statistics.shotsOffGoal.away),
        statesticsRow('Total Shots', statistics.totalShots.home,
            statistics.totalShots.away),
        statesticsRow('Blocked Shots', statistics.blockedShots.home,
            statistics.blockedShots.away),

        statesticsRow('Shots insidebox', statistics.shotsInsidebox.home,
            statistics.shotsInsidebox.away),
        statesticsRow('Shots outsidebox', statistics.shotsOutsidebox.home,
            statistics.shotsOutsidebox.away),
        statesticsRow('Foulss', statistics.fouls.home,
            statistics.fouls.away),
        statesticsRow('Corner Kicks', statistics.cornerKicks.home,
            statistics.cornerKicks.away),
        statesticsRow('Offsides', statistics.offsides.home,
            statistics.offsides.away),
        statesticsRow('Yellow Cards', statistics.yellowCards.home,
            statistics.yellowCards.away),
        statesticsRow('Red Cards', statistics.redCards.home,
            statistics.redCards.away),
        statesticsRow('Goalkeeper Saves', statistics.goalkeeperSaves.home,
            statistics.goalkeeperSaves.away),
        statesticsRow('Total passes', statistics.totalPasses.home,
            statistics.totalPasses.away),
        statesticsRow('Passes accurate', statistics.passesAccurate.home,
            statistics.passesAccurate.away),
        SizedBox(height: 50)
      ],
    );
  }

  Widget statesticsRow(String label, String home, String away) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(flex: 1, child: Text(home?? '0')),
              Flexible(flex: 2, child: Text(label)),
              Flexible(flex: 1, child: Text(away??'0'))
            ],
      ),
    );
  }
}
