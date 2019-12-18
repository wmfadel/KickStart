import 'package:flutter/material.dart';
import 'package:kick_start/models/custom_error.dart';

class Dialogs {
  showCustomError(BuildContext context, CustomError error) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text('Error, ${error.title}'),
            content: Text(error.details??''),
             titleTextStyle: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

}