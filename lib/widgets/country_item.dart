import 'package:flutter/material.dart';
import 'package:kick_start/providers/leagues_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/countries_provider.dart';
import '../screens/pick_league_screen.dart';
import '../models/country.dart';

class CountryItem extends StatefulWidget {
  final Country _country;

  CountryItem(this._country);

  @override
  _CountryItemState createState() => _CountryItemState();
}

class _CountryItemState extends State<CountryItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CountriesProvider>(builder: (ctx, provider, ch) {
      return Column(
        children: <Widget>[
          InkWell(
            splashColor: Colors.blueAccent,
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Navigator.of(context).pushNamed(PickLeagueScreen.routeName,
                  arguments: widget._country.code);
            },
            child: Container(
              height: 60,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 60,
                        height: 60,
                        child: widget._country.flag == null
                            ? Placeholder()
                            : SvgPicture.network(
                                widget._country.flag,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                          placeholderBuilder: (_)=>Placeholder(),
                              ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(
                      widget._country.country == 'World'
                          ? 'Wolrd, World cup and stuff'
                          : widget._country.country,
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                  Consumer<LeaguesProvider>(builder: (BuildContext context,
                      LeaguesProvider lProvider, Widget child) {
                    return Container(
                      width: 20,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: lProvider
                                      .isLeagueFromCountry(widget._country.code)
                                  ? [
                                      Colors.blueAccent.withOpacity(0.7),
                                      Colors.blueAccent
                                    ]
                                  : [
                                      Colors.deepOrange.withOpacity(0.7),
                                      Colors.deepOrange
                                    ]),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                    );
                  }),
                ],
              ),
            ),
          ),
          Divider()
        ],
      );
    });
  }
}
