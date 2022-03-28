import 'package:flutter/material.dart';

class TmdbFooter extends StatelessWidget{

  TmdbFooter(){}

  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[Container(
          child: Image.asset("assets/images/tmdbLogo.jpg")
        ),
          const Text("This product uses the TMDB API but is not endorsed or certified by TMDB." ),
        ]
      )
    );
  }
}
