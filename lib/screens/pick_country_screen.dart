import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:kick_start/models/country.dart';
import 'package:kick_start/providers/auth_provider.dart';
import 'package:kick_start/providers/countries_provider.dart';
import 'package:kick_start/providers/leagues_provider.dart';
import 'package:kick_start/screens/home_screen.dart';
import '../widgets/country_item.dart';
import 'package:provider/provider.dart';

class PickCountryScreen extends StatefulWidget {
  static final String routeName = '/';

  @override
  _PickCountryScreenState createState() => _PickCountryScreenState();
}

class _PickCountryScreenState extends State<PickCountryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  CountriesProvider _countriesProvider;
  LeaguesProvider _leaguesProvider;
  Future countriesFuture;
  bool param;
  bool shoyldLoad = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
   
   if(shoyldLoad){
      _countriesProvider = Provider.of<CountriesProvider>(context, listen: false);
    _leaguesProvider = Provider.of<LeaguesProvider>(context, listen: false);

    if (_countriesProvider.allCountries.length < 1) {
      countriesFuture = _countriesProvider.fetchAllCountries();
    } else {
      if (param == null)
        param = ModalRoute.of(context).settings.arguments as bool;
      if (param != null && param) countriesFuture = Future.value(true);
    }
   }
   shoyldLoad = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.orange[800].withOpacity(0.96),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: _leaguesProvider.leagues.length == 0
                      ? _showErrorSnackBar
                      : () {
                          _leaguesProvider.storeUserPrefs(
                              Provider.of<AuthProvider>(context).userId);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(HomePage.routeName, (Route<dynamic> route) => false);

                        })
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Countries'),
              background: Center(
                child: Image.asset(
                  'assets/pics/back.png',
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              FutureBuilder(
                future: countriesFuture,
                builder: (BuildContext context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : snapshot.hasData && snapshot.data
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _countriesProvider.allCountries
                                    .map((Country country) =>
                                        CountryItem(country))
                                    .toList(),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 35),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Can\'t get countries data, check your internet connection and try later',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    width: 300,
                                    height: 300,
                                    child: FlareActor(
                                        "assets/flare/no_internet.flr",
                                        alignment: Alignment.center,
                                        fit: BoxFit.contain,
                                        animation: "Untitled"),
                                  ),
                                ],
                              ),
                            );
                },
              ),
            ]),
          )
        ],
      ),
    );
  }

  void _showErrorSnackBar() {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.deepOrange,
        content: const Text(
          'You must select 1 or more league to continue',
          style: TextStyle(color: Colors.white),
        )));
  }
}
