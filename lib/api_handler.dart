import 'package:http/http.dart';
import 'package:movie_app/movie.dart';
import 'dart:convert';
import 'package:movie_app/moviedb.dart';

class APIHandler{

  static const APIKEY = String.fromEnvironment('API_KEY');
  static const URLBASE = 'https://api.themoviedb.org/3';
  static const POSTERBASE = 'https://image.tmdb.org/t/p/w500';

  /**
   * Searches for movie results with the given string
   * Returns a list of Movies constructed from the search results
   */
  static Future<List<Movie>> movieSearch(String searchTerm) async{
    Response res = await get(Uri.parse('$URLBASE/search/movie?api_key=$APIKEY&'
      'language=en-US&page=1&include_adult=false&query=$searchTerm'));
    if(res.statusCode == 200){
      List<dynamic> movies = jsonDecode(res.body)['results'];
      movies = APIHandler.filterMovies(movies);

      List<bool> collected = [];
      for(int i = 0; i < movies.length; i++)
        collected.add(await MoviesDatabase.instance.inCollection(movies[i]['id']));

      return List<Movie>.generate(movies.length, (i){

        String poster = '';
        if(movies[i]['poster_path'] != null)
          poster = POSTERBASE + movies[i]['poster_path'];

        String year = '';
        if(movies[i]['release_date'].length > 1)
          year = movies[i]['release_date'].substring(0, 4);

        return Movie(
          id: movies[i]['id'],
          title: movies[i]['title'],
          posterURL: poster,
          description: movies[i]['overview'] ??= '',
          year: year,
          rating: movies[i]['vote_average'].toDouble(),
          backdropURL: movies[i]['backdrop_path'] ??= '',
          inCollection: collected[i]
        );
      });
    }
    return <Movie>[];
  }

  /**
   * Gets more movie details for a movie
   * id: the id of the movie to find
   * Returns a Movie object hydrated with all details
   */
  static Future<Movie> getMovieDetails(int id) async{
    Response res = await get(Uri.parse('$URLBASE/movie/${id}?api_key=$APIKEY&language=en-US'));
    if(res.statusCode == 200){
      Map<String, dynamic> details = jsonDecode(res.body);

      List<String> genres = [];
      for(int i = 0; i < details['genres'].length; i++)
        genres.add(details['genres'][i]['name']);

      bool inCollection = await MoviesDatabase.instance.inCollection(id);
      return Movie(
        id: id,
        title: details['title'],
        posterURL: POSTERBASE + details['poster_path'],
        description: details['overview'],
        year: details['release_date'].substring(0, 4),
        runtime: details['runtime'],
        genres: genres,
        rating: details['vote_average'],
        backdropURL: details['backdrop_path'],
        inCollection: inCollection
      );
    }
    return Movie(id: -1, title: '');
  }

  static Future<List<Movie>> getRecommendations({required List<String> genres, int decade=-1,
    bool ratingMatters=false, int person=-1, int maxLength=0}) async{
      String genreString = '';
      for(int i = 0; i < genreString.length; i++){
        genreString += genres[i].toString();
        if(i < genreString.length - 1)
          genreString += '|';
      }
      // build query string
      String query = URLBASE + '/discover/movie?api_key=$APIKEY&with_genres=$genreString';
      if(ratingMatters)
        query += '&vote_average.gte=7.0';
      if(person > -1)
        query += 'with_people=$person';
      if(maxLength > 0)
        query += 'with_runtime.lte=$maxLength';

      Response res = await get(Uri.parse(query));
      if(res.statusCode == 200){
        List<dynamic> results = jsonDecode(res.body)['results'];
        List<dynamic> movies = APIHandler.filterMovies(results);
        movies = movies.where((i) => (i['release_date'].substring(0, 4).toInt() > decade
          && i['release_date'].substring(0, 4).toInt() < decade + 10)).toList();
        return List<Movie>.generate(movies.length, (i){
          return Movie(
            id: movies[i]['id'],
            title: movies[i]['title'],
            posterURL: movies[i]['poster_path'],
            description: movies[i]['poster_path'],
            year: movies[i]['release_date'].substring(0, 4),
            runtime: movies[i]['runtime'],
            rating: movies[i]['vote_average'],
            backdropURL: movies[i]['backdrop_path'],
            inCollection: false
          );
        });
      }
      return <Movie>[];
    }

  /**
   * Get a list of information regarding all genres from the API
   * Each element is a Map with the id and name of a genre
   */
  static Future<List<Map<String, dynamic>>> getGenres() async{
    Response res = await get(Uri.parse('$URLBASE/genre/movie/list?api_key=$APIKEY'
    '&language=en-US'));
    if(res.statusCode == 200)
      return jsonDecode(res.body)['genres'];
    else{
      print(res.statusCode);
      return <Map<String, dynamic>>[];
    }
  }

  static List<dynamic> filterMovies(List<dynamic> movies){
    return movies.where((i) => (i['poster_path'] != null && i['release_date'] != '')).toList();
  }
}
