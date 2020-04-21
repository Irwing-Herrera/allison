import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flu_movies/src/Provider/auth_api.dart';
import 'package:flu_movies/src/widget/circle.dart';
import 'package:flu_movies/src/widget/input_text.dart';

import '../utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _authApiService = AuthApiService();

  String _email = '', _password = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async {
    if (_isLoading) {
      return;
    }
    // el ! significa diferente
    if (!_formkey.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final isOk = await _authApiService.login(context,
        email: _email, password: _password);

    setState(() {
      _isLoading = false;
    });

    if (isOk) {
      Navigator.pushReplacementNamed(context, 'Home');
      _authApiService.openDialogSuccess(context, 'Genial, ya podras disfrutar de todo el contenido de Flu Movies.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              _circuloTopRigth(),
              Positioned(
                  left: -size.width * 0.15,
                  top: -size.width * 0.34,
                  child: Circle(
                      radius: size.width * 0.35,
                      colors: [Colors.orange, Colors.deepOrange])),
              SingleChildScrollView(
                  child: Container(
                width: size.width,
                height: size.height,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width: 90,
                            height: 90,
                            margin: EdgeInsets.only(top: size.width * 0.3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                //Sombreado
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 25)
                                ]),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Hola de nuevo.\n Bienvenido",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 350, minWidth: 350),
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  children: <Widget>[
                                    InputText(
                                        label: "Correo Electronico ",
                                        inputType: TextInputType.emailAddress,
                                        validator: (String text) {
                                          if (RegExp(patternEmail)
                                              .hasMatch(text)) {
                                            _email = text;
                                            return null;
                                          }
                                          return "Ingresa un Correo Valido";
                                        }),
                                    InputText(
                                      label: "Contraseña",
                                      isSecure: true,
                                      validator: (String text) {
                                        if (text.isNotEmpty &&
                                            text.length > 5) {
                                          if (text.length < 10) {
                                            _password = text;
                                            return null;
                                          }
                                        }
                                        return "Constraseña incorrecta, debe ser mayor a 5 caracteres y menos de 10";
                                      },
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(height: 20),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: 350, minWidth: 350),
                            child: CupertinoButton(
                              padding: EdgeInsets.symmetric(vertical: 17),
                              color: Colors.pinkAccent,
                              borderRadius: BorderRadius.circular(4),
                              onPressed: () {
                                _submit();
                                // Navigator.pushNamed(context, "Home");
                              },
                              child: Text("Ingrese ",
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Eres Nuevo ? ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54)),
                              CupertinoButton(
                                child: Text("Registrate",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.pinkAccent)),
                                onPressed: () =>
                                    Navigator.pushNamed(context, "singup"),
                              )
                            ],
                          ),
                          //  SizedBox(height: size.height*0.08,)
                        ],
                      )
                    ],
                  ),
                ),
              )),
              _isLoading ? _loading() : Container()
            ],
          )),
    ));
  }

  _circuloTopRigth() {
    final size = MediaQuery.of(context).size;

    return Positioned(
        right: -size.width * 0.22,
        top: -size.width * 0.36,
        child: Circle(
            radius: size.width * 0.45,
            colors: [Colors.pink, Colors.pinkAccent]));
  }

  Widget _loading() {
    return Positioned.fill(
        child: Container(
      color: Colors.black45,
      child: Center(child: CupertinoActivityIndicator(radius: 15.0)),
    ));
  }
}
