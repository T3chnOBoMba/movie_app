import 'package:flutter/material.dart';
import 'screens/movie_collection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromRGBO(54, 48, 98, 1.0),
          onPrimary: Colors.white,
          primaryContainer: Colors.indigo.shade900,
          secondary: Colors.indigo.shade900,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.black,
          background: Color.fromRGBO(31, 29, 54, 1.0),
          onBackground: Colors.white,
          surface: Color.fromRGBO(54, 48, 98, 1.0),
          onSurface: Colors.black
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 40),
          displaySmall: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 20)
        )
      ),
      home: MovieCollection()
    );
  }
}
