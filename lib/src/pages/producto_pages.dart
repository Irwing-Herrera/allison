import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flu_movies/src/Provider/Productos_povider.dart';

import 'package:flu_movies/src/models/pelicula_model.dart';
import 'package:flu_movies/src/utils/utils.dart';

class ProductosPage extends StatefulWidget {
  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final peliculaProvider = new ProductosProvider();

  PeliculasModel peliculas = new PeliculasModel();
  bool _guardando=false;
  File foto;

  @override
  Widget build(BuildContext context) {
    final PeliculasModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      peliculas = prodData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Peliculas"),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(15.0),
        child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                // Crear año
                _crearAo(),
                _crearDisponible(),
                // _crearActor(),
                _crearSinopsis(),
                _crearBoton(),
              ],
            )),
      )),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: peliculas.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre pelicula'),
      onSaved: (value) => peliculas.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre de la pelicula';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearAo() {
    return TextFormField(
      initialValue: peliculas.estreno.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Estreno'),
      onSaved: (value) => peliculas.estreno = int.parse(value),
      validator: (value) {
        if (isNumeric(value)) {
          return null;
        } else {
          return 'Sólo números ';
        }
      },
    );
  }

  // Widget _crearActor() {
  //   return TextFormField(
  //     initialValue: peliculas.actor,
  //     textCapitalization: TextCapitalization.sentences,
  //     decoration: InputDecoration(labelText: 'Nombre  actor'),
  //     onSaved: (value) => peliculas.actor = value,
  //     validator: (value) {
  //       if (value.length < 3) {
  //         return 'Ingrese el nombre del actor';
  //       } else {
  //         return null;
  //       }
  //     },
  //   );
  // }

  Widget _crearSinopsis() {
    return TextFormField(
        initialValue: peliculas.sinopsis,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(labelText: 'Sinopsis'),
        onSaved: (value) => peliculas.sinopsis = value,
        validator: (value) {
          if (value.length < 3) {
            return 'Ingrese sinopsis ';
          } else {
            return null;
          }
        });
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: peliculas.disponible,
      activeColor: Colors.deepOrange,
      onChanged: (value) => setState(() {
        peliculas.disponible = value;
      }),
      title: Text('Disponible'),
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepOrange,
      label: Text('Guardar'),
      textColor: Colors.white,
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit()  async{
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });
    if (foto !=null){
     mostrarSnackbar('Regisro guardado');
     peliculas.poster= await peliculaProvider.subirImagen(foto);
    }

    if (peliculas.id == null) {
      peliculaProvider.crearProducto(peliculas);
    } else {
      peliculaProvider.editarProducto(peliculas);
    }
    // setState(() {
    //     _guardando=false;
    // });
    Navigator.pushReplacementNamed(context, 'Home');
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto() {
    if (peliculas.poster != null) {
      return FadeInImage(
        image: NetworkImage(peliculas.poster),
        placeholder: AssetImage('assets/bote.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/imagen.png'),
        fit: BoxFit.cover,
        height: 300.0,
        
      );
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }
    

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }
  _procesarImagen(ImageSource origen)async{
    foto= await ImagePicker.pickImage(
      source:origen 
      );
      if(foto !=null){
        peliculas.poster=null;

    }
    setState(() {
      
    });

  }

  
  
}