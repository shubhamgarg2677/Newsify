import 'package:flutter/material.dart';
import 'package:newsify/Main_page/ListClass.dart';

import 'NewListClass.dart';

class HomePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
  
    return HomePageState();
  }
  
}
class HomePageState extends State<HomePage>
{
  List<String> dataText=<String>[];
// List<String> getTitleData()
// {
 

//   return dataText;
// }

@override
  void initState() {
  dataText.add("Top News");
  dataText.add("Around Globe");
  dataText.add("In Nation");
  dataText.add("Bussiness");
  dataText.add("Technology");
  dataText.add("Entertainment");
  dataText.add("Sports");
  dataText.add("Science");
  dataText.add("Health"); 
    super.initState();
  }

@override
  void setState(fn) {

    super.setState(fn);
  }
 GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title:Container(
              color: Colors.white,
              //margin: const EdgeInsets.only(left:20,right: 20,top: 20),
              child:  Text("Daily News",
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
              Expanded(child: NewListClass(dataText)),
          ],
        ),
    );
    // return Container(
    //   color: Colors.white,
      // child:Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Container(
      //         color: Colors.white,
      //         margin: const EdgeInsets.only(left:20,top: 30),
      //         child: Icon(
      //           Icons.sort,size: 32,
      //           color: Colors.black,
      //           )
      //           ),
                
      //       Container(
      //         color: Colors.white,
      //         margin: const EdgeInsets.only(left:20,right: 20,top: 20),
      //         child:  Text("Daily News",
      //          style: TextStyle(
      //          color: Colors.black,
      //           fontFamily:"Raleway",
      //           fontSize: 32,
      //           fontWeight: FontWeight.bold,
      //            ),
      //          ),
      //         ),
      //         Expanded(child: NewListClass(dataText)),
      //     ],
      //   ),
    // );
  }
  
}