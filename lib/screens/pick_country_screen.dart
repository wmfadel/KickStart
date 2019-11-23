import 'package:flutter/material.dart';
import 'package:kick_start/models/country.dart';
import 'package:kick_start/providers/countries_provider.dart';
import '../widgets/country_item.dart';
import 'package:provider/provider.dart';

class PickCountryScreen extends StatelessWidget {
  static final String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 8,
            expandedHeight: 220,
            title: Text('Countries',style: TextStyle(color: Colors.black),),
            actions: <Widget>[IconButton(icon: Icon(Icons.check,color: Colors.black,), onPressed: (){})],
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title:Text('Select all countries that you\'r intresetd in',style: TextStyle(color: Colors.blue),),

            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ...List<int>.generate(20, (index) => index)
                  .map((index) => Container(
                height: 40,
                margin: EdgeInsets.symmetric(vertical: 10),
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: Text('$index item'),
              ))
                  .toList(),
            ]),


          )
        ],
      ),
    );
  }
}


/*
 return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 220),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Text(
                  'Countries',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 60, 25),
                child: Text(
                  'Select all countries that you\'r intresetd in',
                  style: Theme.of(context).textTheme.body1,
                ),
              ),

              FutureBuilder(
                future:
                    Provider.of<CountriesProvider>(context,listen: false).fetchAllCountries(),
                builder: (BuildContext context, snapshot) {
                  print('FutureBuilder body called');
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : snapshot.hasData && snapshot.data?Consumer(
                          builder: (BuildContext context,
                              CountriesProvider provider, Widget child) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: provider.allCountries
                                    .map((Country country) =>
                                        CountryItem(country))
                                    .toList(),
                              ),
                            );
                          },
                        ):Center(child: Text('error gettig countries data'),);
                },
              ),
            ],
          ),
        ),
      ),
    );
 */