import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kick_start/models/fixture.dart';
import 'package:kick_start/providers/active_fixture_provider.dart';
import 'package:kick_start/screens/team_details.dart';
import 'package:kick_start/widgets/fixture_events.dart';
import 'package:kick_start/widgets/fixture_formation.dart';
import 'package:kick_start/widgets/fixture_info.dart';
import 'package:kick_start/widgets/fixture_statistics.dart';
import 'package:provider/provider.dart';

class FixtureDetails extends StatefulWidget {
  static final String routeName = 'fixtureDetails';

  @override
  _FixtureDetailsState createState() => _FixtureDetailsState();
}

class _FixtureDetailsState extends State<FixtureDetails> {
  ActiveFixtureProvider _activeFixtureProvider;
  Size size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _activeFixtureProvider = Provider.of<ActiveFixtureProvider>(context);
    _activeFixtureProvider.refreshActiveFixture();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<Fixture>(
        stream: _activeFixtureProvider.currentFixtureStream,
        builder: (BuildContext context, AsyncSnapshot<Fixture> snapShot) {
          if (snapShot.hasError) return Center(child: Text('Error'));
          return snapShot.hasData
              ? buildDataBody(snapShot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget buildDataBody(Fixture fixture) {
    return Column(
      children: <Widget>[
        SizedBox(height: 30),
        buildScoreContainer(fixture),
        buildTabs(fixture),
      ],
    );
  }

  Widget buildTabs(Fixture fixture) {
    return Container(
      width: size.width,
      height: size.height - 200,
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(
                tabs: [
                  Tab(text: "Events"),
                  Tab(text: "Formation"),
                  Tab(text: "Statistics"),
                  Tab(text: "Info"),
                ],
                indicatorColor: Colors.deepOrange,
                labelColor: Colors.deepOrange,
                unselectedLabelColor: Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  FixtureEvents(),
                  FixtureFormation(),
                  FixtureStatistics(),
                  FixtureInfo(fixture),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildScoreContainer(Fixture fixture) {
    return Container(
      width: size.width,
      height: 150,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(TeamDetails.routeName,
                    arguments: {'teamID':fixture.homeTeam.teamId, 'leagueID':fixture.leagueId});
              },
              child: buildTeamHeader(
                  fixture.homeTeam.logo, fixture.homeTeam.teamName),
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (fixture.league.logo != null)
                    Image.network(
                      fixture.league.logo,
                      width: size.width * 0.2,
                      height: 50,
                    ),
                  Text(
                    '${fixture.goalsHomeTeam} : ${fixture.goalsAwayTeam}',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  Tooltip(
                    message: fixture.status,
                    child: Text(
                      fixture.statusShort,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(TeamDetails.routeName,
                    arguments: {'teamID':fixture.awayTeam.teamId, 'leagueID':fixture.leagueId});
              },
              child: buildTeamHeader(
                  fixture.awayTeam.logo, fixture.awayTeam.teamName),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.deepOrangeAccent, Colors.deepOrange]),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(60),
            bottomRight: Radius.circular(60),
            bottomLeft: Radius.circular(8),
          )),
    );
  }

  Column buildTeamHeader(String logo, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.network(
          logo,
          width: size.width * 0.25,
          height:100,
          fit: BoxFit.fitHeight,
        ),
        FittedBox(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
