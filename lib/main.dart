import 'package:flutter/material.dart';
import 'components/movie_card.dart';
import 'components/movie_list.dart';
import 'screens/movie_collection.dart';
import 'movie.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: MovieCollection()
    );
  }
}
