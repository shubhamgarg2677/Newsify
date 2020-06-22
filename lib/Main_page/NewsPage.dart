import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newsify/Model/Articles.dart';
import 'package:newsify/Model/News.dart';
import 'package:http/http.dart' as http;
import 'package:newsify/OpenNews/OpenNews.dart';

class NewsPage extends StatefulWidget {
  String title;

  NewsPage(this.title);

  @override
  State<StatefulWidget> createState() {
    return NewsPageState(title);
  }
}

class NewsPageState extends State<NewsPage> {
  String title;
  Future<News> newsList;
  bool _hasMore = false, _loadingMore = false;
  int topheadPage = 0,
      globalPage = 0,
      nationPage = 0,
      bussinessPage = 0,
      techPage = 0,
      entertainPage = 0,
      sportsPage = 0,
      sciencePage = 0,
      healthPage = 0;
  List<Articles> topheadList = new List<Articles>(),
      globeList = new List<Articles>(),
      nationList = new List<Articles>(),
      bussinessList = new List<Articles>(),
      techList = new List<Articles>(),
      entertainList = new List<Articles>(),
      spotsList = new List<Articles>(),
      scienceList = new List<Articles>(),
      healthList = new List<Articles>();

  NewsPageState(this.title);

  Future<News> fetchNews() async {
    var response;
    //response=await http.get("https://newsapi.org/v2/top-headlines");
    switch (title) {
      case "Top News":
        topheadPage = topheadPage + 1;
        print(
            "https://newsapi.org/v2/top-headlines?country=in&apiKey=ee0ed53a336240119a1f657c9bf9d5ef&page=${topheadPage}");
        response = await http.get(
            "https://newsapi.org/v2/top-headlines?country=in&apiKey=ee0ed53a336240119a1f657c9bf9d5ef&page=${topheadPage}");
        break;
      case "Around Globe":
        globalPage = globalPage + 1;
        response = await http.get(
            "https://newsapi.org/v2/top-headlines?country=us&apiKey=ee0ed53a336240119a1f657c9bf9d5ef&page=${globalPage}");
        break;
      case "In Nation":
        nationPage = nationPage + 1;
        response = await http.get(
            "https://newsapi.org/v2/top-headlines?country=in&category=general&apiKey=ee0ed53a336240119a1f657c9bf9d5ef&page=${nationPage}");
        break;
      case "Bussiness":
        bussinessPage = bussinessPage + 1;
        response = await http.get(
            "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=ee0ed53a336240119a1f657c9bf9d5ef&page=${bussinessPage}");
        break;
      case "Technology":
        techPage = techPage + 1;
        response = await http.get(
            "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=ee0ed53a336240119a1f657c9bf9d5ef&page=${techPage}");
        break;
      case "Entertainment":
        entertainPage = entertainPage + 1;
        response = await http.get(
            "https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=ee0ed53a336240119a1f657c9bf9d5ef&page=${entertainPage}");
        break;
      case "Sports":
        sportsPage = sportsPage + 1;
        response = await http.get(
            "https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=ee0ed53a336240119a1f657c9bf9d5ef&page=${sportsPage}");
        break;
      case "Science":
        sciencePage = sciencePage + 1;
        response = await http.get(
            "https://newsapi.org/v2/top-headlines?country=in&category=science&apiKey=ee0ed53a336240119a1f657c9bf9d5ef&page=${sciencePage}");
        break;
      case "Health":
        healthPage = healthPage + 1;
        response = await http.get(
            "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=ee0ed53a336240119a1f657c9bf9d5ef&page=${healthPage}");
        break;
    }

    if (response != null) {
      if (response.statusCode == 200) {
        _loadingMore = true;
        print("bcj " + response.toString());
        return News.fromJson(json.decode(response.body));
      } else {
        print("bcj " + response.toString());
        throw Exception('Failed to load News');
      }
    } else {
      print("bcj " + "null");
    }
  }

  @override
  void initState() {
    super.initState();
    print("init_methodllll");
    newsList = fetchNews();
    print("init_method");
  }

  List<Articles> getTitleList() {
    switch (title) {
      case "Top News":
        return topheadList;
        break;
      case "Around Globe":
        return globeList;
        break;
      case "In Nation":
        return nationList;
        break;
      case "Bussiness":
        return bussinessList;
        break;
      case "Technology":
        return techList;
        break;
      case "Entertainment":
        return entertainList;
        break;
      case "Sports":
        return spotsList;
        break;
      case "Science":
        return scienceList;
        break;
      case "Health":
        return healthList;
        break;
    }
  }

  _loadData() async {
    print("in load data");
    setState(() {
      _loadingMore = false;
      newsList = fetchNews();
      print("data_loaded");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<News>(
        future: newsList,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              print("ConnectionState.waiting");
              return Center(
                child: Container(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
              );
            case ConnectionState.none:
              print("ConnectionState.none");
              return Center(
                child: Container(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.yellow,
                    ),
                  ),
                ),
              );
            default:
              if (snapshot.hasData) {
                List<Articles> dataList = getTitleList();

                print(snapshot.data.toJson().toString());

                for (Articles articles in snapshot.data.articles) {
                  dataList.add(articles);
                }
                if (dataList.length >= 100) {
                  _hasMore = false;
                } else {
                  _hasMore = true;
                }

                return CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: _horizontalList(dataList),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            // if(_hasMore)
                            // {
                            //   print("_hasmore");
                            //   if(index==dataList.length-11)
                            //   {
                            //     print("sizecheck");
                            //     if(_loadingMore)
                            //     {
                            //       print("load_data");
                            //       _loadData();
                            //     }
                            //     return Container(
                            //                 height: 60,
                            //                 width: 60,
                            //                 child: Center(
                            //                   child: CircularProgressIndicator(
                            //                   backgroundColor: Colors.yellow,
                            //                 ),
                            //                 ),
                            //               );
                            //   }
                            //   return NewsItemVertical(dataList[index+10]);
                            // }
                            return NewsItemVertical(dataList[index + 10]);
                          },
                          childCount: dataList.length - 10,
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return Text("");
              }
          }
          //print(snapshot.data.toJson().toString());

          // By default, show a loading spinner.
        },
      ),
      //   child: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverToBoxAdapter(
      //       child: _horizontalList(newsList),
      //     ),
      //     SliverPadding(
      //       padding: const EdgeInsets.only(
      //         left: 16,
      //         right: 16,
      //       ),
      //       sliver: SliverList(

      //         delegate: SliverChildBuilderDelegate((BuildContext context,int index)
      //         {
      //           return NewsItemVertical();
      //         },
      //         childCount: 10,
      //         ),

      //         ),
      //       ),
      //   ],
      // ),
    );
  }
}

class NewsItemHorizontal extends StatelessWidget {
  Articles articles;

  NewsItemHorizontal(this.articles);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return OpenNews(articles);
            },
          ),
        );
      },
      child: Container(
        height: 240,
        width: 220,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 229, 229, 229),
          image: DecorationImage(
            image: articles.urlToImage != null
                ? NetworkImage(articles.urlToImage)
                : AssetImage("images/image_placeholder.png"),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color.fromARGB(200, 0, 0, 0),
              ],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  articles.title,
                  maxLines: 8,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Raleway",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   articles.description,
                // style: TextStyle(
                //   color: Colors.white,
                //   fontFamily: "Raleway",
                //   fontSize: 14,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewsItemVertical extends StatelessWidget {
  Articles newsArticle;

  NewsItemVertical(this.newsArticle);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return OpenNews(newsArticle);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 4,
          right: 4,
          top: 6,
          bottom: 6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(100, 0, 0, 0),
              //  spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 229, 229, 229),
                image: DecorationImage(
                  image: newsArticle.urlToImage != null
                      ? NetworkImage(newsArticle.urlToImage)
                      : AssetImage("images/image_placeholder.png"),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints.expand(
                  height: 100,
                ),
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: const EdgeInsets.only(top: 8, bottom: 4),
                          child: Text(
                            newsArticle.title,
                            maxLines: 4,
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      //   Align(
                      //     alignment: Alignment.topLeft,
                      //     child: Container(
                      //       child:Text("data",
                      //      style: TextStyle(
                      //       color: Colors.black,
                      //      fontFamily: "Raleway",
                      //      fontSize: 14,
                      //   ),
                      // ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _horizontalList(List<Articles> newsArticles) {
  return Container(
    height: 280,
    padding: const EdgeInsets.all(12),
    child: ListView.builder(
      itemBuilder: (context, index) => NewsItemHorizontal(newsArticles[index]),
      itemCount: 10,
      scrollDirection: Axis.horizontal,
    ),
    //   child:ListView(
    //   scrollDirection: Axis.horizontal,
    //   children: <Widget>[
    //     NewsItemHorizontal(),
    //     NewsItemHorizontal(),
    //     NewsItemHorizontal(),
    //     NewsItemHorizontal(),
    //     NewsItemHorizontal(),
    //     NewsItemHorizontal(),
    //     NewsItemHorizontal(),
    //   ],
    // ),
  );
}

Widget _verticalList() {
  return Expanded(
      child: Container(
        //height: 240,
        //alignment: Alignment.center,
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 6,
          bottom: 6,
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            // NewsItemVertical(),
            // NewsItemVertical(),
            // NewsItemVertical(),
            // NewsItemVertical(),
            // NewsItemVertical(),
            // NewsItemVertical(),
            // NewsItemVertical(),
          ],
        ),
      ));
}

// Container(
//         alignment: Alignment.centerLeft,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
// Container(
//   height: 240,
//   padding: const EdgeInsets.all(12),
//   child:ListView(
//   scrollDirection: Axis.horizontal,
//   children: <Widget>[
//     NewsItemHorizontal(),
//     NewsItemHorizontal(),
//     NewsItemHorizontal(),
//     NewsItemHorizontal(),
//     NewsItemHorizontal(),
//     NewsItemHorizontal(),
//     NewsItemHorizontal(),
//   ],
// ),
// ),
//             Expanded(
//               child: Container(
//   alignment: Alignment.topCenter,
//   child: ListView(
//   scrollDirection: Axis.vertical,
//   children: <Widget>[
//     NewsItemVertical(),
//     NewsItemVertical(),
//     NewsItemVertical(),
//     NewsItemVertical(),
//     NewsItemVertical(),
//     NewsItemVertical(),
//     NewsItemVertical(),
//   ],
// ),
// ),
//             ),
//           ],
//         ),
//       )
