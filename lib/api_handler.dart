import 'package:http/http.dart';
import 'package:movie_app/movie.dart';
import 'dart:convert';
import 'package:movie_app/moviedb.dart';

class APIHandler {
  static const apiKey = String.fromEnvironment('apiKey');
  static const urlBase = 'https://api.themoviedb.org/3';
  static const posterBase = 'https://image.tmdb.org/t/p/w500';

  /// Searches for movie results with the given string
  /// Returns a list of Movies constructed from the search results
  static Future<List<Movie>> movieSearch(String searchTerm) async {
    Response res = await get(Uri.parse('$urlBase/search/movie?api_key=$apiKey&'
        'language=en-US&page=1&include_adult=false&query=$searchTerm'));
    if (res.statusCode == 200) {
      List<dynamic> movies = jsonDecode(res.body)['results'];

      List<bool> collected = [];
      for (int i = 0; i < movies.length; i++) {
        collected
            .add(await MoviesDatabase.instance.inCollection(movies[i]['id']));
      }

      return List<Movie>.generate(movies.length, (i) {
        String poster = '';
        if (movies[i]['poster_path'] != null) {
          poster = posterBase + movies[i]['poster_path'];
        }

        String year = '';
        if (movies[i]['release_date'].length > 1) {
          year = movies[i]['release_date'].substring(0, 4);
        }

        return Movie(
            id: movies[i]['id'],
            title: movies[i]['title'],
            posterURL: poster,
            description: movies[i]['overview'] ??= '',
            year: year,
            rating: movies[i]['vote_average'],
            backdropURL: movies[i]['backdrop_path'] ??= '',
            inCollection: collected[i]);
      });
    }
    return <Movie>[];
  }

  /// Gets more movie details for a movie
  /// id: the id of the movie to find
  /// Returns a Movie object hydrated with all details
  static Future<Movie> getMovieDetails(int id) async {
    Response res = await get(
        Uri.parse('${urlBase}/movie/$id?api_key=$apiKey&language=en-US'));
    if (res.statusCode == 200) {
      Map<String, dynamic> details = jsonDecode(res.body);

      List<String> genres = [];
      for (int i = 0; i < details['genres'].length; i++) {
        genres.add(details['genres'][i]['name']);
      }

      bool inCollection = await MoviesDatabase.instance.inCollection(id);
      return Movie(
          id: id,
          title: details['title'],
          posterURL: posterBase + details['poster_path'],
          description: details['overview'],
          year: details['release_date'].substring(0, 4),
          runtime: details['runtime'],
          genres: genres,
          rating: details['vote_average'],
          backdropURL: details['backdrop_path'],
          inCollection: inCollection);
    }
    return Movie(id: -1, title: '');
  }
}
