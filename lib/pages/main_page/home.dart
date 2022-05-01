import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/configuration/config.dart';
import 'package:travel_app/configuration/session.dart';
import 'package:travel_app/pages/profile/switcher.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _pages = [
    HomePage(),
    Switcher(),
  ];

  Color _homeColor;
  Color _profileColor;

  //with which page the app will start
  int _pageIndex;

  @override
  void initState() {
    super.initState();
    _pageIndex = 0;
    _homeColor = MainPageConf.homeButtonActive;
    _profileColor = MainPageConf.profileButtonDeactive;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //get data coming from child widget
    final _data = ModalRoute.of(context).settings.arguments as int;
    if (_data != null) {
      _pageIndex = _data;
      _homeColor = MainPageConf.homeButtonDeactive;
      _profileColor = MainPageConf.profileButtonActive;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: 2,
        initialIndex: _pageIndex,
        child: Column(
          children: [
            SizedBox(
              height: Screen.height - MainPageConf.menuBarHeight,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: _pages,
              ),
            ),
            _menuBar(MainPageConf.menuBarHeight),
          ],
        ),
      ),
    );
  }

  Widget _menuBar(double height) {
    return Container(
      decoration: BoxDecoration(
        color: MainPageConf.menuBarColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey[300],
          ),
        ),
      ),
      height: height,
      child: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: MainPageConf.homeButtonActive,
                width: 3.0,
              ),
              insets: EdgeInsets.fromLTRB(70.0, 0.0, 70.0, 5.0),
            ),
            tabs: [
              Tab(
                child: Icon(
                  MainPageConf.homeIcon,
                  size: 30,
                  color: _homeColor,
                ),
              ),
              Tab(
                child: Icon(
                  MainPageConf.profileIcon,
                  size: 30,
                  color: _profileColor,
                ),
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                setState(() {
                  _homeColor = MainPageConf.homeButtonActive;
                  _profileColor = MainPageConf.profileButtonDeactive;
                });
              } else if (index == 1) {
                setState(() {
                  _homeColor = MainPageConf.homeButtonDeactive;
                  _profileColor = MainPageConf.profileButtonActive;
                });
              }
              return _pages[index];
            },
          ),
        ],
      ),
    );
  }
}
