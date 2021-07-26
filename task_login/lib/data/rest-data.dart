import 'dart:async';
import 'package:task_login/models/user.dart';
import 'package:task_login/data/database-helper.dart';

class RestData {
  static final baseURL = "";
  static final loginURL = baseURL + "/";

  Future<User> login(String username, String password) async {
    String flagLogged = "logged";
    var user = new User(null, username, password, null);
    var db = new DatabaseHelper();
    var userRetorno = new User(null, null, null, null);
    userRetorno = await db.selectUser(user);
    if (userRetorno != null) {
      flagLogged = "logged";
      return new Future.value(new User(null, username, password, flagLogged));
    } else {
      flagLogged = "not";
      return new Future.value(new User(null, username, password, flagLogged));
    }
  }
}
