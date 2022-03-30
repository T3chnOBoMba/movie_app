import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:movie_app/movie.dart';
import 'package:flutter/widgets.dart';

/*
 * Creates db if not already created
 */
void initDatabase() async{
  WidgetFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'collection_database.db'),
    onCreate: (db, version){
      return db.execute(
        'CREATE TABLE collection(
          id INTEGER PRIMARY KEY,
          title TEXT,
          posterURL TEXT,
          description TEXT,
          year TEXT,
          runtime TEXT,
          rating TEXT,
          backdropURL TEXT,
          genres TEXT
        )'
      );
    },
    version: 2.0.2
  )
}

/*
 * Adds a given movie to the collection
 * movie a populated movie object
 */
Future<void> addMovie(Movie movie) async{
  final db = await db;
  await db.insert('collection', movie.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

/*
 * Retreives all movies from the collection
 */
Future<List<Movie>> getCollection() async{
  final db = await database;
  final List<Map<String, Dynamic>> maps = await db.query('collection');
  return List.generate(maps.length, (i) {
    return Movie.FromJSON(maps[i]);
  });
}

/*
 * Removes a given movie from the collection
 * id: the id corresponding to a movie in the collection
 */
Future<void> removeMovie(int id) async{
  final db = await database;
  await db.delete('collection', where: 'id = ?', whereArgs: [id]);
}
