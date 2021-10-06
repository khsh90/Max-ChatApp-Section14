import 'package:flutter/services.dart';
import 'dart:io';
import '../widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  void submitAuthForm(String email, String userName, File imageFile,
      String password, bool isLogin, BuildContext ctx) async {
    AuthResult _authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //upload  the image to firebase .
        final imagePath = FirebaseStorage.instance
            .ref() //ref refere to buckt as storage of firebase has a pucket
            .child('user_images')
            .child(_authResult.user.uid + '.jpg');

        await imagePath
            .putFile(imageFile)
            .onComplete; //on complete used here because image path storage refreance

        await Firestore.instance
            .collection('users')
            .document(_authResult.user.uid)
            .setData({'userName': userName, 'email': email});
      }
      //used to get a specific error especially from fire base like user name and password error , not general error like catch
    } on PlatformException catch (error) {
      setState(() {
        _isLoading = false;
      });
      String msg = 'An error ocuard ,please check credential';

      if (error.message != null) {
        msg = error.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitAuthForm, _isLoading),
    );
  }
}
