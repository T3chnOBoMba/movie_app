import 'package:flutter/material.dart';
import 'package:movie_app/movie.dart';
import 'package:movie_app/components/tmdb_footer.dart';
import 'package:movie_app/moviedb.dart';
import 'package:movie_app/api_handler.dart';

class MovieInfo extends StatefulWidget{
  var movie;
  String genres = '';

  MovieInfo(Movie m){
    movie = m;
    genres = movie.getGenres().join(', ');
  }
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo>{

  Widget build(BuildContext context){
    String buttonText = '';
    if(widget.movie.getInCollection())
      buttonText = "Remove from Collection";
    else
      buttonText = "Add to Collection";
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(widget.movie.getTitle(), style: TextStyle(fontSize: 40))
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.network(widget.movie.getPosterURL(), fit: BoxFit.contain)
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(widget.genres, style: Theme.of(context).textTheme.displaySmall)
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top:10.0, bottom: 10.0),
              child: Text(widget.movie.getDescription(), style: Theme.of(context).textTheme.bodyMedium),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(widget.movie.getYear(), style: Theme.of(context).textTheme.displaySmall),
                Text('Runtime: ' + widget.movie.getRuntime(), style: Theme.of(context).textTheme.displaySmall),
                Text('Rating: ' + widget.movie.getRating(), style: Theme.of(context).textTheme.displaySmall)
              ]
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: (){collectionButtonClicked(context);},
                child: Text(buttonText)
              )
            ),
            Container(
              alignment: Alignment(0.0, -1.0),
              child: TmdbFooter()
            )
          ]
        )
      )
    );
  }

  /**
   * Add or remove a movie from the database
   */
  void collectionButtonClicked(BuildContext context){
    setState((){
      widget.movie.setInCollection(!widget.movie.getInCollection());
      if(widget.movie.getInCollection())
        MoviesDatabase.instance.addMovie(widget.movie);
      else
        MoviesDatabase.instance.removeMovie(widget.movie.getId());
    });
  }
}
