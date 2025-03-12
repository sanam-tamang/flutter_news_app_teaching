class News {
  final String? source;
  final String title;
  final String? content;
  final String? imageUrl;
  final String publishedAt;
  News({
    this.source,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      content: json['content'],
      publishedAt: json['publishedAt'],
      source: json['source']['name'],
      imageUrl: json['urlToImage'],
    );
  }

  
}
