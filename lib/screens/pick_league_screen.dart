import 'package:flutter/material.dart';
import 'package:kick_start/models/country.dart';
import 'package:kick_start/models/league.dart';
import 'package:kick_start/widgets/league_item.dart';
import '../providers/countries_provider.dart';
import '../providers/leagues_provider.dart';
import 'package:provider/provider.dart';

class PickLeagueScreen extends StatefulWidget {
  static final String routeName = '/pickleagues';

  @override
  _PickLeagueScreenState createState() => _PickLeagueScreenState();
}

class _PickLeagueScreenState extends State<PickLeagueScreen> {
  CountriesProvider _countriesProvider;
  LeaguesProvider _leaguesProvider;
  String selectedCountryCode;
  Future<List<League>> leagueFuture;
  int currentSeason = DateTime.now().year;
  Country _selectedCountry;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _countriesProvider = Provider.of<CountriesProvider>(context, listen: false);
    _leaguesProvider = Provider.of<LeaguesProvider>(context, listen: false);
    selectedCountryCode = ModalRoute.of(context).settings.arguments as String;
    if (leagueFuture == null) {
      _selectedCountry =
          _countriesProvider.getCountryByCode(selectedCountryCode);
      leagueFuture = _leaguesProvider.fetchLeaguesByCountry(
          _selectedCountry, currentSeason);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _countriesProvider.getCountryByCode(selectedCountryCode).country),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: Material(
              color: Colors.white,
              elevation: 10,
              borderRadius: BorderRadius.circular(25),
              clipBehavior: Clip.hardEdge,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentSeason--;
                            leagueFuture =
                                _leaguesProvider.fetchLeaguesByCountry(
                                    _selectedCountry, currentSeason);
                          });
                        },
                        icon: Icon(
                          Icons.remove,
                        )),
                    Column(
                      children: <Widget>[
                        FittedBox(
                          child: Text(
                            'season',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            '$currentSeason',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentSeason++;
                            leagueFuture =
                                _leaguesProvider.fetchLeaguesByCountry(
                                    _selectedCountry, currentSeason);
                          });
                        },
                        icon: Icon(
                          Icons.add,
                        )),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            child: FutureBuilder(
              future: leagueFuture,
              builder:
                  (BuildContext context, AsyncSnapshot<List<League>> snapshot) {
                return snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData
                    ? snapshot.data.length < 1
                        ? Center(
                            child: Text('This Season is not available now.'),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) =>
                                LeagueItem(
                              snapshot.data[index],
                              isSelecting: true,
                            ),
                          )
                    : Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
