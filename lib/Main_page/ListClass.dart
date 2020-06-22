import 'package:flutter/material.dart';
import 'package:newsify/Main_page/NewsPage.dart';

class ListClass extends StatefulWidget
{
  List<String> dataList;
  ListClass(this.dataList);
  @override
  State<StatefulWidget> createState() {
    return ListclassState(dataList);
  }
}

class ListclassState extends State<ListClass> with SingleTickerProviderStateMixin
{
  PageController _controller=new PageController();
  TabController _tabController;
  int _lenght=0;
  //double currentPage=0.0;
  int _initialPage=0;
  var isPageCanChanged = true;
  List<String> _data;
  List<Widget> widgetList=new List();
  ListclassState(this._data);
  List<Widget> getWidget()
  {
    return widgetList;
  }


  @override
  void initState() {
    _lenght=_data.length;
    widgetList.clear();
    for(String k in _data)
    {
      widgetList.add(ListData(k));
    }
    _tabController=new TabController(length: widgetList.length, vsync: this);

    _tabController.addListener(() {//TabBar listener
             if (_tabController.indexIsChanging) {
               // determine whether TabBar switches
        print(_tabController.index);
        onPageChange(_tabController.index, pageController: _controller);
      }
    });

    super.initState();
  }

int changeData(){
   _lenght=_data.length;
  return _lenght;
}

void onPageChange(int index,{PageController pageController,TabController tabController}) async
{
      if (pageController != null) {//determine which switch is
      isPageCanChanged = false;
      _controller.animateToPage(index, duration: Duration(milliseconds: 500), curve:  Curves.ease);
             //Await _controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);//Wait for pageview to switch, then release pageivew listener
      isPageCanChanged = true;
    } else {
      _tabController.animateTo(index);
           //  mTabController.animateTo(index);//Switch Tabbar
    }
}


@override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // _controller.addListener(() { 
    //   setState(() { 
    //     currentPage=_controller.page;
    //   });
    // });

    return DefaultTabController(
      length: changeData(), 
      initialIndex: _initialPage,
    child:SizedBox(
      height: MediaQuery.of(context).size.height-197,
      child: Column(
        children: <Widget>[
          TabBar(
            tabs: getWidget(),
            controller: _tabController,
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

          labelPadding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          ),
          Expanded(
           // flex: 40,
            child: PageView.builder(
              itemBuilder: (context,position)
              {
                return NewsPage("");
              },
              controller: _controller,
              itemCount:changeData(),
              onPageChanged: (position)
              {
                if (isPageCanChanged) { 
                  // because the pageview switch will call back this method, it will trigger the switch tabbar operation, so define a flag, control pageview callback
                  onPageChange(position);
                }
              },
            ),
          ),
          
        ], 
      ),
    ),
    );
  }

}

class ListData extends StatelessWidget
{
  String dataText;
  ListData(this.dataText);
  @override
  Widget build(BuildContext context) {
    return Tab(
      text: dataText,
    );
  }
  
}