import 'package:flutter/material.dart';
import 'package:kick_start/emuns/account_status.dart';
import 'package:kick_start/providers/auth_provider.dart';
import 'package:kick_start/providers/leagues_provider.dart';
import 'package:kick_start/screens/auth_screen.dart';
import 'package:kick_start/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  static final String routeName = 'appWrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  AuthProvider _authProvider;
  LeaguesProvider _leaguesProvider;
  String _userId;
  String _message = 'Getting User Data';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = Provider.of<AuthProvider>(context);
    _leaguesProvider = Provider.of<LeaguesProvider>(context);
    checkLogged().then((bool result) {
      if (result) {
        if (_authProvider.accountStatus == null) {
          _leaguesProvider.fetchUserPrefs(_userId).then((bool value) {
            if (value)
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          });
        }
        switch (_authProvider.accountStatus) {
          case AccountStatus.Login:
            _leaguesProvider.fetchUserPrefs(_userId).then((bool value) {
              if (value)
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(HomePage.routeName, (Route<dynamic> route) => false);
            });
            break;
          case AccountStatus.SignUp:
            _leaguesProvider.fetchUserPrefs(_userId).then((bool value) {
              if (value)
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(HomePage.routeName, (Route<dynamic> route) => false);
            });
            break;
        }
      } else {
        // no user logged redirect to login screen
        Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text(_message)
          ],
        ),
      ),
    );
  }

  Future<bool> checkLogged() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool isUserLogged = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user');
    if (userId != null) {
      isUserLogged = true;
      _userId = userId;
    }
    return isUserLogged;
  }
}
