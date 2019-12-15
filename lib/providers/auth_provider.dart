import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kick_start/emuns/account_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AccountStatus accountStatus;
  bool isLoading = false;
  String userId;

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
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
    } catch (error) {
      print(error.toString());
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerWithEmailAndPassword(
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
    } catch (error) {
      print(error.toString());
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

