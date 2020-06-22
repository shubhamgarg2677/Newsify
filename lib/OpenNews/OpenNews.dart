
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsify/BookmarkPage/BookmarkDatabase.dart';
import 'package:newsify/BookmarkPage/BookmarkModel.dart';
import 'package:newsify/BookmarkPage/BookmarkPage.dart';
import 'package:newsify/Model/Articles.dart';
import 'package:newsify/Model/BookmarkDatabaseModel.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart';

class OpenNews extends StatefulWidget
{
  Articles articles;
  OpenNews(this.articles);
  @override
  State<StatefulWidget> createState() {
    return OpenNewsState(articles);
  }
}

class OpenNewsState extends State<OpenNews>
{
  Articles articles;
  OpenNewsState(this.articles);
  bool bookmark=false;
  BookMarkDatabase bookMarkDatabase;
  List<BookmarkDatabaseModel> dataList=new List();
  

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_extract_data() async {
    var response = await http.get(articles.url);

  // Covert Response to a Document. The utility function `responseToDocument` is provided or you can use own decoder/parser.
  var document = responseToDocument(response);


  // get metadata
  var data = MetadataParser.OpenGraph(document);
  print(data);

}

@override
  void initState() {
   // _extract_data();
  bookMarkDatabase=new BookMarkDatabase();
  bookMarkDatabase.startData();
  bookMarkDatabase.getData().then((value) {
    _setData(value);
  });
    super.initState();
  }

  _setData(List<BookmarkDatabaseModel> data)
  {
    dataList=data;
    //print(dataList[0].toJson());
    setState(() {

    });
  }

// @override
//   void setState(fn) {
//     super.setState(fn);
//      //bookmark=true;
//   }

  _bookmarkAdded()
  {

//     var bookmarkData = Provider.of<BookmarkModel>(context);
//     if(bookmarkData.items.length>0)
//    {
//      for(int k=0;k<bookmarkData.items.length;k++)
//      {
//        if(bookmarkData.items[k].title.compareTo(articles.title)==0)
//        {
//          bookmark=true;
//          break;
//        }
//        else{
//          bookmark=false;
//        }
//      }
//    }
//    if(!bookmark)
//    {
//      bookmarkData.add(articles);
//    }

  if(bookmark)
  {
    if(dataList.length>0)
    {
      for(int k=0;k<dataList.length;k++)
      {
        if(dataList[k].title.compareTo(articles.title)==0)
        {
          bookMarkDatabase.delData(dataList[k].id);
          dataList.removeAt(k);
          Fluttertoast.showToast(
              msg: "Bookmark Removed",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              backgroundColor: Colors.black87,
              fontSize: 16.0
          );
          _setState(dataList);
          break;
        }
        else{
         // bookmark=false;
        }
      }
    }
  }
  else{
    BookmarkDatabaseModel model;
    if(dataList.length>0)
    {
      print(dataList.length);
      int n=dataList.length;
      model=new BookmarkDatabaseModel(n,articles.author,articles.title,articles.description,articles.url,articles.urlToImage,articles.publishedAt,articles.content);
      bookMarkDatabase.addData(model);
    }
    else{
      model=new BookmarkDatabaseModel(0,articles.author,articles.title,articles.description,articles.url,articles.urlToImage,articles.publishedAt,articles.content);
      bookMarkDatabase.addData(model);
    }
    dataList.add(model);
    Fluttertoast.showToast(
        msg: "Bookmark Added",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Colors.black87,
        fontSize: 16.0
    );
    _setState(dataList);
  }
      // final bookmarks = BookmarkModel();
      // bookmarks.addListener(() {
      //  // bookmark=true;
      // });
      // bookmarks.add(articles);
  }

  _setState(List<BookmarkDatabaseModel> dataModel)
  {


    setState(() {
      dataList=dataModel;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            height: 450,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: articles.urlToImage!=null?NetworkImage(articles.urlToImage):AssetImage("images/image_placeholder.png"),
                fit: BoxFit.fill,
                ),
            ),
            // child: Image.network(
            //   articles.urlToImage,
            //   fit: BoxFit.fill,
            //   ),
          ),
          Container(
            height: 450,
            decoration: BoxDecoration(
               
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(0, 0, 0, 0),
                    Color.fromARGB(200, 0, 0, 0),
                  ],
                  ),
              ),
          ),
          ListView(
            //mainAxisAlignment: MainAxisAlignment.start,
            scrollDirection: Axis.vertical,
            // shrinkWrap: false,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  child: Container(
                      alignment: Alignment.topLeft,
                      height: 42,
                      width: 42,
                      margin: const EdgeInsets.only(left: 20,top: 40),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                      color: Color.fromARGB(150, 0, 0, 0),
                      borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 28,
                        ),
                      // child: IconButton(
                      //   icon: Icon(
                      //   Icons.keyboard_arrow_left,
                      //   color: Colors.white,
                      //   size: 28,
                      //   ),
                      //   iconSize: 42, 
                      //   onPressed:()=> Navigator.pop(context),
                      //   ),
                    ),
                    onTap: ()=> Navigator.pop(context),
                ), 
              ),
                
            Container(
              alignment: Alignment.bottomLeft,
              height: 260,
              padding: const EdgeInsets.only( left: 20,top: 20,right: 20),
              decoration: BoxDecoration(
               // color: Colors.yellow,
                // gradient: LinearGradient(
                //   begin: Alignment.center,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     Color.fromARGB(0, 0, 0, 0),
                //     Color.fromARGB(200, 0, 0, 0),
                //   ],
                //   ),
              ),
              child: Text(
                articles.title,
                maxLines: 7,
                textHeightBehavior: TextHeightBehavior(
                  applyHeightToLastDescent: true,
                ),
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none
                ),
                ),
            ),
            
            // Expanded(
            //   child: 
              Container(
                //color: Colors.red,
                margin: const EdgeInsets.only(bottom: 48),
                child:  Stack(
               alignment: Alignment.topRight,
               children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top:36),
                  padding: const EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32), 
                      topRight: Radius.circular(32),
                      ),
                  ),
                  child: Text(
                    articles.content!=null?articles.content:articles.description!=null?articles.description:"NO DETAILS FOUND",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Raleway",
                      color: Colors.black,
                      //fontStyle: FontStyle.normal,
                      //fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none
                    ),
                    ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: ()=>_bookmarkAdded(),
                      child:Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(100, 0, 0, 0),
                                //  spreadRadius: 1,
                                blurRadius: 8,
                              ),
                            ],
                      ),
                      child: _iconWidget(),
                      // child: bookmark ? scaffoldSnackbar(): Icon(
                      //   Icons.bookmark_border,
                      //   color: Colors.black,
                      //   size: 24,
                      //   ),
                    ),
                    ),
                    
                    GestureDetector(
                      onTap: (){
                        Share.share("Check out this NEWS found on Newsify "+articles.url, subject: "App for simplifying news for you");
                      },
                      child: Container(
                      margin: const EdgeInsets.only(left: 12,right: 40,top: 12,bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                         boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(100, 0, 0, 0),
                                //  spreadRadius: 1,
                                blurRadius: 8,
                              ),
                            ],
                      ),
                      child: Icon(
                        Icons.share,
                        color: Colors.black,
                        size: 24,
                        ),
                    ),
                    ),
                    
                  ],
                ),
              ],
            ),
            ),
           // ),
            
           
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              onTap: ()=>_launchURL(articles.url),
              child: Container(
              color: Colors.indigo,
              height: 48,
              padding: const EdgeInsets.only(left: 20,right: 20,top: 12,bottom: 12),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                          "See More About Here",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                          ),
                    flex: 6,
                    ),
                  Expanded(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    flex: 1,
                    ),
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

  Widget _iconWidget()
  {
    //var catalog = Provider.of<BookmarkModel>(context);
    if(dataList.length>0)
    {
      for(int k=0;k<dataList.length;k++)
      {
        if(dataList[k].title.compareTo(articles.title)==0)
        {
          bookmark=true;
          return scaffoldSnackbar();
        }
        else{
          bookmark=false;
        }
      }
    }
    return Icon(
                        Icons.bookmark_border,
                        color: Colors.black,
                        size: 24,
                        );
  }
  
}

class scaffoldSnackbar extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return Icon(
       Icons.bookmark,
      color: Colors.black,
      size: 24,
          );

  }

}