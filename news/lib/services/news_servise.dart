import 'dart:convert';

import 'package:news/models/articles.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/news.dart';

class NewsService {
  Future<List<Articles>> fetchNews(String category) async {
    String Url =
        'https://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=b1b6d4b1ba254664ae77314603bb27cb';
    Uri uri = Uri.parse(Url);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      News news = News.fromJson(result);
      return news.articles ?? [];
    }
    throw Exception('Bad Request');
  }
}
