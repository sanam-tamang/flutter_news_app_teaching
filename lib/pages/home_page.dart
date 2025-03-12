// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapi/models/news_model.dart';
import 'package:newsapi/pages/news_detail_page.dart';
import 'package:newsapi/repositories/news_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = ["Business", "Health", "Science", "Sports"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length, 
      child: Scaffold(
        appBar: AppBar(
          title: Text("News app"),

          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs:
                categories.map((category) {
                  return Tab(child: Text(category));
                }).toList(),
          ),
        ),

        body: TabBarView(
          children:
              categories.map((category) {
                return NewsBody(category: category);
              }).toList(),
        ),
      ),
    );
  }
}

class NewsBody extends StatelessWidget {
  const NewsBody({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NewsRepository().getAllNews(category),
      builder: (context, snapshot) {
        //##LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        //##Error
        else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        //##DATA or NEWS
        final List<News>? news = snapshot.data;
        return ListView.builder(
          itemCount: news?.length,
          itemBuilder: (context, index) {
            final singleNews = news![index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewsDetailPage(news: singleNews),
                  ),
                );
              },
              child: NewsCard(singleNews: singleNews),
            );
          },
        );
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.singleNews});

  final News singleNews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              singleNews.imageUrl == null
                  ? SizedBox()
                  : CachedNetworkImage(
                    imageUrl: singleNews.imageUrl!,

                    errorWidget: (context, url, error) {
                      return Icon(Icons.error, color: Colors.red);
                    },
                    progressIndicatorBuilder: (context, url, progress) {
                      return CircularProgressIndicator(
                        value: progress.progress,
                      );
                    },
                  ),

              Text(
                singleNews.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),

              Text(
                singleNews.source ?? "Unknown",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class NewsCard extends StatelessWidget {
//   const NewsCard({super.key, required this.singleNews});

//   final News singleNews;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(8),
//         child: Column(
//           children: [
//             singleNews.imageUrl == null
//                 ? SizedBox()
//                 : Image.network(singleNews.imageUrl!),

//             Text(
//               singleNews.title,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),

//             Text(
//               singleNews.source ?? "unknown",
//               style: TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
