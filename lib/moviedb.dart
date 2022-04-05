import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:movie_app/movie.dart';
import 'package:flutter/widgets.dart';

class MoviesDatabase{
  static final MoviesDatabase instance = MoviesDatabase._openConnection();
  static Database? _database;
  MoviesDatabase._openConnection();
  MoviesDatabase.populateDB();


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
    print('Maps length = ${maps.length}');
    print('rawMaps length = ${rawMaps.length}');
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


  // temp function for testing before search is added
  Future<void> populateDB() async{
    List<Movie> movies = [new Movie(
        id: 1,
        posterURL:'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/s2xcqSFfT6F7ZXHxowjxfG0yisT.jpg',
        title:'Jaws',
        year:'1975',
        runtime:'2h 0m',
        rating:'8',
        description: 'When an insatiable great white shark terrorizes the townspeople of Amity Island, the police chief, an oceanographer and a grizzled shark hunter seek to destroy the blood-thirsty beast.'),
      new Movie(
        id: 2,
        posterURL: 'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/ux2dU1jQ2ACIMShzB3yP93Udpzc.jpg',
        title: 'Us',
        year: '2018',
        runtime: '1h 56m',
        rating: '6.8',
        description: 'Husband and wife Gabe and Adelaide Wilson take their kids to their beach house expecting to unplug and unwind with friends. But as night descends, their serenity turns to tension and chaos when some shocking visitors arrive uninvited.'),
      new Movie(
        id: 3,
        posterURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp-Gl1i7hKV3Mii7rAEOAyrXO1XubnHhFFHg&usqp=CAU',
        title: 'Spider-Man: No Way Home',
        year: '2021',
        runtime: '2h 28m',
        rating: '8.2',
        description: 'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.'),
      new Movie(
        id: 4,
        posterURL: 'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/74xTEgt7R36Fpooo50r9T25onhq.jpg',
        title: "The Batman",
        year: '2022',
        runtime: '2h 56m',
        rating: '8',
        backdropURL: 'https://www.themoviedb.org/t/p/w500_and_h282_face/j2zyoYrWjWyraHMdkqAkSG1MISJ.jpg',
        description: 'In his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.'
      ),
      new Movie(
        id: 5,
        posterURL: 'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/qVpCaBcnjRzGL3nOPHi6Suy0sB6.jpg',
        title: 'Halloween',
        year: '1978',
        runtime: '1h 31m',
        rating: '7.6',
        description: 'Fifteen years after murdering his sister on Halloween Night 1963, Michael Myers escapes from a mental hospital and returns to the small town of Haddonfield, Illinois to kill again.'
      ),
      new Movie(
        id: 6,
        posterURL: 'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/h4VB6m0RwcicVEZvzftYZyKXs6K.jpg',
        title: 'Birds of Prey (and the Fantabulous Emancipation of One Harley Quinn)',
        year: '2020',
        runtime: '1h 49m',
        rating: '7',
        description: 'Harley Quinn joins forces with a singer, an assassin and a police detective to help a young girl who had a hit placed on her after she stole a rare diamond from a crime lord.'
      )
  ];
  for(int i = 0; i < movies.length; i++){
    addMovie(movies[i]);
  }
  }

}
