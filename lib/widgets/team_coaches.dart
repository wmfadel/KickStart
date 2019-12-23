import 'package:flutter/material.dart';
import 'package:kick_start/models/coach.dart';
import 'package:kick_start/models/trophie.dart';
import 'package:kick_start/providers/team_provider.dart';
import 'package:kick_start/widgets/flare_error_widget.dart';
import 'package:provider/provider.dart';

class TeamCoaches extends StatelessWidget {
  final Key key;
  TeamCoaches(this.key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Trophie>>(
      stream: Provider.of<TeamProvider>(context).trophieStream,
      builder: (BuildContext context, AsyncSnapshot<List<Trophie>> snapshot) {
        if (snapshot.hasError || (snapshot.hasData && snapshot.data.length < 1))
          return Center(child: FlareErrorWidget(snapshot.error));
        return snapshot.hasData
            ? buildCoachContent(
                Provider.of<TeamProvider>(context).coachsSubject.value[0],
                snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildCoachContent(Coach coach, List<Trophie> trophies) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 5),
            child: Text(
              coach.name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            '${coach.firstname ?? ''} ${coach.lastname ?? ''}',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SizedBox(height: 10),
          Divider(),
          SizedBox(height: 10),
          Text(
            '${coach.birthPlace ?? ''} ${coach.birthCountry ?? ''}',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              if (coach.birthDate != null)
                Expanded(
                  child: Text(
                    coach.birthDate,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              if (coach.age != null)
                Expanded(
                  child: Text(
                    '${coach.age} years',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Weight: ${coach.weight ?? 'unknown'}',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Expanded(
                child: Text(
                  'Height: ${coach.height ?? 'unknown'}',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Divider(),
          SizedBox(height: 8),
          Text('Carrer',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          ...coach.career
              .map((Career career) => ListTile(
                    title: Text(
                      career.team.name,
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                    subtitle: Text(
                      'from: ${career.start ?? 'unknown'}, to: ${career.end ?? 'present'}',
                    ),
                  ))
              .toList(),
          SizedBox(height: 30),
          Divider(),
          SizedBox(height: 8),
          Text('Trophies',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          ListView.builder(
            itemCount: trophies.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.white,
                elevation: 10,
                borderRadius: BorderRadius.circular(25),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        trophies[index].place,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Divider(),
                      SizedBox(height: 5),
                      Text(
                        trophies[index].league,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${trophies[index].country ?? ''} ${trophies[index].season}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50)
        ],
      ),
    );
  }
}
