import 'package:flutter/material.dart';
import 'package:movie_app/components/movie_card.dart';
import 'package:movie_app/movie.dart';
import 'package:movie_app/components/movie_list.dart';
import 'package:movie_app/components/tmdb_footer.dart';
import 'package:movie_app/moviedb.dart';
import 'dart:async';
import 'package:movie_app/screens/search_screen.dart';

class MovieCollection extends StatelessWidget{

  MovieCollection(){}

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Collection")
      ),
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
                return const CircularProgressIndicator();
              if(!snapshot.hasData)
                return const Text("You currently have no movies in your collection");
              // if(snapshot.data.statusCode > 299)
              //   return const Text("Error reading collection data");
              return Container(
                margin: EdgeInsets.all(15.0),
                height: MediaQuery.of(context).size.height * 0.70,
                child: MovieList(snapshot.data)
              );
            }
          )
        ]
      )
    );
  }
}
