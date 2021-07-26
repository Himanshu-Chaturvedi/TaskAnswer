import 'package:flutter/material.dart';
import 'package:task_login/models/user.dart';
import 'package:task_login/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _register() {
    Navigator.of(context).pushNamed("/register");
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        form.save();
        _presenter.doLogin(_email, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var loginBtn = new ElevatedButton(
      onPressed: _submit,
      child: new Text("Login"),
    );
    var registerBtn = new ElevatedButton(
      onPressed: _register,
      child: new Text("Register"),
    );
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          "Login",
          textScaleFactor: 2.0,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  onSaved: (val) => _email = val.trim(),
                  decoration: new InputDecoration(labelText: "Email"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
              )
            ],
          ),
        ),
        new Padding(padding: const EdgeInsets.all(10.0), child: loginBtn),
        registerBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Page"),
      ),
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
          child: new Container(
            child: new Center(
              child: loginForm,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar("Login not successful");
    setState(() {});
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    if (user.username == "") {
      _showSnackBar("Login not successful");
    } else {
      _showSnackBar(" Successfully login with ${user.username.toString()}");
    }
    setState(() {});
    if (user.flaglogged == "logged") {
      print("Logged");
      Navigator.of(context).pushReplacementNamed("/home");
    } else {
      print("Not Logged");
    }
  }
}
