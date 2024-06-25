import 'package:flutter/material.dart';

import 'package:poc_flutter_ssl_pinning/model/article.dart';
import 'package:poc_flutter_ssl_pinning/service/news_api_service.dart';
import 'package:poc_flutter_ssl_pinning/widgets/news_card.dart';

class NewsScreen extends StatelessWidget {
  final NewsApiService apiService;
  const NewsScreen({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App SSL Pinning'),
      ),
      body: FutureBuilder<List<Article>>(
        future: apiService.fetchArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.data != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final article = snapshot.data![index];
                  return NewsCard(article: article);
                },
                itemCount: snapshot.data?.length,
              ),
            );
          } else {
            return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text("Load data, please wait...")
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
