import 'package:flutter/material.dart';
import 'package:kick_start/models/fixture.dart';

class FixtureInfo extends StatelessWidget {
  final Fixture fixture;

  FixtureInfo(this.fixture);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 10),
          dataRow('League', fixture.league.name, Icons.star),
          dataRow('Venue', fixture.venue??'Unknown', Icons.location_on),
          dataRow('Date', fixture.eventDate.substring(0,10), Icons.date_range),
          dataRow('Time',fixture.eventDate.substring(11,19) + ' GMT', Icons.av_timer),
          dataRow('Elapsed','${fixture.elapsed??0}' + ' M', Icons.timer),
          dataRow('Round', fixture.round, Icons.golf_course),
          dataRow('Refere', fixture.referee??'Unknown', Icons.record_voice_over),
          dataRow('Half Time', fixture.score.halftime??'Not Ready', Icons.score),
          dataRow('Full Time', fixture.score.fulltime??'Not Ready', Icons.score),
          dataRow('Extra Time', fixture.score.extratime??'Not Ready', Icons.score),
          dataRow('Penality', fixture.score.penalty??'Not Ready', Icons.score),
        ],
      ),
    );
  }

  Widget dataRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.deepOrangeAccent,
                ),
                Text(
                  label,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: Text(
                value,
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}

