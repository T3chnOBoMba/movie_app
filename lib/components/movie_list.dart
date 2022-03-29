import 'package:flutter/material.dart';
import 'movie_card.dart';
import 'package:movie_app/movie.dart';

class MovieList extends StatelessWidget{
  List<Movie> _movies = [];
  Axis direction;

  MovieList(List<Movie> movieData, {this.direction=Axis.vertical}){
    _movies = movieData;
  }

  Widget build(BuildContext context){
    return ListView.builder(
      padding: EdgeInsets.all(5.0),
      itemCount: _movies.length,
      scrollDirection: direction,
      itemBuilder: (BuildContext context, int i){
        String tempTitle = _movies[i].getTitle();
        if(tempTitle.length > 35) {
          tempTitle = tempTitle.substring(0, 31) + '...';
        }
        return MovieCard(_movies[i]);
      }
    );
  }
}
