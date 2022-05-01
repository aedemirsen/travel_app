import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:language_builder/language_builder.dart';
import 'package:travel_app/configuration/config.dart';
import 'package:travel_app/operation/math_operation.dart';
import 'package:travel_app/test.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //button state
  bool _buttonVisible;
  //search bar state
  bool _searchBarVisible;
  //dropdown state
  bool _dropDownVisible;

  double _scrollLen;

  //all texts using in this class
  Map<String, dynamic> _texts;

  void initState() {
    super.initState();
    _buttonVisible = true;
    _searchBarVisible = true;
    _dropDownVisible = false;
    _texts = LanguageBuilder.texts['sliver_app_bar'];
    _scrollLen = MainPageConf.maxDelegatedHeightForSliverBar;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Screen.width,
      height: Screen.height,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _sliverAppBar(),
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: _SliverAppBarDelegate(),
              ),
            ],
          ),
          Visibility(
            visible: _dropDownVisible,
            child: _dropDown(
              MainPageConf.dropDownTopInset,
              MainPageConf.dropDownLeftInset,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sliverAppBar() {
    return SliverAppBar(
      backgroundColor: MainPageConf.sliverAppBarBackground,
      expandedHeight: MainPageConf.expandedSliverBarHeight,
      stretch: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          //update while scrolling
          _scrollLen = constraints.biggest.height;
          if (_scrollLen < MainPageConf.searchBarVisibilityReference) {
            _searchBarVisible = false;
          } else {
            _searchBarVisible = true;
          }
          if (_scrollLen < MainPageConf.buttonVisibilityReference) {
            _buttonVisible = false;
          } else {
            _buttonVisible = true;
          }
          return Stack(
            children: [
              FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.zoomBackground,
                  //StretchMode.blurBackground,
                  StretchMode.fadeTitle
                ],
                collapseMode: CollapseMode.pin,
                background: AnimatedOpacity(
                  duration: Duration.zero,
                  opacity: MathOps.reduceZeroToOne(
                    MainPageConf.maxDelegatedHeightForSliverBar,
                    _scrollLen,
                  ),
                  child: Stack(
                    children: [
                      _swiper(),
                      Positioned(
                        bottom: MainPageConf.buttonInset,
                        left: MainPageConf.buttonInset,
                        child: Visibility(
                          visible: _buttonVisible,
                          child: _button(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _searchBarVisible,
                child: _searchBar(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _searchBar() {
    return Positioned(
      left: MainPageConf.searchBarLeftInset,
      top: MainPageConf.searchBarTopInset,
      child: Container(
        width: MainPageConf.searchBarWidth,
        height: MainPageConf.searchBarHeight,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(30),
        ),
        child: CupertinoSearchTextField(
          onChanged: (text) {
            bool _visible = true;
            if (text.isEmpty) _visible = false;
            setState(() {
              _dropDownVisible = _visible;
            });
          },
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(30),
          ),
          prefixInsets: EdgeInsets.only(left: 15),
          suffixInsets: EdgeInsets.only(right: 15),
          itemColor: CupertinoColors.black.withOpacity(0.7),
          placeholder: _texts['search_hint'],
          placeholderStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7),
            letterSpacing: 1,
            fontSize: 15,
            fontFamily: AppTheme.fontFamily,
          ),
        ),
      ),
    );
  }

  Widget _swiper() {
    return Swiper(
      itemCount: TEST.slides.length,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                TEST.slides.elementAt(index).url,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: MainPageConf.buttonInset * 2 + MainPageConf.buttonHeight,
              left: MainPageConf.buttonInset + 5,
              child: SizedBox(
                width: MainPageConf.buttonWidth * 1.5,
                child: Visibility(
                  visible: _buttonVisible,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TEST.slides.elementAt(index).location,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        TEST.slides.elementAt(index).info,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      autoplay: true,
      autoplayDelay: 5000,
      pagination: SwiperPagination(
        margin: new EdgeInsets.all(25.0),
        alignment: Alignment.bottomRight,
      ),
    );
  }

  Widget _button() {
    return Container(
      height: MainPageConf.buttonHeight,
      width: MainPageConf.buttonWidth,
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        borderRadius: BorderRadius.circular(30),
        color: Colors.blue.withOpacity(
          MathOps.reduceZeroToOne(
            MainPageConf.expandedSliverBarHeight,
            _scrollLen,
          ),
        ),
        child: Text(
          _texts['button'],
          softWrap: false,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _dropDown(topInset, leftInset) {
    return Padding(
      padding: EdgeInsets.only(
        top: topInset,
        left: leftInset,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30),
        ),
        width: MainPageConf.dropDownWidth,
        height: MainPageConf.dropDownHeight,
        child: ListView.builder(
          itemExtent: 55,
          itemCount: TEST.dropDownItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CupertinoButton(
                onPressed: () {},
                child: Text(
                  TEST.dropDownItems.elementAt(index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 0;
  @override
  double get maxExtent => MainPageConf.maxDelegatedHeightForSliverBar;

  //all texts using in this class

  Map<String, dynamic> _texts = LanguageBuilder.texts['list_views'];

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          header_1(),
          _locationsCards(),
          header_2(),
          _toursCards(),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }

  Widget header_1() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10.0),
        child: Text(
          _texts["label_1"],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 1,
            fontSize: 15,
            fontFamily: "Arial",
          ),
        ),
      ),
    );
  }

  Widget header_2() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10.0),
        child: Text(
          _texts["label_2"],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 1,
            fontSize: 15,
            fontFamily: "Arial",
          ),
        ),
      ),
    );
  }

  Widget _locationsCards() {
    return Container(
      color: Colors.transparent,
      height: MainPageConf.popularDestCardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: TEST.dests.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: MainPageConf.popularDestCardWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(
                      TEST.dests[TEST.dests.keys.elementAt(index)],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      TEST.dests.keys.elementAt(index),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 25,
                        fontFamily: "Arial",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _toursCards() {
    return Container(
      color: Colors.transparent,
      height: MainPageConf.popularTourCardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: TEST.dests.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: MainPageConf.popularTourCardWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(
                      TEST.dests[TEST.dests.keys.elementAt(index)],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      TEST.dests.keys.elementAt(index),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 25,
                        fontFamily: "Arial",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
