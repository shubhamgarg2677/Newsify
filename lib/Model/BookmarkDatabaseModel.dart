import 'package:json_annotation/json_annotation.dart';
import 'package:newsify/Model/Source.dart';


class BookmarkDatabaseModel
{
  BookmarkDatabaseModel(this.id,this.author,this.title,this.description,this.url,this.urlToImage,this.publishedAt,this.content);

  int id;

  String author,title,description,url,urlToImage,publishedAt,content;

}