import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:movie_app/movie.dart';
import 'package:flutter/widgets.dart';

class MoviesDatabase{
  static final MoviesDatabase instance = MoviesDatabase._openConnection();
  static Database? _database;
  MoviesDatabase._openConnection();


  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _openConnection();
    return _database!;
  }

/*
 * Creates db if not already created
 */
  Future<Database> _openConnection() async{
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'collection_database.db'),
      version: 2,
      onCreate: (db, version){
        return db.execute(
          '''CREATE TABLE collection(
            id INTEGER PRIMARY KEY,
            title TEXT,
            posterURL TEXT,
            description TEXT,
            year TEXT,
            runtime TEXT,
            rating TEXT,
            backdropURL TEXT,
            genres TEXT
          )'''
        );
      }
    );
  }

  /*
   * Adds a given movie to the collection
   * movie a populated movie object
   */
  Future<void> addMovie(Movie movie) async{
    final db = await instance.database;
    await db.insert('collection', movie.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /*
   * Retreives all movies from the collection
   */
  Future<List<Movie>> getCollection() async{
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('collection');
    final List<Map<String, dynamic>> rawMaps = await db.rawQuery('SELECT * FROM collection');
    if(maps.length == 0)
      return <Movie>[];
    return List<Movie>.generate(maps.length, (i){
      return Movie(
        title: maps[i]['title'],
        posterURL: maps[i]['posterURL'],
        description: maps[i]['description'],
        year: maps[i]['year'],
        runtime: maps[i]['runtime'],
        rating: maps[i]['rating'],
        inCollection: true,
        genres: maps[i]['genres'].split('|'),
        id: maps[i]['id'],
        backdropURL: maps[i]['backdropURL']
      );
    });
  }

  /*
   * Removes a given movie from the collection
   * id: the id corresponding to a movie in the collection
   */
  Future<void> removeMovie(int id) async{
    final db = await instance.database;
    await db.delete('collection', where: 'id = ?', whereArgs: [id]);
  }

  /**
   * Check if a given movie is in the collection
   * id: the id corresponding to the movie we want to check
   */
  Future<bool> inCollection(int id) async{
    final db = await instance.database;
    return db.query(
      'collection',
      where: 'id = ?',
      whereArgs: [id]).then((result) => result.isNotEmpty);
  }
}
