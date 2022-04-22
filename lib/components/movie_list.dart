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
  //
  // @override
  // Widget build(BuildContext context){
  //   return ListView.builder(
  //     padding: EdgeInsets.all(5.0),
  //     itemCount: _movies.length,
  //     scrollDirection: direction,
  //     itemBuilder: (BuildContext context, int i){
  //       String tempTitle = _movies[i].getTitle();
  //       if(tempTitle.length > 35) {
  //         tempTitle = tempTitle.substring(0, 31) + '...';
  //       }
  //       return MovieCard(_movies[i]);
  //     }
  //   );
  // }
  Widget build(BuildContext context){

    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: _movies
      )
    );
  }
}
