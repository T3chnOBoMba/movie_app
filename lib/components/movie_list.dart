import 'package:flutter/material.dart';
import 'movie_card.dart';
import 'package:movie_app/movie.dart';

class MovieList extends StatelessWidget{
  List<Widget> _movies = [];
  Axis direction;

  MovieList(List<Movie> movieData, {this.direction=Axis.vertical}){
    _movies = List<Widget>.generate(movieData.length, (i){
      return MovieCard(movieData[i]);
    });
  }

  Widget build(BuildContext context){

    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: _movies
      )
    );
  }
}
