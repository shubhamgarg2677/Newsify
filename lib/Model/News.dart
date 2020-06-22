import 'package:json_annotation/json_annotation.dart';

import 'Articles.dart';

part 'News.g.dart';

@JsonSerializable()

class News{

   News(this.status,this.totalResults,this.articles);

   String status;
   int totalResults;

   List<Articles> articles;

  //   String getNewsTimestamp()
  //  {
  //    return newsTimestamp;
  //  }
  //   String getArticleCount()
  //  {
  //    return newsArticleCount;
  //  }
  //   String getNewsArticleTitle()
  //  {
  //    return newsArticleTitle;
  //  }
  //   String getNewsArticleDesc()
  //  {
  //    return newsArticleDesc;
  //  }
  //   String getNewsArticleUrl()
  //  {
  //    return newsArticleUrl;
  //  }
  //   String getNewsArticleImage()
  //  {
  //    return newsArticleImage;
  //  }
  //   String getNewsPublishedAt()
  //  {
  //    return newsPublishedAt;
  //  }
  //   String getNewsSourceName()
  //  {
  //    return newsSourceName;
  //  }
  //   String getNewsSourceUrl()
  //  {
  //    return newsSourceUrl;
  //  }
  //   setNewsTimestamp(String newsTimestamp)
  //   {
  //     this.newsTimestamp=newsTimestamp;
  //   }
  //   setNewsArticleCount(String newsArticleCount)
  //   {
  //     this.newsArticleCount=newsArticleCount;
  //   }
  //   setNewsArticleTitle(String newsArticleTitle)
  //   {
  //     this.newsArticleTitle=newsArticleTitle;
  //   }
  //   setNewsArticleDesc(String newsArticleDesc)
  //   {
  //     this.newsArticleDesc=newsArticleDesc;
  //   }
  //   setNewsArticleUrl(String newsArticleUrl)
  //   {
  //     this.newsArticleUrl=newsArticleUrl;
  //   }
  //   setNewsArticleImage(String newsArticleImage)
  //   {
  //     this.newsArticleImage=newsArticleImage;
  //   }
  //   setNewsPublishedAt(String newsPublishedAt)
  //   {
  //     this.newsPublishedAt=newsPublishedAt;
  //   }
  //   setNewsSourceName(String newsSourceName)
  //   {
  //     this.newsSourceName=newsSourceName;
  //   }
  //    setNewsSourceUrl(String newsSourceUrl)
  //   {
  //     this.newsSourceUrl=newsSourceUrl;
  //   }

factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

Map<String, dynamic> toJson() => _$NewsToJson(this);

}

