import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_info.dart';
import 'package:movie_app/movie.dart';
import 'package:movie_app/api_handler.dart';

class MovieCard extends StatelessWidget{

  var _movie;   // Movie

  MovieCard(Movie movie){_movie = movie;}

  Widget build(BuildContext context){
    String title = '';
    if(_movie.getTitle().length > 35)
      title = _movie.getTitle().substring(0, 31) + '...';
    else
      title = _movie.getTitle();

    return Container(
      constraints: BoxConstraints(
        maxHeight: 200
      ),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: InkWell(
          onTap: () async{
            Movie details = await APIHandler.getMovieDetails(_movie.getId());
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => MovieInfo(details)
            )
            );
          },
          child: Row(
            children: <Widget> [
              Expanded(
                flex: 5,
                child: Container(child: Image.network(_movie.getPosterURL(), fit: BoxFit.fitWidth)),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(title, textAlign: TextAlign.center, style:  TextStyle(fontSize: 30)),
                          Text(_movie.getYear(), style:  TextStyle(fontSize: 17)),
                          // Text(_movie.getRuntime(), style:  TextStyle(fontSize: 17)),
                          // Text("Rating: " + _movie.getRating(), style:  TextStyle(fontSize: 17))
                        ]
                      )
                    )
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}
