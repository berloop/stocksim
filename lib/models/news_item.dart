import 'package:flutter/material.dart';
import 'news.dart';

class NewsListItem extends StatelessWidget {
  final NewsArticle newsArticle;

  NewsListItem(this.newsArticle);

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Container(
          height: 80,
          width: 100,
          child: Image.network(newsArticle.urlToImage),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    newsArticle.title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyle(fontFamily: "Lato Bold", fontSize: 16),
                  ),
                  Text(
                    newsArticle.description,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                  )
                ]),
          ),
        )
      ],
    ));
  }


}
