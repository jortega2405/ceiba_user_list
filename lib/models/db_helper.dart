import 'package:ceiba_user_list/models/post_model.dart';
import 'package:ceiba_user_list/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DbHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'users.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  // creating database table
  _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE user(
          id INTEGER PRIMARY KEY, 
          name TEXT , 
          phone TEXT, 
          email TEXT
          )
        ''');

    await db.execute('''
        CREATE TABLE post(
          userId INTEGER , 
          id INTEGER PRIMARY KEY, 
          title TEXT
          )
        ''');
  }

  // inserting data into the table
  Future<UserModel> insertUsers(UserModel user) async {
    var dbClient = await database;
    await dbClient!.insert('user', user.toMap());
    return user;
  }

  Future<Posts> insertPosts(Posts posts) async {
    var dbClient = await database;
    await dbClient!.insert('post', posts.toMap());
    return posts;
  }

  // getting all the items in the list from the database
  Future<List<UserModel>> getUserList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('user');
    List<UserModel> u =
        queryResult.map((result) => UserModel.fromMap(result)).toList();
    return u;
  }

  Future<List<Posts>> getPostList(userId) async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('post',where:'userId = ?',whereArgs: [userId]);
    List<Posts> u =
        queryResult.map((result) => Posts.fromMap(result)).toList();
    return u;
  }
}
