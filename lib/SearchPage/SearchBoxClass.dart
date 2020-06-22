
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsify/Main_page/NewsPage.dart';
import 'package:newsify/Model/Articles.dart';
import 'package:newsify/Model/News.dart';
import 'package:http/http.dart' as http;

class SearchBoxClass extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return SearchBoxState();
  }
  
}

class SearchBoxState extends State<SearchBoxClass>
{
  TextEditingController controller=new TextEditingController();
  Future<News> newsList;

  @override
  void initState() {
    // TODO: implement initState
    controller.addListener(() {
      print("this is text ${controller.text}");
      if(controller.text.length>1)
      {
        setState(() {
          newsList=_callSearchapi(controller.text);
        });
      }
      else{
        setState(() {
          newsList=null;
        });
      }
    });
    super.initState();
  }


  Future<News>_callSearchapi(String query) async
  {
    var response;
    String url="https://newsapi.org/v2/top-headlines?q=${query}&apiKey=ee0ed53a336240119a1f657c9bf9d5ef";
    response=await http.get(url);
    if(response.statusCode==200)
    {
      print("bcj "+response.toString());
      return News.fromJson(json.decode(response.body));
    }
    else{
      print("bcj error"+response.toString());
      throw Exception('Failed to load News');
    }
  }

  Widget _serchWidget()
  {
   return FutureBuilder<News>(
     future: newsList,
     builder: (context,snapshot)
     {
       switch(snapshot.connectionState)
       {
         case ConnectionState.waiting:
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

         case ConnectionState.done:
           return _verticalList(snapshot.data.articles);

         default:
            if (snapshot.hasError) {
             return Text("${snapshot.error}");
           }else{
             return Text("");
           }
       };
     },
   );
  }

  Widget _verticalList(List<Articles> articles)
  {
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
          child: ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index)
            {
              return NewsItemVertical(articles[index]);
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title:Container(
              color: Colors.white,
              //margin: const EdgeInsets.only(left:20,right: 20,top: 20),
              child:  Text("Search News",
               style: TextStyle(
               color: Colors.black,
                fontFamily:"Raleway",
                fontSize: 32,
                fontWeight: FontWeight.bold,
                 ),
               ),
              ),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.all(20),
              
              //height: 60,
              //padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255,229, 229, 229),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: TextField(
                            keyboardType: TextInputType.text,
                            controller: controller,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search,color: Colors.grey,),
                              
                              fillColor:Color.fromARGB(255,229, 229, 229),
                              focusColor: Color.fromARGB(255,229, 229, 229),
                              hoverColor: Color.fromARGB(255,229, 229, 229),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all( Radius.circular(12)),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255,229, 229, 229),
                                  width: 2, 
                                ),
                              ),
                          
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all( Radius.circular(12)),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255,229, 229, 229),
                                  width: 2, 
                                ),
                              ) ,
                        
                            ),
                          ),
            ),
            _serchWidget(),
          ],
        ),
    );
    // return Column(
    //   children: <Widget>[
        // Container(
        //   alignment: Alignment.centerLeft,
        //       color: Colors.white,
        //       margin: const EdgeInsets.only(left:20,right: 20,top: 30),
        //       child:  Text("Search News",
        //        style: TextStyle(
        //        color: Colors.black,
        //         fontFamily:"Raleway",
        //         fontSize: 32,
        //         fontWeight: FontWeight.bold,
        //          ),
        //        ),
        //       ),
        // Container(
        //       alignment: Alignment.topCenter,
        //       margin: const EdgeInsets.all(20),
              
        //       //height: 60,
        //       //padding: const EdgeInsets.all(20),
        //       decoration: BoxDecoration(
        //         color: Color.fromARGB(255,229, 229, 229),
        //         borderRadius: BorderRadius.all(Radius.circular(12)),
        //       ),
        //       child: TextField(
        //                     keyboardType: TextInputType.text,
        //                     textInputAction: TextInputAction.search,
        //                     decoration: InputDecoration(
        //                       hintText: "Search",
        //                       prefixIcon: Icon(Icons.search,color: Colors.grey,),
                              
        //                       fillColor:Color.fromARGB(255,229, 229, 229),
        //                       focusColor: Color.fromARGB(255,229, 229, 229),
        //                       hoverColor: Color.fromARGB(255,229, 229, 229),
        //                       enabledBorder: OutlineInputBorder(
        //                         borderRadius: BorderRadius.all( Radius.circular(12)),
        //                         borderSide: BorderSide(
        //                           color: Color.fromARGB(255,229, 229, 229),
        //                           width: 2, 
        //                         ),
        //                       ),
                          
        //                       focusedBorder: OutlineInputBorder(
        //                         borderRadius: BorderRadius.all( Radius.circular(12)),
        //                         borderSide: BorderSide(
        //                           color: Color.fromARGB(255,229, 229, 229),
        //                           width: 2, 
        //                         ),
        //                       ) ,
                        
        //                     ),
        //                   ),
        //     ),
    //   ],
    // ); 
  }
  
}