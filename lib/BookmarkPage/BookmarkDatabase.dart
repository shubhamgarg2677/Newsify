import 'dart:async';

import 'package:newsify/Model/Articles.dart';
import 'package:newsify/Model/BookmarkDatabaseModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BookMarkDatabase{

  Future<Database> database;

  void startData()
  {
    _openData();
  }

  void addData(BookmarkDatabaseModel articles)
  {
    _insertData(articles);
  }

  void delData(int id)
  {
    _deleteData(id);
  }

  Future<List<BookmarkDatabaseModel>> getData()
  {
    return delayData();
  }

  Future<List<BookmarkDatabaseModel>> delayData() async
  {
    List<BookmarkDatabaseModel> cc = await Future.delayed(Duration(milliseconds: 500), () => _retreiveData());
   // print("--->length${cc.length}");
    return cc;
  }


  //author,title,description,url,urlToImage,publishedAt,content
   _openData() async
  {
     database = openDatabase(
      join(await getDatabasesPath(), 'bookmark_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE bookmarks(id INTEGER PRIMARY KEY, author TEXT, title TEXT, description TEXT, url TEXT, urlToImage TEXT, publishedAt TEXT, content TEXT)"
        );
      },
      version: 1,
    );
  }

  Future<void> _insertData(BookmarkDatabaseModel articles) async
  {
    Database db=await database;
    await db.insert(
      "bookmarks",
      toMap(articles),
      conflictAlgorithm: ConflictAlgorithm.replace,
      );
  }

    Map<String, dynamic> toMap(BookmarkDatabaseModel articles) {
    return {
      'id':articles.id,
      'author':articles.author,
      'title':articles.title,
      'description':articles.description,
      'url':articles.url,
      'urlToImage':articles.urlToImage,
      'publishedAt':articles.publishedAt,
      'content':articles.content,
    };
  }


  Future<List<BookmarkDatabaseModel>> _retreiveData() async
  {
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('bookmarks');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return BookmarkDatabaseModel(maps[i]['id'],maps[i]['author'],maps[i]['title'],maps[i]['description'],maps[i]['url'],maps[i]['urlToImage'],maps[i]['publishedAt'],maps[i]['content']);
    });
  }

  Future<void> _deleteData(int id) async
  {
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'bookmarks',
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}