
class NewsArticle {
  NewsSource source;
  String author;
  String title;
  String description;
  String urlToImage;
  String url;
  String publishedAt;
  String content;

 
  NewsArticle.fromJson(Map<String, dynamic> articleJson)
      : source = NewsSource.fromJson(articleJson['source']),
        author = articleJson['author'],
        title = articleJson['title'],
        description = articleJson['description'],
        urlToImage = articleJson['urlToImage'],
        url = articleJson['url'],
        publishedAt = articleJson['publishedAt'],
        content = articleJson['content'];
}

class NewsSource {
  String id;
  String name;

  NewsSource.fromJson(Map<String, dynamic> sourceJson)
      : id = sourceJson['id'],
        name = sourceJson['name'];
}

class News {
  String status;
  String error;
  int totalResults;
  List<NewsArticle> articles;

  News({this.status, this.articles});

  News.fromJson(Map<String, dynamic> newsJson)
      : status = newsJson['status'],
        articles = List.from(newsJson['articles'])
            .map((article) => NewsArticle.fromJson(article))
            .toList(),
        totalResults = newsJson['totalResults'],
        error = newsJson['error'];
}
