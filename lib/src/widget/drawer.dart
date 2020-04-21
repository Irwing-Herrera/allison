import 'package:flutter/material.dart';
import 'package:flu_movies/src/utils/session.dart';
// import 'package:login/src/utils/session.dart';

class DrawerWidget extends StatelessWidget {

  final _session = Session();
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.pinkAccent),
              accountName: Text("Bienvenido (a)"),
              accountEmail: Text(_session.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0, color: Colors.pinkAccent),
                ),
              )),
          ListTile(
            title: Text("Agregar peliculas"),
            trailing: Icon(Icons.add),
            onTap: () {
              Navigator.pushNamed(context, 'producto');
            },
          ),
          ListTile(
            title: Text("Lista de peliculas"),
            trailing: Icon(Icons.list),
            onTap: () {
              Navigator.pushNamed(context, 'lista');
            },
          ),
          ListTile(
            title: Text("Cerrar Sesión"),
            trailing: Icon(Icons.close),
            onTap: () {
              _session.token = null;
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
