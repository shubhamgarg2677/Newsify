import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:newsify/BookmarkPage/BookmarkDatabase.dart';
import 'package:newsify/BookmarkPage/BookmarkModel.dart';
import 'package:newsify/Main_page/NewsPage.dart';
import 'package:newsify/Model/Articles.dart';
import 'package:newsify/Model/BookmarkDatabaseModel.dart';
import 'package:newsify/OpenNews/OpenNews.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return BookmarkState();
  }
  
}

class BookmarkState extends State<BookmarkPage>
{
  
  bool bookmarPresent=false;
  BookMarkDatabase bookMarkDatabase;
  List<BookmarkDatabaseModel> dataList=new List();

  @override
  void initState() {
    // TODO: implement initState
    bookMarkDatabase=new BookMarkDatabase();
    bookMarkDatabase.startData();
    bookMarkDatabase.getData().then((value) => _setData(value));
//    dataList=(List)bookMarkDatabase.getData();

    super.initState();
  }

  _setData(List<BookmarkDatabaseModel> data)
  {
    dataList=data;
    //print(dataList[0].toJson());
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    
//   var _bookmarks = Provider.of<BookmarkModel>(context);
//   if(_bookmarks.items.length>0)
//   {
//     bookmarPresent=true;
//   }
//   else{
//     bookmarPresent=false;
//   }
//   print(bookmarPresent);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title:Container(
              color: Colors.white,
              //margin: const EdgeInsets.only(left:20,right: 20,top: 20),
              child:  Text("Bookmarks",
               style: TextStyle(
               color: Colors.black,
                fontFamily:"Raleway",
                fontSize: 32,
                fontWeight: FontWeight.bold,
                 ),
               ),
              ),
      ),
      body: dataList.length>0 ?
            BookmarkList(dataList) :
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20),
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Image.asset("images/empty_list_image.jpg"),
                      Text("NO BOOKMARK ADDED"),
                    ],
                  ) ,
                ),
              ],
            ),
//      Consumer<BookmarkModel>(
//        builder: (context,bookmark,child)=> bookmark.items.length>0 ?
//        BookmarkList(bookmark.items) :
//        Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//          Container(
//            margin: const EdgeInsets.all(20),
//            alignment: Alignment.topCenter,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              mainAxisSize: MainAxisSize.max,
//              children: <Widget>[
//                Image.asset("images/empty_list_image.jpg"),
//                Text("NO BOOKMARK ADDED"),
//              ],
//            ) ,
//          ),
//          ],
//        ),
//        ),
    );

    // return Container(
    //   padding: const EdgeInsets.all(20),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.max,
    //     children: <Widget>[
    //       Container(
    //         alignment: Alignment.topLeft,
    //         margin: const EdgeInsets.only(top: 10),
    //         child:Text("Bookmarks",
    //            style: TextStyle(
    //            color: Colors.black,
    //             fontFamily:"Raleway",
    //             fontSize: 32,
    //             fontWeight: FontWeight.bold,
    //              ),
    //            ),
    //       ),
    //       Container(
    //         margin: const EdgeInsets.all(20),
    //         alignment: Alignment.topCenter,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           mainAxisSize: MainAxisSize.max,
    //           children: <Widget>[
    //             Image.asset("images/empty_list_image.jpg"),
    //             Text("NO BOOKMARK ADDED"),
    //           ],
    //         ) ,
    //       ),
    //     ],
    //   ),
    // );
  }
}
class BookmarkList extends StatefulWidget
{
  List<BookmarkDatabaseModel> data;
  BookmarkList(this.data);
  @override
  State<StatefulWidget> createState() {
    return bookmarkState(data);
  }
  
}
class bookmarkState extends State<BookmarkList>
{
  List<BookmarkDatabaseModel> data;
  bookmarkState(this.data);
  @override
  Widget build(BuildContext context) {
    print("---->${data.length}");
    return Padding(
        padding: const EdgeInsets.only(left: 12,right: 12),
        child:ListView.builder(
      itemCount: data.length,
      itemBuilder: (context,index)=> BookmarkNews(data[index]),
     ),
    ); 

  }

}


class BookmarkNews extends StatelessWidget
{
  BookmarkDatabaseModel newsArticle;
  BookmarkNews(this.newsArticle);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_){
              return OpenNews(new Articles(null, newsArticle.author, newsArticle.title, newsArticle.description, newsArticle.url, newsArticle.urlToImage, newsArticle.publishedAt, newsArticle.content));
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
        child:Row(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 229, 229, 229),
                image: DecorationImage(
                  image: newsArticle.urlToImage!=null?NetworkImage(newsArticle.urlToImage):AssetImage("images/image_placeholder.png"),
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
                child:Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: const EdgeInsets.only(top: 8,bottom: 4),
                          child:Text(
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
        ) ,
      ),
    );
  }

}
