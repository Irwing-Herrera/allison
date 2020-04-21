import 'package:flutter/material.dart';
import 'package:flu_movies/src/Provider/Productos_povider.dart';
import 'package:flu_movies/src/models/pelicula_model.dart';

class PeliculaSearch extends SearchDelegate {

  String seleccion = '';
  final peliculasProvaider = new ProductosProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // acciones de nuestro appBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del appBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados quwe vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen en lo que la persona escribe
    if (query.isEmpty) {
      return Container();
    }
    
    return FutureBuilder(
      future: peliculasProvaider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<PeliculasModel>> snapshot) {

        if (snapshot.hasData) {

          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.poster),
                  placeholder: AssetImage('assets/imagen.png'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.titulo),
                subtitle: Text("Estreno: ${pelicula.estreno}"),
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList(),
          );

        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
