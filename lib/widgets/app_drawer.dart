import 'package:flutter/material.dart';
import 'package:kick_start/screens/pick_country_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Countries'),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(PickCountryScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
