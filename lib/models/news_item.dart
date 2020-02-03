import 'package:flutter/material.dart';
import 'news.dart';

class NewsListItem extends StatelessWidget {
  final NewsArticle newsArticle;

  NewsListItem(this.newsArticle);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250.0,
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ));
  }
}
