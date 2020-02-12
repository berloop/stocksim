import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'news.dart';


class NewsListItem extends StatelessWidget {
  final NewsArticle newsArticle;

  NewsListItem(this.newsArticle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Card(
        elevation: 4.0,
        child: ListTile(
          onTap: () async {
            if (await canLaunch(newsArticle.url)) {
              await launch(newsArticle.url);
            } else {
              throw 'Could not launch ' + newsArticle.url;
            }
          },
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          trailing: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Container(
              width: MediaQuery.of(context).size.width * .2,
              height: 600.0,
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/gif/loading.gif',
                image: newsArticle.urlToImage,
              ),
            ),
          ),
          title: Column(
            children: <Widget>[
              Text(
                newsArticle.title,
                style: TextStyle(fontFamily: 'Lato Bold'),
              ),
              Text(
                newsArticle.description,
                style: TextStyle(fontFamily: 'Lato Medium', fontSize: 12.0),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  //shortening the URL...
                  newsArticle.url.substring(0, 37) + "....",
                  style: TextStyle(fontFamily: 'Lato Medium', fontSize: 10.0),
                ),
                SizedBox(width: 1.0),
              ],
            ),
          ),
          isThreeLine: false,
          // leading: Padding(
          //   padding: const EdgeInsets.only(top: 6.0),
          //   child: Icon(Icons.keyboard_arrow_right),
          // ),
        ),
      ),
    );
  }
}

// Image.network(photos[index].thumbnailUrl)

// Image(
//                 fit:BoxFit.contain,
//                 alignment: Alignment.topRight,
//                 image: NetworkImage(newsArticle.urlToImage),
//               ),

// FadeInImage.memoryNetwork(
//   placeholder: kTransparentImage,
//   image: 'https://picsum.photos/250?image=9',
// );
