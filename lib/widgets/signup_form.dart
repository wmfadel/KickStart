import 'package:flutter/material.dart';
import 'package:kick_start/emuns/user_type.dart';
import 'package:kick_start/providers/auth_provider.dart';
import 'package:kick_start/screens/pick_country_screen.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


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
            bool result = await Provider.of<AuthProvider>(context, listen: false).registerWithEmailAndPassword(
                emailController.text,
                passwordController.text
            );
            if(result){
              Provider.of<AuthProvider>(context, listen: false).userType = UserType.Registered;
              Navigator.of(context).pushReplacementNamed(PickCountryScreen.routeName);
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
