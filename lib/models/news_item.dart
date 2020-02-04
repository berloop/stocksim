import 'package:flutter/material.dart';
import 'news.dart';

class NewsListItem extends StatelessWidget {
  final NewsArticle newsArticle;

  NewsListItem(this.newsArticle);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250.0,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Stack(children: <Widget>[
              Container(
                height: 170.0,
                width: 250.0,
                child: Image.asset(newsArticle.urlToImage, fit: BoxFit.cover),
                decoration:
                    BoxDecoration(color: Colors.black12.withOpacity(.2)),
              ),
            ])));
  }
}

// Image.network(photos[index].thumbnailUrl)