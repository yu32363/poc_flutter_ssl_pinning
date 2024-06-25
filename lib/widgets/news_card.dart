import 'package:flutter/material.dart';

import 'package:poc_flutter_ssl_pinning/model/article.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: article.urlToImage != null
                  ? Image.network(article.urlToImage!, fit: BoxFit.cover)
                  : Container(),
            ),
            Text(
              article.title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(article.description != null
                ? article.description!
                : 'No description'),
          ],
        ),
      ),
    );
  }
}
