import 'package:flutter/material.dart';
import 'package:kick_start/models/fixture.dart';
import 'package:kick_start/providers/active_fixture_provider.dart';
import 'package:kick_start/screens/fixture_details.dart';
import 'package:kick_start/widgets/fixture_slice.dart';
import 'package:provider/provider.dart';

class FixtureItem extends StatelessWidget {
  final Fixture fixture;

  FixtureItem(this.fixture);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Provider.of<ActiveFixtureProvider>(context).currentFixtureAdd(fixture);
        Navigator.of(context)
            .pushNamed(FixtureDetails.routeName, arguments: fixture.fixtureId);
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          child: Container(
            width: _size.width,
            height: 230,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.black.withOpacity(0.8), Colors.black])),
            child: Stack(
              children: <Widget>[
                FixtureSlice(),
                buildHomeTeam(_size),
                buildAwayTeam(_size),
                showScore(fixture.statusShort)
                    ? buildScoreBoard(
                        fixture.goalsHomeTeam, fixture.goalsAwayTeam)
                    : buildStatusBar(_size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align buildStatusBar(Size _size) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: _size.width * 0.33,
        height: fixture.statusShort == 'NS' ? 50 : 40,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FittedBox(
                              child: Text(
                  fixture.status,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              if (fixture.statusShort == 'NS')
                FittedBox(
                                  child: Text(
                    '${fixture.eventDate.substring(11, 16)} GMT',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                )
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  bool requiresStatus(String status) {
    bool isRequired = false;
    if (status == 'ET' ||
        status == 'P' ||
        status == 'FT' ||
        status == 'AET' ||
        status == 'PEN') isRequired = true;
    return isRequired;
  }

  bool showScore(String status) {
    bool isOk = false;
    switch (status) {
      case '1H':
      case 'HT':
      case '2H':
      case 'ET':
      case 'P':
      case 'FT':
      case 'AET':
      case 'PEN':
      case 'BT':
      case 'SUSP':
        isOk = true;
        break;
    }
    return isOk;
  }

  Align buildScoreBoard(int homeScore, int awayScore) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 40,
        height: 150,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '$homeScore',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            requiresStatus(fixture.statusShort)
                ? Tooltip(
                    message: fixture.status,
                    child: Text(
                      fixture.statusShort,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))
                : Icon(Icons.more_vert),
            Text(
              '$awayScore',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  Align buildHomeTeam(Size _size) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FittedBox(
              child: Text(
                fixture.homeTeam.teamName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: fixture.homeTeam.teamName.length > 15 ? 16 : 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 15),
            Image.network(fixture.homeTeam.logo,
                width: _size.width * 0.25, fit: BoxFit.cover)
          ],
        ),
      ),
    );
  }

  Align buildAwayTeam(Size _size) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network(fixture.awayTeam.logo,
                width: _size.width * 0.25, fit: BoxFit.cover),
            SizedBox(height: 10),
            FittedBox(
                child: Text(
              fixture.awayTeam.teamName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: fixture.awayTeam.teamName.length > 13 ? 16 : 22,
                  fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ),
    );
  }
}
