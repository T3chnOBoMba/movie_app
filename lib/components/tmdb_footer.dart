import 'package:flutter/material.dart';

class TmdbFooter extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const TmdbFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.asset("assets/images/tmdbLogo.jpg"),
              Text(
                  "This product uses the TMDB API but is not endorsed or certified by TMDB.",
                  style: Theme.of(context).textTheme.displaySmall),
            ]));
  }
}
