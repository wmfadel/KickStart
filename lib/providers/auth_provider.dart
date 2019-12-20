import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:kick_start/emuns/account_status.dart';
import 'package:kick_start/emuns/user_type.dart';
import 'package:kick_start/models/custom_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AccountStatus accountStatus;
  UserType userType;
  bool isLoading = false;
  String userId;

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    accountStatus = AccountStatus.Login;
    try {
      isLoading = true;
      notifyListeners();
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', user.uid);
      userId = user.uid;
      isLoading = false;
      notifyListeners();
      return true;
    } on PlatformException catch (error) {
      print(error.toString());
      isLoading = false;
      notifyListeners();
      String message = error.code;
      if(error.code == 'ERROR_USER_NOT_FOUND'){
        message = 'User Not Found';
      }else if(error.code == 'ERROR_WRONG_PASSWORD'){
        message = 'Wrong Password';
      }else if(error.code == 'ERROR_INVALID_EMAIL'){
        message = 'Invalid Email';
      }
      return CustomError(message, error.message);
    }
  }

  Future<dynamic> registerWithEmailAndPassword(
      String email, String password) async {
    accountStatus = AccountStatus.SignUp;
    try {
      isLoading = true;
      notifyListeners();
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', user.uid);
      userId = user.uid;
      isLoading = false;
      notifyListeners();
      return true;
    } on PlatformException catch (error) {
      print(error.toString());
      isLoading = false;
      notifyListeners();
      String message = error.code;

      if(error.code == 'ERROR_WEAK_PASSWORD'){
        message = 'Invalid Password, Weak!!';
      }else if(error.code == 'ERROR_INVALID_EMAIL'){
        message = 'Invalid Email';
      }

      return CustomError(message, error.message);
    }
  }

  Future signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', null);
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
