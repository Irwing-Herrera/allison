import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flu_movies/src/models/pelicula_model.dart';

class CardCarouselWidgwt extends StatefulWidget {
  final List<PeliculasModel> peliculas;

  CardCarouselWidgwt({@required this.peliculas});

  @override
  _CardCarouselWidgwtState createState() => _CardCarouselWidgwtState();
}

class _CardCarouselWidgwtState extends State<CardCarouselWidgwt> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                child: widget.peliculas[index].poster != null
                    ? FadeInImage(
                        image: NetworkImage(widget.peliculas[index].poster),
                        placeholder: NetworkImage(
                            "https://raw.githubusercontent.com/Irwing-Herrera/flutter-Peliculas/master/assets/img/placeholder.png"),
                        fit: BoxFit.cover)
                    : Image(image: AssetImage('assets/imagen.png'), fit: BoxFit.cover),
                onTap: () {
                  Navigator.pushNamed(context, 'detalle',
                      arguments: widget.peliculas[index]);
                },
              ),
            );
          },
          itemCount: widget.peliculas.length,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          layout: SwiperLayout.STACK),
    );
  }
}
