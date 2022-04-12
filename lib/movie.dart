
class Movie{
  final String title;
  String posterURL;
  String description;
  String year;
  String runtime;
  String rating;
  bool inCollection;
  List<String> genres;
  final int id;
  String backdropURL;

  Movie({this.posterURL='', required this.title, this.year='', this.runtime='', this.description='',
  this.rating='', this.inCollection=false, this.genres=const [], required this.id, this.backdropURL=''}){}

  static Movie fromJSON(Map<String, dynamic> json){
    return Movie(
      title: json['title'],
      posterURL: json['poster_path'],
      description: json['overview'],
      year: json['release_date'].substring(0, 3),
      rating: json['vote_average'],
      inCollection: false,
      id: json['id'],
      backdropURL: json['backdrop_path'],
      genres: json['genres'].split('|')
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'posterURL': posterURL,
      'description': description,
      'year': year,
      'rating': rating,
      'id': id,
      'backdropURL': backdropURL,
      'runtime': runtime,
      'genres': genres.join('|')
    };
  }

  String toString(){
    return '''
    Movie{'title': $title,
    'posterURL': $posterURL,
    'description': $description,
    'year': $year,
    'rating': $rating,
    'id': $id,
    'backdropURL': $backdropURL,
    'runtime': $runtime,
    'genres': $genres }
           ''';
  }

  // List<String> _loadGenres(List<int> genreIds){
  //   return ['None'];
  // }

  String getTitle(){return title;}

  String getPosterURL(){return posterURL;}

  String getDescription(){return description;}

  String getYear(){return year;}

  String getRuntime(){return runtime;}

  String getRating(){return rating;}

  bool getInCollection(){return inCollection;}

  void setInCollection(bool val){inCollection = val;}

  List<String> getGenres(){return genres;}

  int getId(){return id;}

  String getBackdropURL(){return backdropURL;}
}
