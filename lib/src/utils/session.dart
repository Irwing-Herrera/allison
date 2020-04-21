import 'package:shared_preferences/shared_preferences.dart';

class Session {
  
  static final Session _instancia = new Session._internal();

  factory Session() {
    return _instancia;
  }

  Session._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  get token {
    return _prefs.getString('token') ?? null;
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }

  // GET y SET del email
  get email {
    return _prefs.getString('email') ?? null;
  }

  set email( String value ) {
    _prefs.setString('email', value);
  }
  
}
