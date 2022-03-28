class Movie{
  String title;
  String posterURL;
  String description;
  String year;
  String runtime;
  String rating;
  bool inCollection;
  List<String> genres;
  int id;
  String backdropURL;

  Movie({this.posterURL='', this.title='', this.year='', this.runtime='', this.description='',
  this.rating='', this.inCollection=false, this.genres=const [], this.id=-1, this.backdropURL=''}){}

  static Movie fromJSON(Map<String, dynamic> json){
    return Movie(
      title: json['title'],
      posterURL: json['poster_path'],
      description: json['overview'],
      year: json['release_date'].substring(0, 3),
      rating: json['vote_average'],
      inCollection: false,
      // genres: _loadGenres(json['genre_ids']),
      id: json['id'],
      backdropURL: json['backdrop_path']
    );
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

  void toggleInCollection(){inCollection = !inCollection;}

  List<String> getGenres(){return genres;}

  int getId(){return id;}

  String getBackdropURL(){return backdropURL;}
}
