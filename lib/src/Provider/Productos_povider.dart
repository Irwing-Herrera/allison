import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:flu_movies/src/models/pelicula_model.dart';
import 'package:flu_movies/src/utils/utils.dart' as util;

class ProductosProvider {
  final String _url = 'https://peliculas-82930.firebaseio.com';

  Future<bool> crearProducto(PeliculasModel producto) async {
    final url = '$_url/peliculas.json';

    final resp = await http.post(url, body: peliculasModelToJson(producto));
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarProducto(PeliculasModel producto) async {
    final url = '$_url/peliculas/${producto.id}.json';

    final resp = await http.put(url, body: peliculasModelToJson(producto));
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<PeliculasModel>> cargarProductos() async {
    final url = '$_url/peliculas.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<PeliculasModel> productos = new List();

    if (decodedData == null) return [];
    decodedData.forEach((id, peliculas) {
      final prodTemp = PeliculasModel.fromJson(peliculas);
      prodTemp.id = id;

      productos.add(prodTemp);
    });

    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/peliculas/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));

    return 1;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dw8hhhiht/image/upload?upload_preset=qp6xy7rx');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }
    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }

  Future<List<PeliculasModel>> buscarPelicula(String query) async {
    List<PeliculasModel> listPeliculas = await cargarProductos();
    final List<PeliculasModel> peliculasFiltradas = new List();

    if (util.isNumeric(query)) {
        listPeliculas.forEach((p) {
          if (p.estreno.toString().startsWith(query)) {
            peliculasFiltradas.add(p);
          }
        });
    } else {
        listPeliculas.forEach((p) {
          if (p.titulo.toLowerCase().contains(query.toLowerCase())) {
            peliculasFiltradas.add(p);
          }
        });
    }

    return peliculasFiltradas;
  }

}