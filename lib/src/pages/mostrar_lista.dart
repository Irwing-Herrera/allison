import 'package:flutter/material.dart';
import 'package:flu_movies/src/Provider/Productos_povider.dart';

import 'package:flu_movies/src/models/pelicula_model.dart';

class MostrarLista extends StatelessWidget {
  final peliculasProvider = new ProductosProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('lista de peliculas'),
       backgroundColor: Colors.pinkAccent
      ),
      
      body: _crearlista(),
    );
  }

  Widget _crearlista() {
    return FutureBuilder(
        future: peliculasProvider.cargarProductos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PeliculasModel>> snapshot) {
          if (snapshot.hasData) {
            final productos =snapshot.data;
            return ListView.builder(
              itemBuilder: (context , i)=>_crearItem( context, productos[i]),
              itemCount: productos.length,
              );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
  Widget _crearItem(BuildContext context,PeliculasModel producto){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color:Colors.red,
      ),
      onDismissed: (direccion){
        peliculasProvider.borrarProducto(producto.id);
     
      },
          child: Card(
            child: Column(
              children: <Widget>[
                (producto.poster==null)
                ? Image(image:AssetImage('assets/imagen.png'))
                : FadeInImage(
                  placeholder: AssetImage('assets/bote.gif'), 
                  image: NetworkImage(producto.poster),
                  height: 300.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  ),
                   ListTile(
        title:  Text('${producto.titulo}- ${producto.estreno}-${producto.sinopsis}'),
        subtitle: Text(producto.id),
        onTap: ()=> Navigator.pushNamed(context, 'producto', arguments:producto ),
      ),
      
              ],
            ),
          )
    );
   
  }
}