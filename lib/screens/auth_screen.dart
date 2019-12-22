import 'package:flutter/material.dart';
import 'package:kick_start/emuns/user_type.dart';
import 'package:kick_start/providers/auth_provider.dart';
import 'package:kick_start/providers/leagues_provider.dart';
import 'package:kick_start/screens/pick_country_screen.dart';
import 'package:kick_start/widgets/login_form.dart';
import 'package:kick_start/widgets/signup_form.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static final String routeName = 'authScreen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  AuthProvider _authProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = Provider.of<AuthProvider>(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
//                  child: Image.asset(
//                    'assets/pics/logo.png',
//                    width: MediaQuery.of(context).size.width * 0.8,
//                    fit: BoxFit.cover,
//                  ),
                child: FlutterLogo(
                  size: 200,
                  colors: Colors.deepOrange,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  showLoginSheet();
                },
                child: Text('Login'),
                minWidth: 250,
                color: Colors.deepOrange,
                textColor: Colors.white,
              ),
              MaterialButton(
                onPressed: () {
                  showSignUPSheet();
                },
                child: Text('Sign Up'),
                minWidth: 250,
                color: Colors.deepOrange,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  _authProvider.userType = UserType.Anonymous;
                  Provider.of<LeaguesProvider>(context, listen: false).flushLeagues();
                  Navigator.of(context)
                      .pushNamed(PickCountryScreen.routeName, arguments: true);
                },
                child: Text('Continue without registering'),
                textColor: Colors.deepOrange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSignUPSheet() {
    _scaffoldKey.currentState.showBottomSheet(
      (BuildContext mContext) {
        return SignUpForm();
      },
      elevation: 20,
      backgroundColor: Colors.white,
    );
  }

  showLoginSheet() {
    _scaffoldKey.currentState.showBottomSheet(
      (BuildContext mContext) {
        return LoginForm();
      },
      elevation: 20,
      backgroundColor: Colors.white,
    );
  }
}
