import 'package:flutter/material.dart';
import 'package:flu_movies/src/utils/session.dart';
import 'src/routes/routes.dart';

Future<void> main() async {
  // inicializar paquete de etrceros antes de que se ejecute el main
  // se puso por que la version mia es mayor a la que se creo el proyecto
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = new Session();
  await sharedPrefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final sharedPrefs = new Session();
    print('TOKEN:: ${sharedPrefs.token}');

    return MaterialApp(
      title: 'Flu-movie',
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: obtenerRutas(),
    );
  }
}
