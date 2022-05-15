import 'package:flutter/material.dart';
import 'package:news_app/models/dummy_news_model.dart';
import 'package:news_app/views/read_news_view.dart';
import 'package:news_app/widgets/secondary_card.dart';

class SocialTabView extends StatelessWidget {
  const SocialTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // This 'recentList' value comes from a dummy-news-list class
      itemCount: recentList.length,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var social = recentList[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReadNewsView(news: social),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 135.0,
            margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: SecondaryCard(news: social),
          ),
        );
      },
    );
  }
}
