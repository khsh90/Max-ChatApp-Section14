import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
  final void Function(
      String email, String userName, String password, bool isLogin) submitForm;
  AuthForm(this.submitForm);
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _email = '';
  var _userName = '';
  var _password = '';
  var _isLogin = true;

  void trySubmit() {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
      print(_email);
      print(_userName);
      print(_password);

      widget.submitForm(_email, _userName, _password, _isLogin);
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
                  RaisedButton(
                    onPressed: trySubmit,
                    child: Text(_isLogin ? "Login" : 'Create an acount'),
                  ),
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
