import 'package:flutter/material.dart';
import 'package:kick_start/providers/leagues_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static final String routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LeaguesProvider>(
        builder: (ctx, provider, ch) => Column(
          children: <Widget>[
            ...provider.countries.map((c) => Text(c.country)).toList()
          ],
        ),
      ),
    );
  }
}
