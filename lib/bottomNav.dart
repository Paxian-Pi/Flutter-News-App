import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/views/bottomNav/account_view.dart';
import 'package:news_app/views/bottomNav/favorite_view.dart';
import 'package:news_app/views/bottomNav/home_view.dart';
import 'package:news_app/views/bottomNav/search_view.dart';

import 'models/news_api_test.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  Future<NewsAPITest> _getNews() async {
    const newsUrl =
        "https://newsapi.org/v2/everything?q=keyword&apiKey=a4be9f9b5c6e48629e7a34d7e4b40770";

    var dio = Dio();
    final response = await dio.get(newsUrl);
    if (kDebugMode) print(response.data);

    if (response.statusCode == 200) {
      final jsonNews = jsonDecode(response.data);
      return NewsAPITest.fromJson(jsonNews);
    } else {
      throw Exception();
    }
  }

  void _getHttp() async {
    try {
      const newsUrl =
          "https://newsapi.org/v2/everything?q=keyword&apiKey=a4be9f9b5c6e48629e7a34d7e4b40770";
      var response = await Dio().get(newsUrl);
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _bottomNavView = [
    const HomeView(),
    const SearchView(),
    const FavoriteView(),
    const AccountView(),
  ];

  @override
  void initState() {
    super.initState();

    _getNews();
    // _getHttp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _bottomNavView.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: _navBarList
            .map(
              (e) => BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  e.icon,
                  width: 24.0,
                ),
                activeIcon: SvgPicture.asset(
                  e.activeIcon,
                  width: 24.0,
                ),
                label: e.title,
              ),
            )
            .toList(),
      ),
    );
  }
}

class NavBarItem {
  final String icon;
  final String activeIcon;
  final String title;

  NavBarItem(
      {required this.icon, required this.activeIcon, required this.title});
}

List<NavBarItem> _navBarList = [
  NavBarItem(
    icon: "assets/home.svg",
    activeIcon: "assets/home_2.svg",
    title: "Home",
  ),
  NavBarItem(
    icon: "assets/search.svg",
    activeIcon: "assets/search_2.svg",
    title: "Search",
  ),
  NavBarItem(
    icon: "assets/favorite.svg",
    activeIcon: "assets/favorite_2.svg",
    title: "Favorite",
  ),
  NavBarItem(
    icon: "assets/account.svg",
    activeIcon: "assets/account_2.svg",
    title: "Account",
  ),
];
