import 'package:flutter/material.dart';
import 'package:kick_start/emuns/user_type.dart';
import 'package:kick_start/models/custom_error.dart';
import 'package:kick_start/providers/auth_provider.dart';
import 'package:kick_start/screens/pick_country_screen.dart';
import 'package:kick_start/utils/dialogs.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  AuthProvider _authProvider;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Dialogs _dialogs = Dialogs();
  bool showPassword = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = Provider.of<AuthProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
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
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
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
            obscureText: !showPassword,
            minLines: 1,
            decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'password',
                suffix: IconButton(
                    icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    })),
          ),
        ),
        SizedBox(height: 30),
        FlatButton(
          onPressed: _authProvider.isLoading
              ? null
              : () async {
                  var result = await _authProvider.registerWithEmailAndPassword(
                      emailController.text, passwordController.text);
                  if (result is bool && result) {
                    _authProvider.userType = UserType.Registered;
                    Navigator.of(context)
                        .pushReplacementNamed(PickCountryScreen.routeName);
                  } else {
                    _dialogs.showCustomError(context, result as CustomError);
                  }
                },
          child: Text('Continue'),
          textColor: Colors.deepOrange,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
