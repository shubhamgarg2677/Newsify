
import 'package:flutter/material.dart';
import 'package:newsify/BookmarkPage/BookmarkModel.dart';
import 'package:newsify/BookmarkPage/BookmarkPage.dart';
import 'package:newsify/Main_page/HomePage.dart';
import 'package:newsify/ProfilePage/ProfilePageClass.dart';
import 'package:newsify/SearchPage/SearchBoxClass.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BookmarkModel(),
      child: MyApp(),
    ),
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newsify',
      color: Colors.white,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
int _selectedIndex=0;

 void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

List<Widget> widgetList=<Widget>
[
  HomePage(),
  SearchBoxClass(),
  BookmarkPage(),
  ProfilePage(),
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      // body: ListClass(getTitleData()),
      body: DefaultTabController(
        length: 4,
         child: Scaffold(
          
             backgroundColor: Colors.white,
             body: widgetList.elementAt(_selectedIndex),
             
             bottomNavigationBar: BottomNavigationBar(
               backgroundColor: Colors.white,
               type: BottomNavigationBarType.shifting,
               showSelectedLabels: false,
               showUnselectedLabels: false,
               selectedItemColor: Colors.black,
               selectedLabelStyle: TextStyle(
                 color:Colors.black,
               ),
               selectedIconTheme: IconThemeData(
                 color: Colors.black,
               ),
               unselectedLabelStyle: TextStyle(
                 color:Colors.grey,
               ),
               unselectedItemColor: Colors.grey,
               unselectedIconTheme: IconThemeData(
                 color: Colors.grey,
               ),
               currentIndex: _selectedIndex,
               onTap: _onItemTapped,
               items: const <BottomNavigationBarItem>[
                 BottomNavigationBarItem(
                   icon: Icon(Icons.home),
                   activeIcon: Icon(Icons.home),
                   title: Text("Home",
                   style: TextStyle(fontSize: 16,fontFamily: "Raleway",),
                   ),
                   ),
                   BottomNavigationBarItem(
                   icon: Icon(Icons.search),
                   activeIcon: Icon(Icons.search),
                   title: Text("Search"),
                   ),
                   BottomNavigationBarItem(
                   icon: Icon(Icons.bookmark_border),
                   activeIcon: Icon(Icons.bookmark),
                   title: Text("Bookmarks"),
                   ),
                   BottomNavigationBarItem(
                   icon: Icon(Icons.person_outline),
                   activeIcon: Icon(Icons.person),
                   title: Text("Profile"),
                   ),
               ],
               ),
          //  bottomNavigationBar: TabBar(
          //    labelColor: Colors.black,
          //    unselectedLabelColor: Colors.grey,
          //    labelStyle: TextStyle(
               
          //    ),
          //    indicatorWeight: 1,
          //    indicatorSize: TabBarIndicatorSize.label,
          //    indicatorColor: Colors.white,
          //    tabs: [
          //      Tab(
          //        icon:Icon(Icons.person_outline,),
          //        text: "Home",
          //        ),
          //        Tab(
          //          icon: Icon(Icons.search),
          //        ),
          //        Tab(
          //          icon: Icon(Icons.bookmark_border),
          //        ),
          //        Tab(
          //          icon: Icon(Icons.account_circle),
          //        ),
          //    ],
          //    ),
         ),
         ),
    );
  }
}



