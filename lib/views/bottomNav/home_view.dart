import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/views/topNav/breaking_tab_view.dart';
import 'package:news_app/views/topNav/social_tab_view.dart';
import 'package:news_app/views/topNav/trending_tab_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "WELCOME",
                  textAlign: TextAlign.end,
                  style: kNonActiveTabStyle,
                ),
                subtitle: Text(
                  "Pius Ifodo",
                  textAlign: TextAlign.end,
                  style: kActiveTabStyle,
                ),
                trailing: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/pax.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: kGrey1,
                  unselectedLabelStyle: kNonActiveTabStyle,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  labelStyle: kActiveTabStyle.copyWith(fontSize: 25.0),
                  tabs: const [
                    Tab(text: "Breaking News"),
                    Tab(text: "Social"),
                    Tab(text: "Trending")
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BreakingTabView(),
            SocialTabView(),
            TrendingTabView(),
          ],
        ),
      ),
    );
  }
}
