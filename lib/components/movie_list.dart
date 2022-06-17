import 'package:flutter/material.dart';
import 'movie_card.dart';
import 'package:movie_app/movie.dart';

// ignore: must_be_immutable
class MovieList extends StatelessWidget {
  List<Widget> _movies = [];
  Axis direction;

  MovieList(List<Movie> movieData, {Key? key, this.direction = Axis.vertical})
      : super(key: key) {
    _movies = List<Widget>.generate(movieData.length, (i) {
      return MovieCard(movieData[i]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0), child: Column(children: _movies));
  }
}
