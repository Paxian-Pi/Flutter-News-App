import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/views/read_news_view.dart';
import 'package:news_app/widgets/primary_card.dart';
import 'package:news_app/widgets/secondary_card.dart';

class BreakingTabView extends StatelessWidget {
  const BreakingTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: double.infinity,
          height: 300.0,
          padding: const EdgeInsets.only(left: 18.0),
          child: ListView.builder(
            // This 'breakingNewsList' value comes from a dummy-news-list class
            itemCount: breakingNewsList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var news = breakingNewsList[index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReadNewsView(news: news),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12.0),
                  child: PrimaryCard(news: news),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 25.0),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 19.0),
            child: Text("BASED ON YOUR READING HISTORY",
                style: kNonActiveTabStyle),
          ),
        ),
        ListView.builder(
          // This 'breakingNewsList' value comes from a dummy-news-list class
          itemCount: recentList.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            var recent = recentList[index];

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadNewsView(news: recent),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 135.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: SecondaryCard(news: recent),
              ),
            );
          },
        )
      ],
    );
  }
}
