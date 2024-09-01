import 'package:flutter/material.dart';

import '../components/news_tile.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';
import 'article_page.dart';

// Assuming NewsArticle and NewsTile are defined elsewhere in your project
// and that ArticlePage is another widget in your project.

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsArticle> alrticles = [];
  // Define the test article
  final NewsArticle testArticle = NewsArticle(
    author: "Kojo Poet",
    title: "How to grow tomatoes.",
    description: "This article is about growing tomatoes.",
    urlToImage: "urlToImage",
    publishedAt: "publishedAt",
    content: "contents",
  );

  late Future<List<NewsArticle>> _futureNews;

  @override
  void initState() {
    super.initState();
    _futureNews = NewsService().fetchAgricultureNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(top: 20),
          child: const Row(
            children: [
              SizedBox(
                width: 10,
                // child: Image.asset('assets/logo.png'),
              ),
              Text(
                "News",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: _futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available'));
          } else {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticlePage(
                                article: article)) // Pass the callback),

                        );
                  },
                  child: NewsTile(
                    article: article,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
