import 'package:flutter/material.dart';
import 'package:movie_app/movie.dart';
import 'package:movie_app/components/movie_list.dart';
import 'package:movie_app/components/tmdb_footer.dart';
import 'package:movie_app/moviedb.dart';
import 'package:movie_app/api_handler.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SearchScreen extends StatefulWidget{
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{

  String _searchTerm = '';

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search')
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    onChanged: (String val) => setSearchTerm(val)
                  )
                ),
                ElevatedButton(
                  onPressed: (){getSearchResults(_searchTerm);},
                  child: const Text('Search')
                )
              ]
            ),
            FutureBuilder(
              future: getSearchResults(_searchTerm),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                if(snapshot.connectionState != ConnectionState.done)
                  return JumpingDotsProgressIndicator(fontSize: 25.0);
                if(snapshot.data == [] || snapshot.data == null)
                  return const Text("Found no matches for your search");
                return Container(
                  child: MovieList(snapshot.data),
                );
              }
            ),
            Container(
              child: TmdbFooter(),
              margin: EdgeInsets.all(10.0)
            )
          ]
        )
    );
  }

  void setSearchTerm(String term){
    setState(() => _searchTerm = term);
  }

  Future<List<Movie>> getSearchResults(String term) async{
    // check that the search term begins with a letter
    RegExp exp = RegExp(r"(^[a-z]|[A-Z]).*");
    if(exp.hasMatch(term))
      return await APIHandler.movieSearch(term);
    return <Movie>[];
  }
}
