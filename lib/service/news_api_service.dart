import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:poc_flutter_ssl_pinning/constant/api_key.dart';
import 'package:poc_flutter_ssl_pinning/model/article.dart';
import 'package:poc_flutter_ssl_pinning/model/news_response.dart';

class NewsApiService {
  NewsApiService(this.client);

  final http.Client client;

  Future<List<Article>> fetchArticle() async {
    final uri = Uri.parse('$baseUrl/everything?q=flutter&apiKey=$apiKey');
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      return NewsResponse.fromJson(json.decode(response.body)).articles;
    } else {
      throw Error();
    }
  }
}
