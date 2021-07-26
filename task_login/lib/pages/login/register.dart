import 'package:flutter/material.dart';
import 'package:task_login/data/database-helper.dart';
import 'package:task_login/models/user.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name, _username, _password;

  @override
  Widget build(BuildContext context) {
    var loginBtn = new ElevatedButton(
      onPressed: _submit,
      child: new Text("Register"),
    );

    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          "Register",
          textScaleFactor: 2.0,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _name = val,
                  decoration: new InputDecoration(labelText: "Name"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val.trim(),
                  decoration: new InputDecoration(labelText: "Email"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val.trim(),
                  decoration: new InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        loginBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Register",
        ),
      ),
      key: scaffoldKey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: new Container(
          child: new Center(
            child: loginForm,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        form.save();
        var user = new User(_name, _username, _password, null);
        var db = new DatabaseHelper();
        db.saveUser(user);
        Navigator.of(context).pushNamed("/login");
        _showSnackBar("Registration Successful");
      });
    }
  }
}
