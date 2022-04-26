import 'package:flutter/material.dart';
import 'package:movie_app/components/movie_card.dart';
import 'package:movie_app/movie.dart';
import 'package:movie_app/components/movie_list.dart';
import 'package:movie_app/components/tmdb_footer.dart';
import 'package:movie_app/moviedb.dart';
import 'dart:async';
import 'package:movie_app/screens/search_screen.dart';
import 'package:progress_indicators/progress_indicators.dart';

class MovieCollection extends StatelessWidget{

  MovieCollection(){}

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15.0),
            alignment: Alignment(1.0, -1.0),
            height: MediaQuery.of(context).size.height * 0.05,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SearchScreen())
                );
              },
              child: const Text("Add New Movie")
            )
          ),
          FutureBuilder(
            future: MoviesDatabase.instance.getCollection(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
              if(snapshot.connectionState != ConnectionState.done)
                return JumpingDotsProgressIndicator(fontSize: 25.0);
              if(!snapshot.hasData)
                return const Text("You currently have no movies in your collection");
              return Container(
                margin: EdgeInsets.all(15.0),
                child: MovieList(snapshot.data)
              );
            }
          )
        ]
      )
    );
  }
}
