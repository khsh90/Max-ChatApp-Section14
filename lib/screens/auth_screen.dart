import 'package:flutter/services.dart';

import '../widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  void submitAuthForm(String email, String userName, String password,
      bool isLogin, BuildContext ctx) async {
    AuthResult _authResult;
    try {
      if (isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      //used to get a specific error especially from fire base like user name and password error , not general error like catch
    } on PlatformException catch (error) {
      String msg = 'An error ocuard ,please check credential';

      if (error.message != null) {
        msg = error.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitAuthForm),
    );
  }
}
