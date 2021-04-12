/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 8/4/21 5:22 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 8/4/21 5:22 PM by Kanmalai.
 * /
 */



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService{

  final FirebaseAuth _firebaseAuth;
  //final snackBar = SnackBar(content: Text('username or password is incorrect'));
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String>signIn({String email, String password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      return "Signed in";
    } on FirebaseAuthException catch(e){
      debugPrint("error ${e.message}");
      return e.message;
    }
  }

  Future<void>signOut() async{
    await _firebaseAuth.signOut();
  }
}

