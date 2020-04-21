import 'package:flutter/material.dart';
import 'package:flu_movies/src/models/pelicula_model.dart';

class DetallePeliculaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PeliculasModel pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppBar(pelicula),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(height: 10.0),
          _posterTitulo(context, pelicula),
          _descipcion(pelicula)
        ]))
      ],
    ));
  }

  Widget _crearAppBar(PeliculasModel pelicula) {
    return SliverAppBar(
        elevation: 2.0,
        backgroundColor: Colors.pinkAccent,
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: pelicula.poster != null
              ? FadeInImage(
                  image: NetworkImage(pelicula.poster),
                  placeholder: NetworkImage(
                      "https://raw.githubusercontent.com/Irwing-Herrera/flutter-Peliculas/master/assets/img/placeholder.png"),
                  fit: BoxFit.cover)
              : Image(image: AssetImage('assets/imagen.png')),
        ));
  }

  Widget _posterTitulo(BuildContext context, PeliculasModel pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: pelicula.poster != null
                ? FadeInImage(
                    image: NetworkImage(pelicula.poster),
                    placeholder: NetworkImage(
                        "https://raw.githubusercontent.com/Irwing-Herrera/flutter-Peliculas/master/assets/img/placeholder.png"),
                    fit: BoxFit.cover,height: 150)
                : Image(image: AssetImage('assets/imagen.png'),height: 150),
          ),
          SizedBox(width: 10.0),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(pelicula.titulo,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis),
              Text('Año: ${pelicula.estreno}',
                  style: Theme.of(context).textTheme.subtitle,
                  overflow: TextOverflow.ellipsis),
              Text('Duración: 103 min.',
                  style: Theme.of(context).textTheme.subtitle,
                  overflow: TextOverflow.ellipsis),
              Row(
                children: <Widget>[
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _descipcion(PeliculasModel pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(pelicula.sinopsis, textAlign: TextAlign.justify),
    );
  }
}
