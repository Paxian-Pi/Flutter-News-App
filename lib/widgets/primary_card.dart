import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/models/dummy_news_model.dart';

class PrimaryCard extends StatelessWidget {
  final DummyNewsModel news;

  const PrimaryCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: kGrey3, width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 5.0,
                backgroundColor: kGrey1,
              ),
              const SizedBox(width: 10.0),
              Text(news.category, style: kCategoryTitle)
            ],
          ),
          const SizedBox(height: 5.0),
          Expanded(
            child: Hero(
              tag: news.seen,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(news.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            news.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: kTitleCard,
          ),
          const SizedBox(height: 5.0),
          Row(
            children: [
              Text(
                news.time,
                style: kDetailContent,
              ),
              const SizedBox(width: 10.0),
              const CircleAvatar(
                radius: 5.0,
                backgroundColor: kGrey1,
              ),
              const SizedBox(width: 10.0),
              Text("${news.estimate} min read", style: kDetailContent)
            ],
          )
        ],
      ),
    );
  }
}
