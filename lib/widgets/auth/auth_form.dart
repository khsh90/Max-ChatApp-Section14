import '../imagepicker/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
  final void Function(String email, String userName, String password,
      bool isLogin, BuildContext ctx) submitForm;

  final bool isLoading;
  AuthForm(this.submitForm, this.isLoading);
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _email = '';
  var _userName = '';
  var _password = '';
  var _isLogin = true;
  bool _isLoading = false;
  File imageFile;

  void pickImageFile(File image) {
    imageFile = image;
  }

  void trySubmit() {
    if (imageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return; //in order not movewith submit form 
    }
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      print(_email);
      print(_userName);
      print(_password);

      widget.submitForm(
        _email.trim(),
        _userName.trim(),
        _password.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(pickImageFile),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid Email';
                      }
                    },
                    onSaved: (newValue) {
                      return _email = newValue;
                    },
                    key: ValueKey('Email'),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return "Please enter a valid username";
                        }
                      },
                      onSaved: (newValue) {
                        return _userName = newValue;
                      },
                      //used to let flutter now this value and not save the user when switch between log and login
                      key: ValueKey('Username'),
                    ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Please enter a valid password';
                      }
                    },
                    onSaved: (newValue) {
                      return _password = newValue;
                    },
                    key: ValueKey('Password'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      onPressed: trySubmit,
                      child: Text(_isLogin ? "Login" : 'Create an acount'),
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create an account'
                          : 'Already have an account'),
                      textColor: Theme.of(context).primaryColor,
                    )
                ],
              )),
        ),
      ),
    );
  }
}
