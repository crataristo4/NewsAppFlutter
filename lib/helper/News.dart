import 'dart:convert';

import 'package:mynewsapp/model/NewsArticleModel.dart';
import 'package:http/http.dart' as http;

class News {
  List<NewsArticleModel> newsList = [];

  //method to fetch news
  Future<void> getAllNews() async {
    String url =
        "http://newsapi.org/v2/everything?q=bitcoin&from=2020-05-15&sortBy=publishedAt&apiKey=9536f2ae49e14dd4af751a2d63a3a44e";

    var response = await http.get(url);

    //decode the response into a json object
    var jsonData = jsonDecode(response.body);

    //check if the status of the response is OK
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((item) {
//check if the imageUrl and description are not null
        if (item["urlToImage"] != null && item["description"] != null) {
          //create an object of type NewsArticles
          NewsArticleModel newsArticleModel = new NewsArticleModel(
              author: item["author"],
              title: item["title"],
              description: item["description"],
              url: item["url"],
              urlToImage: item["urlToImage"],
              content: item["content"]);

          //add data to news list
          newsList.add(newsArticleModel);
        }
      });
    }
  }
}

class CategoryNews {
  List<NewsArticleModel> categoryNewsList = [];

  //method to fetch news
  Future<void> getCategoryNews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=9536f2ae49e14dd4af751a2d63a3a44e";

    var response = await http.get(url);

    //decode the response into a json object
    var jsonData = jsonDecode(response.body);

    //check if the status of the response is OK
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((item) {
//check if the imageUrl and description are not null
        if (item["urlToImage"] != null && item["description"] != null) {
          //create an object of type NewsArticles
          NewsArticleModel newsArticleModel = new NewsArticleModel(
              author: item["author"],
              title: item["title"],
              description: item["description"],
              url: item["url"],
              urlToImage: item["urlToImage"],
              content: item["content"]);

          //add data to news list
          categoryNewsList.add(newsArticleModel);
        }
      });
    }
  }
}
