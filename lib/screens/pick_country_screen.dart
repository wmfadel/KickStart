import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:kick_start/models/country.dart';
import 'package:kick_start/providers/countries_provider.dart';
import 'package:kick_start/screens/home_screen.dart';
import '../widgets/country_item.dart';
import 'package:provider/provider.dart';

class PickCountryScreen extends StatelessWidget {
  static final String routeName = '/';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.deepOrange,
            actions: <Widget>[
              Consumer<CountriesProvider>(
                  builder: (ctx, provider, ch) => IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: provider.selectedCountries.length == 0
                          ? _showErrorSnackBar
                          : () {
                              Navigator.of(context)
                                  .pushReplacementNamed(HomePage.routeName);
                            }))
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
                future: Provider.of<CountriesProvider>(context, listen: false)
                    .fetchAllCountries(),
                builder: (BuildContext context, snapshot) {
                  print('FutureBuilder body called');
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : snapshot.hasData && snapshot.data
                          ? Consumer(
                              builder: (BuildContext context,
                                  CountriesProvider provider, Widget child) {

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: provider.allCountries
                                        .map((Country country) =>
                                            CountryItem(country))
                                        .toList(),
                                  ),
                                );
                              },
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
          'You must select 1 or more countries',
          style: TextStyle(color: Colors.white),
        )));
  }
}
