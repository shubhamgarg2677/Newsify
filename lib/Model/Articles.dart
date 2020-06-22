import 'package:json_annotation/json_annotation.dart';
import 'package:newsify/Model/Source.dart';

part 'Articles.g.dart';


@JsonSerializable()

class Articles
{

Articles(this.source,this.author,this.title,this.description,this.url,this.urlToImage,this.publishedAt,this.content);

Source source;

String author,title,description,url,urlToImage,publishedAt,content;

factory Articles.fromJson(Map<String, dynamic> json) => _$ArticlesFromJson(json);

Map<String, dynamic> toJson() => _$ArticlesToJson(this);

}