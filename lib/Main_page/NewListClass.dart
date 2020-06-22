
import 'package:flutter/material.dart';
import 'package:newsify/Main_page/NewsPage.dart';

class NewListClass extends StatefulWidget
{
  List<String> dataList;
  NewListClass(this.dataList);
  @override
  State<StatefulWidget> createState() {
    return NewListclassState(dataList);
  }
}

class NewListclassState extends State<NewListClass> with SingleTickerProviderStateMixin
{
  int _lenght=0;
  int _initialPage=0;
  var isPageCanChanged = true;
  List<String> _data;
  List<Widget> widgetList=new List();
  List<Widget> _tabViewList=new List();

  NewListclassState(this._data);

  List<Widget> getWidget()
  {
    return widgetList;
  }
   List<Widget> getTabView()
  {
    return _tabViewList;
  }

  @override
  void initState() {

    super.initState();

    _lenght=_data.length;

    widgetList.clear();
    for(String k in _data)
    {
      widgetList.add(NewListData(k));
      _tabViewList.add(NewTabView(k));
    }

  }


int changeData(){
   _lenght=_data.length;
  return _lenght;
}
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: changeData(), 
      initialIndex: _initialPage,
    child:Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: TabBar(
            tabs: getWidget(),
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight:1,
          unselectedLabelStyle:TextStyle(
                  fontSize: 20,
                  fontFamily:"Raleway",
                  fontWeight: FontWeight.w500,
                ),
          labelStyle: TextStyle(
                  fontSize: 24,
                  fontFamily:"Raleway",
                  fontWeight: FontWeight.bold,
                ),
          ),
      ),
      body: TabBarView(
              children: getTabView(),
            ),
    ),
    );
  }

}

class NewListData extends StatelessWidget
{
  String dataText;
  NewListData(this.dataText);
  @override
  Widget build(BuildContext context) {
    return Tab(
      iconMargin: const EdgeInsets.all(0),
      text: dataText,
    );
  }
  
}

class NewTabView extends StatelessWidget
{
  String dataText;
  NewTabView(this.dataText);
  @override
  Widget build(BuildContext context) {
    return NewsPage(dataText);
  }
  
}