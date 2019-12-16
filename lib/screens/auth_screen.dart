import 'package:flutter/material.dart';
import 'package:kick_start/providers/auth_provider.dart';
import 'package:kick_start/screens/pick_country_screen.dart';
import 'package:kick_start/screens/wrapper.dart';
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
                  Navigator.of(context)
                      .pushReplacementNamed(PickCountryScreen.routeName);
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
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    _scaffoldKey.currentState.showBottomSheet(
      (BuildContext mContext) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                autofocus: true,
                maxLines: 1,
                expands: false,

                minLines: 1,
                decoration: InputDecoration(
                    labelText: 'Email', hintText: 'email@email.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: passwordController,
                autofocus: true,
                maxLines: 1,
                expands: false,

                minLines: 1,
                decoration: InputDecoration(
                    labelText: 'Password', hintText: 'password'),
              ),
            ),
            SizedBox(height: 30),
            FlatButton(
                    onPressed: () async {
                      bool result = await _authProvider.registerWithEmailAndPassword(
                        emailController.text,
                        passwordController.text
                      );
                      if(result){
                        Navigator.of(context).pushReplacementNamed(PickCountryScreen.routeName);
                      }
                    },
                    child: Text('Continue'),
                    textColor: Colors.deepOrange,
                  ),
            SizedBox(height: 20),
          ],
        );
      },
      elevation: 20,
      backgroundColor: Colors.white,
    );
  }


  showLoginSheet() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    _scaffoldKey.currentState.showBottomSheet(
          (BuildContext mContext) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Login',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                autofocus: true,
                maxLines: 1,
                expands: false,
                minLines: 1,
                decoration: InputDecoration(
                    labelText: 'Email', hintText: 'email@email.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: passwordController,
                autofocus: true,
                maxLines: 1,
                expands: false,
                minLines: 1,
                decoration: InputDecoration(
                    labelText: 'Password', hintText: 'password'),
              ),
            ),
            SizedBox(height: 30),
            FlatButton(
              onPressed: () async {
                bool result = await _authProvider.signInWithEmailAndPassword(
                    emailController.text,
                    passwordController.text
                );
                if(result){
                  Navigator.of(context).pushReplacementNamed(Wrapper.routeName);
                }
              },
              child: Text('Continue'),
              textColor: Colors.deepOrange,
            ),
            SizedBox(height: 20),
          ],
        );
      },
      elevation: 20,
      backgroundColor: Colors.white,
    );
  }
}
