import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_info.dart';
import 'package:movie_app/movie.dart';
import 'package:movie_app/api_handler.dart';

class MovieCard extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var _movie; // Movie

  MovieCard(Movie movie, {Key? key}) : super(key: key) {
    _movie = movie;
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    if (_movie.getTitle().length > 35) {
      title = _movie.getTitle().substring(0, 31) + '...';
    } else {
      title = _movie.getTitle();
    }

    return Container(
        constraints: const BoxConstraints(maxHeight: 200),
        child: Card(
            color: Theme.of(context).colorScheme.surface,
            child: InkWell(
                onTap: () async {
                  Movie details =
                      await APIHandler.getMovieDetails(_movie.getId());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieInfo(details)));
                },
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Image.network(_movie.getPosterURL(),
                        fit: BoxFit.fitWidth),
                  ),
                  Expanded(
                      flex: 5,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                flex: 5,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 30)),
                                      Text(_movie.getYear(),
                                          style: const TextStyle(fontSize: 17)),
                                    ]))
                          ]))
                ]))));
  }
}
