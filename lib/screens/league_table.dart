import 'package:flutter/material.dart';
import 'package:kick_start/models/fixture.dart';
import 'package:kick_start/providers/fixtures_provider.dart';
import 'package:kick_start/widgets/fixture_item.dart';
import 'package:kick_start/widgets/flare_error_widget.dart';
import 'package:provider/provider.dart';

class LeagueTable extends StatefulWidget {
  final Key key;
  final int leagueId;
  LeagueTable(this.key, this.leagueId) : super(key: key);

  @override
  _LeagueTableState createState() => _LeagueTableState();
}

class _LeagueTableState extends State<LeagueTable> {
  FixturesProvider _fixturesProvider;
  ScrollController _scrollController;
  DateTime date;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fixturesProvider = Provider.of<FixturesProvider>(context, listen: false);
    _fixturesProvider.fetchLeagueFixturesByLeague(widget.leagueId);  

   _fixturesProvider.leagueFixturesStream.listen((value){
     _scrollController = ScrollController(initialScrollOffset: _fixturesProvider.getNextDayOffset());
   });
  }




  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Fixture>>(
      stream: _fixturesProvider.leagueFixturesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Fixture>> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: FlareErrorWidget(snapshot.error),
          );
        if (snapshot.hasData && snapshot.data[0].leagueId==widget.leagueId) {
         date = DateTime.parse(snapshot.data[0].eventDate);
          return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, index) {
              return Column(
                children: <Widget>[
                 buildDate(snapshot.data[index].eventDate, index),
                  FixtureItem(snapshot.data[index]),
                ],
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildDate(String newDate, int index){
    if(index == 0)
      return dateRow();
    if(DateTime.parse(newDate).difference(date).inDays != 0){
      date = DateTime.parse(newDate);
      return dateRow();
    }
    return Container();
  }

  Widget dateRow(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 50, 8, 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Divider(),
          Text('${date.day} - ${date.month} -${date.year}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

        ],
      ),
    );
  }
}
