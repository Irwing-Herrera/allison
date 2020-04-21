import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flu_movies/src/Provider/auth_api.dart';
import 'package:flu_movies/src/widget/circle.dart';

import 'package:flu_movies/src/widget/input_text.dart';

import '../utils/utils.dart';

class RegistrarsePage extends StatefulWidget {
  @override
  _RegistrarsePageState createState() => _RegistrarsePageState();
}

class _RegistrarsePageState extends State<RegistrarsePage> {
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

    final isOk = await _authApiService.register(context,
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
              Positioned(
                  right: -size.width * 0.22,
                  top: -size.width * 0.36,
                  child: Circle(
                      radius: size.width * 0.45,
                      colors: [Colors.purple, Colors.pinkAccent])),
              Positioned(
                  left: -size.width * 0.15,
                  top: -size.width * 0.34,
                  child: Circle(
                      radius: size.width * 0.35,
                      colors: [Colors.blue, Colors.purpleAccent])),
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
                          SizedBox(height: 10),
                          Text(
                            " Bienvenido a Flu-movie",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 300, minWidth: 300),
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  children: <Widget>[
                                    InputText(
                                        label: "Correo electrónico",
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
                                        return "Constraseña incorrecta";
                                      },
                                    ),
                                    SizedBox(height: 20)
                                  ],
                                ),
                              )),

                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: 350, minWidth: 350),
                            child: CupertinoButton(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              color: Colors.pinkAccent,
                              borderRadius: BorderRadius.circular(4),
                              onPressed: () => _submit(),
                              child: Text("Registrate ",
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("ya tienes cuenta ? ",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54)),
                              CupertinoButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, "/"),
                                child: Text("Inicia sesión",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.pinkAccent)),
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
              Positioned(
                  left: 15,
                  top: 5,
                  child: SafeArea(
                      child: CupertinoButton(
                    padding: EdgeInsets.all(10),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black12,
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ))),
              _isLoading ? _loading() : Container()
            ],
          )),
    ));
  }

  Widget _loading() {
    return Positioned.fill(
        child: Container(
      color: Colors.black45,
      child: Center(child: CupertinoActivityIndicator(radius: 15.0)),
    ));
  }
}
