import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kick_start/models/fixture.dart';
import 'package:kick_start/widgets/fixture_slice.dart';
class FixtureItem extends StatelessWidget {
  final Fixture fixture;

  FixtureItem(this.fixture);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: _size.width,
          height: 300,
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
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 40,
                  height: 150,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('2'),
                      Icon(Icons.more_vert),
                      Text('2'),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(100)),
                ),
              )
            ],
          ),
        ),
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )),
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ),
    );
  }
}
