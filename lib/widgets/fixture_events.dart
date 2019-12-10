import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kick_start/models/event.dart';
import 'package:kick_start/providers/active_fixture_provider.dart';
import 'package:provider/provider.dart';

class FixtureEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Event>>(
      stream: Provider.of<ActiveFixtureProvider>(context).currentEventsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        if (snapshot.hasError) return Center(child: Text(snapshot.error));
        return snapshot.hasData && snapshot.data.length >= 1
            ? buildEventsList(snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildEventsList(List<Event> events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('${events[index].elapsed}\''),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 8),
              child: Material(
                color: Colors.white,
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.all(15),
                  child: events[index].assistId == null &&
                          events[index].type != 'subst'
                      ?
                      // normal event
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            buildEventHead(events[index]),
                            SizedBox(width: 25),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        events[index].player,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(events[index].teamName),
                                    ],
                                  ),
                                )),
                            if (events[index].assist != null)
                              Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                      child: Text(events[index].assist))),
                          ],
                        )
                      // subst event
                      : Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Icon(Icons.arrow_drop_up,
                                    size: 50, color: Colors.green),
                                Icon(Icons.arrow_drop_down,
                                    size: 50, color: Colors.red)
                              ],
                            ),
                            SizedBox(width: 10),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(events[index].teamName),
                                Divider(),
                                Text(
                                  events[index].detail,
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  events[index].player,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ))
                          ],
                        ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget buildEventHead(Event event) {
    switch (event.type.toLowerCase()) {
      case 'card':
        return Container(
          width: 35,
          height: 50,
          child: Transform.rotate(
            angle: -math.pi / 12.0,
            child: Material(
              elevation: 15,
              borderRadius: BorderRadius.circular(10),
              color: event.detail == 'Yellow Card' ? Colors.yellow : Colors.red,
            ),
          ),
        );
      case 'normal goal':
      case 'goal':
        return Text(
          'Goal',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );

      case 'own goal':
        return Text(
         'Own Goal',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );

      case 'penalty':
        return Text(
          'Penality',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );

        case 'missed penalty':
        return Text(
          'Missed Penality',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );
    }
    return Container();
  }
}
