import 'package:flutter/material.dart';
import 'package:movie_app/movie.dart';
import 'package:movie_app/components/tmdb_footer.dart';

class MovieInfo extends StatelessWidget{
  var _movie;

  MovieInfo(Movie movie){_movie = movie;}

  Widget build(BuildContext context){
    String buttonText = '';
    if(_movie.getInCollection())
      buttonText = "Remove from Collection";
    else
      buttonText = "Add to Collection";
    return Scaffold(
      appBar: AppBar(
        title: Text(_movie.getTitle())
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(_movie.getTitle(), style: TextStyle(fontSize: 40))
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.network(_movie.getPosterURL(), fit: BoxFit.contain)
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top:10.0, bottom: 10.0),
              child: Text(_movie.getDescription(), style: TextStyle(fontSize: 20))
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('Runtime: ' + _movie.getRuntime(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                Text('Rating: ' + _movie.getRating(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
              ]
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: (){_movie.toggleInCollection();},
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
}
