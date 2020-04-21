import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flu_movies/src/utils/session.dart';
// import 'package:login/src/utils/session.dart';
import 'package:flu_movies/src/widget/custom_dialog.dart';

class AuthApiService {
  final _session = Session();

  static const _apiKey = "AIzaSyCaiw3QBElkXP_nOactHzIF71Vr_Wybzx4";

  Future<bool> register(BuildContext context,
      {@required String email, @required String password}) async {
    try {
      final url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey";

      final autData = {
        'email': email,
        'password': password,
        'returnSecureToken': true
      };

      final response = await http.post(url, body: json.encode(autData));

      Map<String, dynamic> decodeResp = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = decodeResp['idToken'] as String;

        _session.token = token;
        _session.email = email;
        return true;

      } else if (response.statusCode == 400) {
        throw PlatformException(
            code: "400",
            message: decodeResp['error']['message']);
      }
      throw PlatformException(
          code: "500", message: "Error in method /register/");
    } on PlatformException catch (e) {
      _openDialogError(context, e.message);
      return false;
    }
  }

  Future<bool> login(BuildContext context,
      {@required String email, @required String password}) async {
    try {
      final url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey";

      final autData = {
        'email': email,
        'password': password,
        'returnSecureToken': true
      };

      final response = await http.post(url, body: json.encode(autData));

      Map<String, dynamic> decodeResp = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = decodeResp['idToken'] as String;

        _session.token = token;
        _session.email = email;
        return true;

      } else if (response.statusCode == 400) {
        throw PlatformException(
            code: "400",
            message: decodeResp['error']['message']);
      }
      throw PlatformException(code: "500", message: "Error in method /login/");
    } on PlatformException catch (e) {
      _openDialogError(context, e.message);
      return false;
    }
  }

  _openDialogError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogWidget(
        title: 'ERROR',
        description: message,
        buttonText: 'Cerrar',
        alertType: 'error',
      ),
    );
  }

  openDialogSuccess(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogWidget(
        title: 'Bienvenido',
        description: message,
        buttonText: 'Cerrar',
        alertType: 'success',
      ),
    );
  }
}
