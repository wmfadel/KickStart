import 'package:flutter/material.dart';
import 'package:kick_start/models/formation.dart';
import 'package:kick_start/providers/active_fixture_provider.dart';
import 'package:kick_start/widgets/formation_column.dart';
import 'package:provider/provider.dart';

class FixtureFormation extends StatefulWidget {
  @override
  _FixtureFormationState createState() => _FixtureFormationState();
}

class _FixtureFormationState extends State<FixtureFormation> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return StreamBuilder<Formation>(
      stream:
          Provider.of<ActiveFixtureProvider>(context).currentFormationStream,
      builder: (BuildContext context, AsyncSnapshot<Formation> snapshot) {
        if (snapshot.hasError) return Center(child: Text(snapshot.error));
        return snapshot.hasData &&
                snapshot.data.homeTeam != null &&
                snapshot.data.awayTeam != null
            ? buildFormationPage(snapshot.data)
            : CircularProgressIndicator();
      },
    );
  }

  Widget buildFormationPage(Formation formation) {
    return Container(
      width: size.width,
      height: size.height - 250,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(
                tabs: [
                  Tab(text: 'Home'),
                  Tab(text: 'Away'),
                ],
                indicatorColor: Colors.deepOrange,
                labelColor: Colors.deepOrange,
                unselectedLabelColor: Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  FormationColumn(formation.homeTeam),
                  FormationColumn(formation.awayTeam),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
