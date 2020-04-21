// To parse this JSON data, do
//
//     final peliculasModel = peliculasModelFromJson(jsonString);

import 'dart:convert';

PeliculasModel peliculasModelFromJson(String str) => PeliculasModel.fromJson(json.decode(str));

String peliculasModelToJson(PeliculasModel data) => json.encode(data.toJson());

class PeliculasModel {
    String id;
    String titulo;
    int estreno;
    String actor;
    String poster;
    String sinopsis;
    bool disponible;

    PeliculasModel({
        this.id,
        this.titulo='',
        this.estreno= 0,
        this.actor='',
        this.poster,
        this.sinopsis='',
        this.disponible=true
    });

    factory PeliculasModel.fromJson(Map<String, dynamic> json) => PeliculasModel(
        id          : json["id"],
        titulo      : json["titulo"],
         estreno    : json["estreno"],
        actor       : json["actor"],
        poster     : json["poster"],
        sinopsis    :json["sinopsis"] ,
        disponible  : json["disponible"]
        
    );

    Map<String, dynamic> toJson() => {
        // "id"      : id,
        "titulo"  : titulo,
        "estreno" : estreno,      
        "poster" : poster,
        "sinopsis": sinopsis,
        "disponible":disponible
    };
}
