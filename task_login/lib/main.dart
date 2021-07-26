import 'package:flutter/material.dart';
import 'package:task_login/pages/home_page.dart';
import 'package:task_login/pages/login/login_page.dart';
import 'package:task_login/pages/login/register.dart';

void main() => runApp(MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/register': (BuildContext context) => new RegisterPage(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Locally',
      theme: new ThemeData(primarySwatch: Colors.deepOrange),
      routes: routes,
    );
  }
}
