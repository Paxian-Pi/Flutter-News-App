import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/views/read_news_view.dart';
import 'package:news_app/widgets/primary_card.dart';

class TrendingTabView extends StatelessWidget {
  const TrendingTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // This 'trendingList' value comes from a dummy-news-list class
      itemCount: trendingList.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var trending = trendingList[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReadNewsView(news: trending),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 300.0,
            margin:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
            child: PrimaryCard(news: trending),
          ),
        );
      },
    );
  }
}
